//
//  UIButton+BlocksKit.h
//  E
//
//  Created by lwp on 2016/11/17.
//  Copyright © 2016年 com.haotu. All rights reserved.
//

@import UIKit;
#import <UIKit/UIKit.h>

@interface UIButton (BlocksKit)

/**
 添加点击事件
 */
- (void)bk_addTouchUpAction:(void (^)(id sender))block;

/**
 添加事件
 */
- (void)bk_addActionForControlEvents:(UIControlEvents)controlEvents handle:(void (^)(id sender))block;
@end
