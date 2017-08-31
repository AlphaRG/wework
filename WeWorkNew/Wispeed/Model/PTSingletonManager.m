//
//  PTSingletonManager.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "PTSingletonManager.h"

@implementation PTSingletonManager

+(PTSingletonManager *)shareInstance
{
    static PTSingletonManager * singletonManager = nil;
    @synchronized(self){
        if (!singletonManager) {
            singletonManager = [[PTSingletonManager alloc]init];
        }
    }
    return singletonManager;
}

@end
