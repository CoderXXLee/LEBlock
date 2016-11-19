//
//  NSObject+LEBlock.h
//  E
//
//  Created by lwp on 2016/11/18.
//  Copyright © 2016年 com.haotu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEBlockManager.h"

@interface NSObject (LEBlock)

/**
 事件管理
 */
@property(nonatomic, strong) LEBlockManager *blockManager;
@end
