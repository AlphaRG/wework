//
//  UITableView+RegiesterCell.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView(RegiesterCell)

-(void)registerNib:(NSArray <NSString *>*)nibs;

-(void)registerClass:(NSArray <NSString *>*)cls;

@end
