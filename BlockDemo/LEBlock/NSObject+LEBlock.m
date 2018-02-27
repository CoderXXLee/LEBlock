//
//  NSObject+LEBlock.m
//  E
//
//  Created by lwp on 2016/11/18.
//  Copyright © 2016年 com.haotu. All rights reserved.
//

#import "NSObject+LEBlock.h"
#import <objc/runtime.h>

static const void *NSObjectHandlersKey = &NSObjectHandlersKey;

@implementation NSObject (LEBlock)

- (LEBlockManager *)blockManager {
    LEBlockManager *events = objc_getAssociatedObject(self, NSObjectHandlersKey);
    if (!events) {
        events = [[LEBlockManager alloc] init];
        objc_setAssociatedObject(self, NSObjectHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return events;
}

- (void)setBlockManager:(LEBlockManager *)blockManager {
    objc_setAssociatedObject(self, NSObjectHandlersKey, blockManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
