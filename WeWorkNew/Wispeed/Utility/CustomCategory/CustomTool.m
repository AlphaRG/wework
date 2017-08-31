
//
//  CustomTool.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/15.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CustomTool.h"

@implementation CustomTool


/**
 *  判断字符串是否为空
 *
 *  @param str
 *
 *  @return
 */
-(BOOL)checkInput:(NSString *)str
{
    BOOL fag = YES;
    if (str.length) {
        fag = NO;
    }
    return fag;
    
}
/**本地数据缓存
 *
 *
 *  @param dataArray  传入数据
 *  @param nameArray  数据名称
 */
-(void)addlocaldDataCaches:(NSArray *)dataArray andNameArray:(NSArray *)nameArray
{
    int i=0;
    for(NSString *nameArr in nameArray) {
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:nameArr];
        
        [[NSUserDefaults standardUserDefaults]setObject:dataArray[i]forKey:nameArr];
        
        i++;
     }
}

@end
