//
//  MyReportTableViewCell.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "MyReportTableViewCell.h"
@implementation MyReportTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
}
-(void)setView
{
    for (UIView *view in self.contentView.subviews)
    {
        [view removeFromSuperview];
    }
 
}
@end
