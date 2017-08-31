//
//  mySelfInfoTableViewCell.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/26.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ExitDelegate<NSObject>
-(void)exit:(NSInteger)tag;
@end

@interface mySelfInfoTableViewCell : UITableViewCell
@property(nonatomic,weak) id<ExitDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *BtnExit;

- (IBAction)BtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BtnNameConstraint;

-(void)SetcellName:(NSString *)cellName textName:(NSString *)textName  indexpath:(int)code;
-(void)setViewInfo:(id)data;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UIButton *BtnName;
@property (weak, nonatomic) IBOutlet UILabel *LableName;
@end
