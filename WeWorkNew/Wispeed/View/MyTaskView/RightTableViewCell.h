//
//  RightTableViewCell.h
//  doubleTableView
//
//  Created by tarena13 on 15/10/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WW_heardView.h"
@protocol noticeBtnDelegate <NSObject>
@optional
-(void)noticeBtnDelegat:(id)tag;
@end
@interface RightTableViewCell : UITableViewCell<sendBtnInfoDelegate>
@property(nonatomic,weak)id <noticeBtnDelegate>nodelegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number Fag:(viewType)fag ;
-(void)coreData:(id)data fag:(viewType)fag cell:(UITableViewCell *)cell;
@end
