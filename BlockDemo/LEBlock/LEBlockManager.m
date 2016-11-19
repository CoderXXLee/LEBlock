//
//  LEBlockManager.m
//  Test110701
//
//  Created by lwp on 2016/11/18.
//  Copyright © 2016年 LE. All rights reserved.
//

#import "LEBlockManager.h"
#import <objc/runtime.h>

static const void *LEHandlersKey = &LEHandlersKey;

#pragma mark - LEBlock

@interface LEBlock : NSObject

- (instancetype)initWithHandler:(EventsBlock)handler;

/**
 *  block 传递事件
 */
@property (nonatomic, copy) EventsBlock eventsBlock;

@end

@implementation LEBlock

- (instancetype)initWithHandler:(EventsBlock)handler {
    if (self = [super init]) {
        self.eventsBlock = handler;
    }
    return self;
}

- (EventsBlock)eventsBlock {
    return objc_getAssociatedObject(self, @selector(eventsBlock));
}

- (void)setEventsBlock:(EventsBlock)eventsBlock {
    objc_setAssociatedObject(self, @selector(eventsBlock), eventsBlock, OBJC_ASSOCIATION_COPY);
}

@end

#pragma mark - LEBlockManager

@implementation LEBlockManager

- (NSMutableDictionary *)operationDictionary {
    NSMutableDictionary *operations = objc_getAssociatedObject(self, LEHandlersKey);
    if (operations) {
        return operations;
    }
    operations = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, LEHandlersKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return operations;
}

- (NSArray *)getEvents:(NSString *)key {
    NSMutableDictionary *events = [self operationDictionary];
    
    NSArray *handlers = events[key];
    if (!handlers) return nil;
    
    NSArray *handlersCopy;
    @synchronized (events) {
        handlersCopy = [handlers copy];
    }
    
    return handlersCopy;
}

#pragma mark -

/**
 添加事件监听，订阅者，订阅事件
 
 @param key 事件识别Key
 */
- (void)addEvent:(NSString *)key handler:(EventsBlock)handler {
    NSParameterAssert(handler);
    
    NSMutableDictionary *events = [self operationDictionary];
    
    NSMutableArray *handlers = events[key];
    if (!handlers) {
        handlers = [NSMutableArray array];
        events[key] = handlers;
    }
    
    LEBlock *target = [[LEBlock alloc] initWithHandler:handler];
    
    @synchronized (events) {
        [handlers addObject:target];
    }
}

/**
 向订阅者发送信号，一对一，当有多个订阅者时，默认针对最后一个
 
 @param key 事件识别Key
 */
- (EventsBlock)sendEvent:(NSString *)key {
    NSParameterAssert(key);
    
    NSMutableDictionary *events = [self operationDictionary];
    
    NSArray *handlers = events[key];
    if (!handlers) return ^{};
    
    LEBlock *target = handlers.lastObject;
    return target.eventsBlock;
}

/**
 向订阅者发送信号，一对多，所有订阅者将同时收到发送的信号
 
 @param key 事件识别Key
 @param para 发送的数据
 */
- (void)sendEvent:(NSString *)key params:(void(^)(EventsBlock params))para {
    NSParameterAssert(key);
    
    NSArray *events = [self getEvents:key];
    if (!events) return;
    
    [events enumerateObjectsUsingBlock:^(LEBlock * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EventsBlock event = obj.eventsBlock;
        if (event && para) {
            para(event);
        }
        else if (event) {
            event();
        }
    }];
}
@end
