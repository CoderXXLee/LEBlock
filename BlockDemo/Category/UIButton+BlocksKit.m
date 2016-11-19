//
//  UIButton+BlocksKit.m
//  E
//
//  Created by lwp on 2016/11/17.
//  Copyright © 2016年 com.haotu. All rights reserved.
//

#import "UIButton+BlocksKit.h"
@import ObjectiveC.runtime;

static const void *BKButtonItemBlockKey = &BKButtonItemBlockKey;

@implementation UIButton (BlocksKit)

/**
 添加点击事件
 */
- (void)bk_addTouchUpAction:(void (^)(id sender))block {
    objc_setAssociatedObject(self, BKButtonItemBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(bk_handleAction:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 添加事件

 @param controlEvents
 @param block
 */
- (void)bk_addActionForControlEvents:(UIControlEvents)controlEvents handle:(void (^)(id sender))block  {
    objc_setAssociatedObject(self, BKButtonItemBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(bk_handleAction:) forControlEvents:controlEvents];
}

- (void)bk_handleAction:(UIButton *)sender {
    void (^block)(id) = objc_getAssociatedObject(self, BKButtonItemBlockKey);
    if (block) block(sender);
}
@end
