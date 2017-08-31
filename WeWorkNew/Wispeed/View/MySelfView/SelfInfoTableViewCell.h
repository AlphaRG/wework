//
//  SelfInfoTableViewCell.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/13.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Userrelation;
@property (weak, nonatomic) IBOutlet UILabel *companyInfo;
@property (weak, nonatomic) IBOutlet UILabel *branchInfo;
@property (weak, nonatomic) IBOutlet UILabel *workInfo;

@end
