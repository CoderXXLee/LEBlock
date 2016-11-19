//
//  LETestView.m
//  Test110701
//
//  Created by lwp on 2016/11/18.
//  Copyright © 2016年 LE. All rights reserved.
//

#import "LETestView.h"
#import "UIButton+BlocksKit.h"

@implementation LETestView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 120, 100, 20)];
        [self addSubview:btn1];
        [btn1 setTitle:@"点击事件1" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 bk_addTouchUpAction:^(id sender) {
            [self.blockManager sendEvent:@"btn1"](@"btn1点击了");
            NSLog(@"================");
        }];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 100, 20)];
        [self addSubview:btn2];
        [btn2 setTitle:@"点击事件2" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 bk_addTouchUpAction:^(id sender) {
            [self.blockManager sendEvent:@"btn2"](@"btn2点击了", @[@"1", @"2"]);
            NSLog(@"================");
        }];
        
        UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(20, 190, 100, 20)];
        [self addSubview:btn3];
        [btn3 setTitle:@"多对多1" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn3 bk_addTouchUpAction:^(id sender) {
            [self.blockManager sendEvent:@"btn3" params:^(EventsBlock ev) {
                ev(@"多对多1点击了", @[@"1"]);
            }];
            NSLog(@"================");
        }];
        
        UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(20, 230, 100, 20)];
        [self addSubview:btn4];
        [btn4 setTitle:@"多对多2" forState:UIControlStateNormal];
        [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn4 bk_addTouchUpAction:^(id sender) {
            [self.blockManager sendEvent:@"btn3" params:^(EventsBlock ev) {
                ev(@"多对多2点击了", @[@"2"]);
            }];
            NSLog(@"================");
        }];
    }
    return self;
}

@end
