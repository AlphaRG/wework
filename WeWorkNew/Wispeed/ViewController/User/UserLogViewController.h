//
//  UserLogViewController.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLogViewController : UIViewController
- (IBAction)regBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
@property (weak, nonatomic) IBOutlet UITextField *UserNumber;
@property (weak, nonatomic) IBOutlet UITextField *userPassWord;
- (IBAction)LogBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *LogBtn;
-(void)getUserInfo:(int)fag;
@property (weak, nonatomic) IBOutlet UIButton *CodeImageBtn;
- (IBAction)CodeImageBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *CodeTextField;
- (IBAction)loginWayBtnClick:(id)sender;
@end
