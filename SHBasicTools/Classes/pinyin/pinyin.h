/*
 *  pinyin.h
 *  Chinese Pinyin First Letter
 *
 *  Created by George on 4/21/10.
 *  Copyright 2010 RED/SAFI. All rights reserved.
 *
 */

/*
 * // Example
 *
 * #import "pinyin.h"
 *
 * NSString *string = @"中国共产党万岁！";
 char tempChar = pinyinFirstLetter([string characterAtIndex:0]);
 NSString* firstString = [NSString stringWithFormat:@"%c",tempChar];
 *
 */
#define ALPHA	@"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
char pinyinFirstLetter(unsigned short hanzi);
