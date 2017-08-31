//
//  RegViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "RegViewController.h"
#import "PasswordViewController.h"
#import "CustomTool.h"
#import "HttpRequestSerVice.h"
#import "UserLogViewController.h"
@interface RegViewController ()<UITextFieldDelegate>
{
    CustomTool *_checklength;
}
@end
@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self];
//    UIWindow  *window = [[UIApplication sharedApplication].delegate window];
//    window.rootViewController = nav;
     self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:5/255.0 green:5/255.0 blue:5/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _checklength = [[CustomTool alloc]init];
    self.title =@"填写手机号";
    self.telPhoneTextfile.delegate =self;
    self.NextBtn.layer.masksToBounds =YES;
    self.NextBtn.layer.cornerRadius=10;
    self.NextBtn.backgroundColor=[UIColor colorWithRed:246/250.0 green:246/250.0 blue:246/250.0 alpha:1.0];
    
    [_telPhoneTextfile becomeFirstResponder];
    _telPhoneTextfile.keyboardType =UIKeyboardTypeNumberPad;
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    _NextBtn.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
}

-(void)navLeftBtnClick{
    UserLogViewController *VC = [[UserLogViewController alloc]initWithNibName:@"UserLogViewController" bundle:nil];
    [VC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:VC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)NextClick:(id)sender {
    if (![_checklength checkInput:self.telPhoneTextfile.text] ){
        if ([self.telPhoneTextfile.text length]==11) {
            NSString *url = [NSString stringWithFormat:@"%@api/Account/MemberMobileIsExist",USERURL];
            NSDictionary *requestdic =@{@"mobileNum":self.telPhoneTextfile.text};
        [HttpRequestSerVice getDicUrl:url Dic:requestdic Title:nil SuccessBlock:^(NSDictionary *dic) {
            if([dic[@"Code"] isEqualToString:@"false"]){
                PasswordViewController *passVC = [[PasswordViewController alloc]initWithNibName:@"PasswordViewController" bundle:nil];
                passVC.telNum = self.telPhoneTextfile.text;
                [self.navigationController pushViewController:passVC animated:YES];
            }else{
                    [CommoneTools alertOnView:self.view content:@"手机已注册"];
            }
        } FailuerBlock:^(NSString *str) {
            [CommoneTools alertOnView:self.view content:@"网络有问题"];
        }];
    }else{
            [CommoneTools alertOnView:self.view content:@"手机号输入错误"];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([_checklength checkInput:string]){
        if([self.telPhoneTextfile.text length]==1){
           _NextBtn.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
           self.NextBtn.layer.masksToBounds =YES;
           self.NextBtn.layer.cornerRadius=10;
          }
          else{
              self.NextBtn.backgroundColor =[UIColor colorWithRed:34/255.0 green:139/255.0 blue:255/255.0 alpha:1.0];
              self.NextBtn.layer.masksToBounds =YES;
              self.NextBtn.layer.cornerRadius=10;
         }
    }
  else{
       self.NextBtn.backgroundColor =[UIColor colorWithRed:61/255.0 green:185/255.0 blue:253/255.0 alpha:1.0];
        self.NextBtn.layer.masksToBounds =YES;
        self.NextBtn.layer.cornerRadius=10;
    }
    return YES;
}
@end
