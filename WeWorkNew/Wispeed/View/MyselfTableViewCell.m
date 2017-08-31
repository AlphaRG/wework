//
//  MyselfTableViewCell.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "MyselfTableViewCell.h"

@implementation MyselfTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userHeadImage.clipsToBounds = YES;
    self.userHeadImage.layer.cornerRadius = 35;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
