//
//  PasswordViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/15.
//  Copyright © 2016年 Wispeed. All rights reserved.

#import "PasswordViewController.h"
#import "CustomTool.h"
#import "UserLogViewController.h"
#import "Single.h"
#import <SMS_SDK/SMSSDK.h>
#import "HttpRequestSerVice.h"
@interface PasswordViewController ()<UITextFieldDelegate>
{
    CustomTool *lengthCheck;
    Single *Sing;
    NSTimer *time;
    int i;
    NSString *guidString;
}
@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"输入密码";
    self.OverBtn1.layer.masksToBounds =YES;
    self.OverBtn1.layer.cornerRadius=10;
    self.passWordFiled.delegate         = self;
    self.againPasswordField.delegate    = self;
    self.verificationTextFiled.delegate = self;
    i= 60;
    
    lengthCheck = [[CustomTool alloc]init];
    Sing = [Single Send];
    [self getImageCode];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([lengthCheck checkInput:self.passWordFiled.text]||[lengthCheck checkInput:self.againPasswordField.text]||[lengthCheck checkInput:self.verificationTextFiled.text]){
        _OverBtn1.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        self.OverBtn1.layer.masksToBounds =YES;
        self.OverBtn1.layer.cornerRadius=10;
        self.OverBtn1.enabled = NO;
    }
    else{
        self.OverBtn1.backgroundColor =[UIColor colorWithRed:34/255.0 green:139/255.0 blue:255/255.0 alpha:1.0];
        self.OverBtn1.layer.masksToBounds =YES;
        self.OverBtn1.layer.cornerRadius=10;
        self.OverBtn1.enabled = YES;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
            [self textfileLength];
            break;
        case 2:
            [self judge];
        break;
        
        default:
            break;
    }
}

-(void)judge{
    if(![self.passWordFiled.text isEqualToString:self.againPasswordField.text]){
        [CommoneTools alertOnView:self.view content:@"两次密码不同"];
    }
}

-(void)textfileLength{
    if ([self.passWordFiled.text length]<6 ||[self.passWordFiled.text length]>16) {
        [CommoneTools alertOnView:self.view content:@"密码长度错误"];
    }
}

- (IBAction)OverBtn:(id)sender {
    if ([lengthCheck checkInput:self.passWordFiled.text]||[lengthCheck checkInput:self.againPasswordField.text]||[lengthCheck checkInput:self.verificationTextFiled.text]||[lengthCheck checkInput:self.imageTextFiled.text]){
         [CommoneTools alertOnView:self.view content:@"请填写完整"];
    }
    else{
            [self registerUser];
    }
}

-(void)changeTime{
    if (i==0){
        i=60;
        [time invalidate];
        self.verificationBtn.enabled = YES;
        self.verificationBtn.titleLabel.text =[NSString stringWithFormat:@"重新发送"];
        [self.verificationBtn setTitleColor:[UIColor colorWithRed:77/250.0 green:142/250.0 blue:249/250.0 alpha:1.0]forState:UIControlStateNormal];
    }
    else{
        i--;
        [self.verificationBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.verificationBtn.titleLabel.text =[NSString stringWithFormat:@"重新(%d)",i];
        if (i==0){
            [self.verificationBtn setTitle:[NSString stringWithFormat:@"重新发送"] forState:UIControlStateNormal];
        }
        else{
            [self.verificationBtn setTitle:[NSString stringWithFormat:@"重新(%d)",i] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)verificationBtnClick:(id)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.telNum zone: @"86" customIdentifier: nil result:^(NSError *error){
        if (!error) {
            self.verificationBtn.enabled = NO;
            time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
        }
        else{
            [CommoneTools alertOnView:self.view content:@"发送失败"];
        }
    }];
}

-(void)registerUser{
    NSString *url = [NSString stringWithFormat:@"%@%@",USERURL,@"api/Account/MemberMobileReg"];
    NSDictionary *IVerifyCode = @{
                                  @"TUidOrMail":guidString,
                                  @"ActionPage":@"loginPage",
                                  @"Code":self.imageTextFiled.text
                                  };
    NSDictionary *dic =@{
                         @"Code":self.verificationTextFiled.text,
                         @"MobileNum":self.telNum,
                         @"password":self.passWordFiled.text,
                         @"zon":@"86",
                         @"ClientType":@10,
                         @"FormPlatform":@20,
                         @"ClientInfor":@"No message",
                         @"IVerifyCode":IVerifyCode
                    };
    
    [HttpRequestSerVice getDicUrl:url Dic:dic Title:nil SuccessBlock:^(NSDictionary *dic) {
        if ([dic[@"Flag"]isEqualToString:@"S"]) {
            UserLogViewController *VC = [[UserLogViewController alloc]initWithNibName:@"UserLogViewController" bundle:nil];
            [VC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:VC animated:YES completion:nil];
        }
        else{
            [CommoneTools alertOnView:self.view content:dic[@"Msg"]];
        }
        
    } FailuerBlock:^(NSString *str) {
        [CommoneTools alertOnView:self.view content:str];
    }];

}

- (IBAction)imageCodeClick:(id)sender {
    [self getImageCode];
}

-(void)getImageCode{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);
    guidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    NSString *url = [NSString stringWithFormat:@"%@api/Common/GetCode",USERURL];
    
    NSDictionary *dic =@{
                         @"TUidOrMail":guidString,
                         @"ActionPage":@"loginPage",
                         @"FormPlatform":@20,
                         @"ClientType":@10
                         };
    [HttpRequestSerVice getDicUrl:url Dic:dic Title:nil SuccessBlock:^(NSDictionary *dic) {
        if ([dic[@"OMsg"][@"Flag"] isEqualToString:@"S"]) {
            NSData *data3   = [[NSData alloc] initWithBase64EncodedString:dic[@"CodeByte"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            [self.imageCode setImage:[UIImage imageWithData:data3] forState:UIControlStateNormal];
        }
    } FailuerBlock:^(NSString *str) {
        
    }];
    
}

@end
