//
//  ViewController.m
//  BlockDemo
//
//  Created by lwp on 2016/11/19.
//  Copyright © 2016年 LE. All rights reserved.
//

#import "ViewController.h"
#import "LETestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}

- (void)test {
    LETestView *test = [[LETestView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:test];
    
    [test.blockManager addEvent:@"btn1" handler:^(NSString *title){
        NSLog(@"%@", title);
    }];
    
    [test.blockManager addEvent:@"btn2" handler:^(NSString *title, NSArray *arr){
        NSLog(@"%@-%@", title, arr);
    }];
    
    [test.blockManager addEvent:@"btn2" handler:^(NSString *title, NSArray *arr){
        NSLog(@"第二个订阅者：%@-%@", title, arr);
    }];
    
    [test.blockManager addEvent:@"btn3" handler:^(NSString *title, NSArray *arr){
        NSLog(@"第1个订阅者:%@-%@", title, arr);
    }];
    [test.blockManager addEvent:@"btn3" handler:^(NSString *title, NSArray *arr){
        NSLog(@"第2个订阅者:%@-%@", title, arr);
    }];
}


@end
