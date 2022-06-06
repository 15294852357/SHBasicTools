//
//  WebSocketManager.m
//  SocketRocket
//
//  Created by mac on 2017/9/18.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import "WebSocketManager.h"
#import <SocketRocket/SocketRocket.h>

@interface WebSocketManager ()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocket;

/**
 重连定时器
 */
@property (nonatomic, weak) NSTimer *reconnectTimer;

/**
 发送心跳包定时器
 */
@property (nonatomic, strong) NSTimer *pingTimer;

/**
 Socket 状态
 */
@property (nonatomic, assign) LZWebSocketStatus socketStatus;

/**
 消息接收类型
 */
@property (nonatomic, assign) LZWebSocketReceiveType socketReceiveType;


@end

@implementation WebSocketManager
{
    NSInteger _reconnectCounter;
}

- (instancetype)init {
    if (self = [super init]) {
        self.reconnectTimeInterval = 1;
        self.reconnectCount = 5;
    }
    return self;
}

+ (instancetype)sharedManager {
    static WebSocketManager *lz_WebSocketManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lz_WebSocketManager = [[self alloc]init];
    });
    return lz_WebSocketManager;
}

- (void)lz_connectSocketWithUrl:(NSString *)url delegate:(id <WebSocketManagerDelegate>)delegate {
    self.delegate = delegate;
    [self lz_connect:url];
}

//打开websocket
- (void)lz_connect:(NSString *)url {
    [self.webSocket close];
    self.webSocket.delegate = nil;
    [self openWebSocket:url];
    _reconnectCounter = 0;
}

- (void)lz_connect {
    [self.webSocket close];
    self.webSocket.delegate = nil;
    _reconnectCounter = 0;
    [self lz_initializeWithSRWebSocket];
}

- (void)openWebSocket:(id)params {
    NSString *urlStr = nil;
    if ([params isKindOfClass:[NSString class]]) {
        urlStr = (NSString *)params;
    }
    else if([params isKindOfClass:[NSTimer class]]){
        NSTimer *timer = (NSTimer *)params;
        urlStr = [timer userInfo];
    }
    
    self.urlString = urlStr;
    [self lz_initializeWithSRWebSocket];
}

- (void)lz_initializeWithSRWebSocket {
    if (!self.urlString && !self.urlString.length) {
        //url不能空
        NSException *exception = [NSException exceptionWithName:@"URL Error" reason:@"URL is empty." userInfo:nil];
        [exception raise];
    }
    
    self.webSocket = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:self.urlString]];
    self.webSocket.delegate = self;
    [self.webSocket open];
}


//断开连接
- (void)lz_disconnect {
    //取消重连
    [self lz_cancelSocketReconnect];
    [self.webSocket close];
    self.webSocket = nil;
}

//发送消息
- (void)lz_sendMessage:(id)data {
    switch (self.socketStatus) {
        case LZWebSocketStatusNotConnected:
        {
            //未连接不会去自动重连
            NSLog(@"未连接");
            if (self.delegate && [self.delegate respondsToSelector:@selector(lz_webSocket:sendMessageError:)]) {
                [self.delegate lz_webSocket:self sendMessageError:self.socketStatus];
            }
        }
            break;
        case LZWebSocketStatusConnected:
        case LZWebSocketStatusReceived:
        {
            [self.webSocket sendData:data error:nil];
        }
            break;
        case LZWebSocketStatusClosedByServer:
        case LZWebSocketStatusClosedByUser:
        {
            NSLog(@"已经关闭");
            if (self.delegate && [self.delegate respondsToSelector:@selector(lz_webSocket:sendMessageError:)]) {
                [self.delegate lz_webSocket:self sendMessageError:self.socketStatus];
            }
        }
            break;
        case LZWebSocketStatusFailed:
        {
            NSLog(@"连接失败");
            if (self.delegate && [self.delegate respondsToSelector:@selector(lz_webSocket:sendMessageError:)]) {
                [self.delegate lz_webSocket:self sendMessageError:self.socketStatus];
                //连接失败会自动重连
                [self lz_reconnect];
            }
        }
            break;
    }
}

/**
 发送心跳包

 @param data 心跳包信息
 @param sendInterval 发送的时间间隔
 */
- (void)lz_sendPing:(NSData *)data sendInterval:(NSTimeInterval)sendInterval {
    if (!self.pingTimer) {
        self.pingTimer = [NSTimer scheduledTimerWithTimeInterval:sendInterval target:self selector:@selector(lz_sendPing:sendInterval:) userInfo:self.urlString repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.pingTimer forMode:NSRunLoopCommonModes];
    }
    switch (self.socketStatus) {
        //未连接
        case LZWebSocketStatusNotConnected:
        {
            if (self.pingTimer) {
                [self.pingTimer invalidate];
                self.pingTimer = nil;
            }
            NSLog(@"socket服务未连接");
        }
            break;
        //成功后
        case LZWebSocketStatusConnected:
        case LZWebSocketStatusReceived:
        {
            [self.webSocket sendPing:data error:nil];
        }
            break;
        case LZWebSocketStatusFailed:
        case LZWebSocketStatusClosedByServer:
        {
            [self lz_reconnect];
        }
            break;
        case LZWebSocketStatusClosedByUser:
        {
            NSLog(@"用户已关闭Socket服务");
        }
            break;
    }
}


//重连
- (void)lz_reconnect {
    self.webSocket = nil;
    if (_reconnectCounter < self.reconnectCount - 1) {
        _reconnectCounter ++;
        if (self.socketStatus == LZWebSocketStatusConnected || self.socketStatus == LZWebSocketStatusReceived) return;
        // 开启定时器
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.reconnectTimeInterval target:self selector:@selector(openWebSocket:) userInfo:self.urlString repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.reconnectTimer = timer;
    }
    else {
        [self lz_cancelSocketReconnect];
    }
}

/**
 取消延时重连和心跳包
 */
- (void)lz_cancelSocketReconnect {
    if (self.reconnectTimer) {
        [self.reconnectTimer invalidate];
        self.reconnectTimer = nil;
        NSLog(@"已经取消重连");
    }
    if (self.pingTimer) {
        [self.pingTimer invalidate];
        self.pingTimer = nil;
        NSLog(@"已经取消发送心跳");
    }
}

#pragma mark - SRWebSocketDelegate

//已经收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
//    NSLog(@":( Websocket Receive With message %@", message);
    self.socketStatus = LZWebSocketStatusReceived;
    self.socketReceiveType = LZWebSocketReceiveTypeMessage;
    if (self.delegate && [self.delegate respondsToSelector:@selector(lz_webSocket:didReceiveMessage:)]) {
        [self.delegate lz_webSocket:self didReceiveMessage:message];
    }
}

//已经打开
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    self.socketStatus = LZWebSocketStatusConnected;
    // 开启成功后重置重连计数器
    _reconnectCounter = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(lz_webSocketDidConnect:)]) {
        [self.delegate lz_webSocketDidConnect:self];
    }
}

//连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@":( Websocket Failed With Error %@", error);
    self.socketStatus = LZWebSocketStatusFailed;
    if (self.delegate && [self.delegate respondsToSelector:@selector(lz_webSocketConnectError:)]) {
        [self.delegate lz_webSocketConnectError:self];
    }
    [self performSelector:@selector(lz_reconnect) withObject:nil afterDelay:5];
//    [self reconnect];
}

//已经关闭
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"Closed Reason:%@  code = %zd",reason,code);
    if (reason) {
        self.socketStatus = LZWebSocketStatusClosedByServer;
        //此处不再重连，用户可以自己进行判断，是否重连
//        [self reconnect];
    } else {
        self.socketStatus = LZWebSocketStatusClosedByUser;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(lz_webSocketDidDisconnect:)]) {
        [self.delegate lz_webSocketDidDisconnect:self];
    }
    self.webSocket = nil;
    //关闭后重置重连计数器
    _reconnectCounter = 0;
}

//已经收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    self.socketStatus = LZWebSocketStatusReceived;
    self.socketReceiveType = LZWebSocketReceiveTypePong;
    if (self.delegate && [self.delegate respondsToSelector:@selector(lz_webSocket:didReceiveMessage:)]) {
        [self.delegate lz_webSocket:self didReceiveMessage:pongPayload];
    }
}

- (BOOL)webSocketShouldConvertTextFrameToString:(SRWebSocket *)webSocket {
    return YES;
}


- (void)dealloc {
    [self lz_disconnect];
    NSLog(@"%@已经释放",self.class);
}

@end
