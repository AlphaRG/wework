//
//  MyTaskTableViewCell.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskNumber;
@property (weak, nonatomic) IBOutlet UILabel *taskContent;

@end
