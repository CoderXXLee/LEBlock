//
//  LEBlockManager.h
//  Test110701
//
//  Created by lwp on 2016/11/18.
//  Copyright © 2016年 LE. All rights reserved.
//

#import <Foundation/Foundation.h>

//weakSelf
#define BMWeakObject(name, obj) __weak __typeof (obj)name = obj
#define BMWself BMWeakObject(bself, self);

typedef void (^EventsBlock)( );

@interface LEBlockManager : NSObject

/**
 向订阅者发送信号，一对一，当有多个订阅者时，默认针对最后一个
 
 @param key 事件识别Key
 */
- (EventsBlock)sendEvent:(NSString *)key;

/**
 向订阅者发送信号，一对多，所有订阅者将同时收到发送的信号
 
 @param key 事件识别Key
 @param para 发送的数据
 */
- (void)sendEvent:(NSString *)key params:(void(^)(EventsBlock params))para;

/**
 添加事件监听，订阅者，订阅事件

 @param key 事件识别Key
 */
- (void)addEvent:(NSString *)key handler:(EventsBlock)handler;

@end
