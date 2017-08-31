//
//  CustomTool.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/15.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTool : NSObject

-(BOOL)checkInput:(NSString *)str;

-(void)addlocaldDataCaches:(NSArray *)dataArray andNameArray:(NSArray *)nameArray;
@end
