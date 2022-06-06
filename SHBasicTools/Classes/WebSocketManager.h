//
//  WebSocketManager.h
//  SocketRocket
//
//  Created by mac on 2017/9/18.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WebSocketManager;

#define LZWebSocketManager [WebSocketManager sharedManager]

/**
 socket连接状态

 - LZWebSocketStatusNotConnected: 未连接
 - LZWebSocketStatusConnected: 已连接
 - LZWebSocketStatusFailed: 连接失败
 - LZWebSocketStatusClosedByServer: 系统自动关闭
 - LZWebSocketStatusClosedByUser: 用户手动关闭
 - LZWebSocketStatusReceived: 接收消息
 */
typedef NS_ENUM(NSInteger, LZWebSocketStatus){
    LZWebSocketStatusNotConnected,      ///<未连接
    LZWebSocketStatusConnected,         ///< 已连接
    LZWebSocketStatusFailed,            ///< 连接失败
    LZWebSocketStatusClosedByServer,    ///< 系统自动关闭
    LZWebSocketStatusClosedByUser,      ///< 用户手动关闭
    LZWebSocketStatusReceived           ///< 接收消息
};


/**
 接收消息的类型

 - LZWebSocketReceiveTypeMessage: 消息
 - LZWebSocketReceiveTypePong: pong
 */
typedef NS_ENUM(NSInteger, LZWebSocketReceiveType){
    LZWebSocketReceiveTypeMessage,      ///< 消息
    LZWebSocketReceiveTypePong          ///< pong
};

@protocol WebSocketManagerDelegate <NSObject>

/**
 已经连接
 
 @param socket self
 */
- (void)lz_webSocketDidConnect:(WebSocketManager *)socket;

/**
 已经关闭
 
 @param socket self
 */
- (void)lz_webSocketDidDisconnect:(WebSocketManager *)socket;

/**
 连接失败
 
 @param socket self
 */
- (void)lz_webSocketConnectError:(WebSocketManager *)socket;

/**
 已经收到消息

 @param socket self
 @param data 数据
 */
- (void)lz_webSocket:(WebSocketManager *)socket didReceiveMessage:(id)data;

/**
 发送失败

 @param socket self
 @param socketStatus socket的状态
 */
- (void)lz_webSocket:(WebSocketManager *)socket sendMessageError:(LZWebSocketStatus)socketStatus;

@end

@interface WebSocketManager : NSObject

/**
 URL
 */
@property (nonatomic, copy) NSString *urlString;

/**
 代理
 */
@property (nonatomic, weak) id <WebSocketManagerDelegate>delegate;

/**
 重连时间
 */
@property (nonatomic, assign) NSTimeInterval reconnectTimeInterval;

/**
 重连次数
 */
@property (nonatomic, assign) NSInteger reconnectCount;

/**
 socket连接状态
 */
@property (nonatomic, assign, readonly) LZWebSocketStatus socketStatus;


/**
 socket收到的消息类型
 */
@property (nonatomic, assign, readonly) LZWebSocketReceiveType socketReceiveType;


/**
 webscoket单例
 
 @return self
 */
+ (instancetype)sharedManager;

/**
 初始化
 
 @return WebSocketManager
 */
- (instancetype)init;

/**
 连接WebSocket

 @param url 服务器地址
 @param delegate WebSocketManagerDelegate
 */
- (void)lz_connectSocketWithUrl:(NSString *)url delegate:(id <WebSocketManagerDelegate>)delegate;

/**
 连接socktet
 */
- (void)lz_connect;

/**
 连接socktet

 @param url 服务器地址
 */
- (void)lz_connect:(NSString *)url;

/**
 断开连接
 */
- (void)lz_disconnect;

/**
 重新连接
 */
- (void)lz_reconnect;

/**
 发送消息
 
 @param data 消息内容
 */
- (void)lz_sendMessage:(id)data;

/**
 发送心跳包

 @param data 心跳包内容
 */
- (void)lz_sendPing:(NSData *)data sendInterval:(NSTimeInterval)sendInterval;

@end
