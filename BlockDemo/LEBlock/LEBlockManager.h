//
//  LEBlockManager.h
//  Test110701
//
//  Created by lwp on 2016/11/18.
//  Copyright © 2016年 LE. All rights reserved.
//

#import <Foundation/Foundation.h>

//weakSelf

#if DEBUG
#define le_keywordify @autoreleasepool {}
#else
#define le_keywordify @try {} @catch (...) {}
#endif

#define le_metamacro_concat(A, B) A ## B

#define le_weakify_(VAR) \
__weak __typeof__(VAR) le_metamacro_concat(VAR, _weak_) = (VAR);

#define le_strongify_(VAR) \
__strong __typeof__(VAR) VAR = le_metamacro_concat(VAR, _weak_);

#define LEWeakify(x) \
le_keywordify \
le_weakify_(x)

#define LEStrongify(x) \
le_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
le_strongify_(x) \
_Pragma("clang diagnostic pop")

#define LEWeakifySelf LEWeakify(self)
#define LEStrongifySelf LEStrongify(self)

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
