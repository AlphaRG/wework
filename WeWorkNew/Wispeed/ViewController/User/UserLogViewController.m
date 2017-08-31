//
//  UserLogViewController.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "UserLogViewController.h"
#import "MyReportTableViewController.h"
#import "MainViewController.h"
#import "HttpRequestSerVice.h"
#import "CustomTool.h"
#import "Single.h"
#import "DBSerVice.h"
#import "RegViewController.h"
#import "PCCircleViewConst.h"
#import "GestureViewController.h"
#import "FingerPrintViewController.h"
@interface UserLogViewController ()<UITextFieldDelegate>{
    CustomTool *customTool;
    Single * single;
    NSString *guidString;
}
@end
@implementation UserLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     customTool =[[CustomTool alloc]init];
    _userPassWord.delegate =self;
    self.LogBtn.layer.masksToBounds = YES;
    self.LogBtn.layer.cornerRadius  =10.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getImageCode];
}

- (IBAction)LogBtnClick:(id)sender {
    if ([customTool checkInput:_UserNumber.text]||[customTool checkInput:_userPassWord.text]||[customTool checkInput:self.CodeTextField.text]) {
        [CommoneTools alertOnView:self.view content:@"请填写完整"];
        [self getImageCode];
    }
    else{
        [self getUserInfo:0];
    }
}


-(void)getUserInfo:(int)fag{
    single = [Single Send];
    if (fag==0) {
        single.UserName =_UserNumber.text;
        single.Password = _userPassWord.text;
    }
    NSDictionary *codedic =@{
                             @"TUidOrMail":guidString,
                             @"ActionPage":@"loginPage",
                             @"Code":self.CodeTextField.text
                             };
    [HttpRequestSerVice LoginUserName:single.UserName andPassWord:single.Password IVerifyCode:(NSDictionary *)codedic SuccessBlock:^(NSDictionary *dic) {
                             if ([dic[@"Flag"]isEqualToString:@"S"]){
                                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                 [defaults removeObjectForKey:@"userID"];
                                 [defaults removeObjectForKey:@"Token"];
                                 [defaults removeObjectForKey:@"UserName"];
                                 [defaults removeObjectForKey:@"sex"];
                                 [defaults removeObjectForKey:@"HeadImg"];
                                 [defaults removeObjectForKey:@"tel"];
                                 [defaults removeObjectForKey:@"email"];
                                 [defaults removeObjectForKey:@"area"];
                                 [defaults removeObjectForKey:@"NickName"];
                                 
                                 [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"UserLog"];
                                 [defaults setObject:dic[@"UserID"] forKey:@"userID"];
                                 [defaults setObject:dic[@"Token"] forKey:@"Token"];
                                 [defaults setObject:dic[@"UserName"] forKey:@"UserName"];
                                 [defaults setObject:dic[@"sex"] forKey:@"sex"];
                                 
                                 single = [Single Send];
                                 single.userID    =  [dic[@"UserID"] intValue];
                                 single.Token     =  dic[@"Token"];
                                 single.UserName  =  dic[@"UserName"];
                                 single.NickName  =  dic[@"NickName"];
                                 single.sex       =  dic[@"sex"];
                                 
                                 if (![dic[@"HeadImg"]isKindOfClass:[NSNull class]]) {
                                     [defaults setObject:dic[@"HeadImg"] forKey:@"HeadImg"];
                                     single.headImg   =  dic[@"HeadImg"];
                                 }else{
                                 }
                                 if (![dic[@"PhoneNumber"]isKindOfClass:[NSNull class]]) {
                                     [defaults setObject:dic[@"PhoneNumber"] forKey:@"tel"];
                                     single.tel   =  dic[@"PhoneNumber"];
                                 }else{
                                     single.tel =@"";
                                 }
                                 if (![dic[@"HeadImg"]isKindOfClass:[NSNull class]]) {
                                     [defaults setObject:dic[@"Email"] forKey:@"email"];
                                     single.email   =  dic[@"Email"];
                                 }else{
                                     single.email =@"";
                                 }
                                 if (![dic[@"Area"]isKindOfClass:[NSNull class]]) {
                                     [defaults setObject:dic[@"Area"] forKey:@"area"];
                                     single.area   =  dic[@"Area"];
                                 }else{
                                     single.area =@"";
                                 }
                                 if (![dic[@"NickName"]isKindOfClass:[NSNull class]]) {
                                     [defaults setObject:dic[@"NickName"] forKey:@"NickName"];
                                     single.NickName   =  dic[@"NickName"];
                                 }else{
                                     single.NickName =@"";
                                 }
                                 single.CompanyID =  [[[NSUserDefaults standardUserDefaults]objectForKey:@"CompanyID"] intValue];
                                
                                [PCCircleViewConst saveGesture:@"0" Key:loginKeyWay];
                                    UIStoryboard *stoBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    MainViewController *VC =[stoBoard instantiateViewControllerWithIdentifier:@"Main"];
                                    [self presentViewController:VC animated:YES completion:nil];
                                 }
                             else{
                                 [CommoneTools alertOnView:self.view content:dic[@"Msg"]];
                                 [self getImageCode];
                    
                             }
                         }
                         FailuerBlock:^(NSString *str) {
                             [CommoneTools alertOnView:self.view content:str];
                             }];
}

-(void)getCompanyInfo{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
      [HttpRequestSerVice getUserCompanyid:single.userID andToken:single.Token SuccessBlock:^( NSDictionary *dic) {
            if ([dic[@"Flag"]isEqualToString:@"S"]) {
                NSArray *DataArr = dic[@"CompanyArray"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"CompanyArr"];
//              [[NSUserDefaults standardUserDefaults]setObject:DataArr forKey:@"CompanyArr"];
                single = [Single Send];
                single.companyArr = DataArr;
                
                UIStoryboard *stoBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainViewController *VC =[stoBoard instantiateViewControllerWithIdentifier:@"Main"];
                [self presentViewController:VC animated:YES completion:nil];
            }else{
                UIStoryboard *stoBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainViewController *VC =[stoBoard instantiateViewControllerWithIdentifier:@"Main"];
                [self presentViewController:VC animated:YES completion:nil];
            }
        } FailuerBlock:^(NSString *str) {
            [CommoneTools alertOnView:self.view content:str];
        }];
  });
}

- (IBAction)regBtnClick:(id)sender {
    RegViewController *RegVC = [[RegViewController alloc]initWithNibName:@"RegViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:RegVC];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
}

-(void)getImageCode{
    //获取guid
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);
    guidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    NSString *url = [NSString stringWithFormat:@"%@api/Common/GetCode",USERURL];
    NSDictionary *dic =@{
                         @"TUidOrMail":guidString,
                         @"ActionPage":@"loginPage",
                         @"FormPlatform":@20,
                         @"ClientType":@10
                         };
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [HttpRequestSerVice getDicUrl:url Dic:dic Title:nil SuccessBlock:^(NSDictionary *dic) {
            if ([dic[@"OMsg"][@"Flag"] isEqualToString:@"S"]) {
                NSData *data3   = [[NSData alloc] initWithBase64EncodedString:dic[@"CodeByte"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.CodeImageBtn setImage:[UIImage imageWithData:data3] forState:UIControlStateNormal];
                 });
            }else{
                [self.CodeImageBtn setImage:[UIImage imageNamed:@"codeImage.jpg"] forState:UIControlStateNormal];
            }
        } FailuerBlock:^(NSString *str) {
            [self.CodeImageBtn setImage:[UIImage imageNamed:@"codeImage.jpg"] forState:UIControlStateNormal];
        }];
     });
}

- (IBAction)CodeImageBtnClick:(id)sender {
    [self getImageCode];
}

- (IBAction)loginWayBtnClick:(id)sender {
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"登录方式选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *handlogin = [UIAlertAction actionWithTitle:@"手势登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        GestureViewController *gestureVc = [[GestureViewController alloc] init];
//        gestureVc.type = GestureViewControllerTypeLogin;
//        [self  presentViewController:gestureVc animated:YES completion:nil];
        [CommoneTools alertOnView:self.view content:@"请选择账号密码登录"];
    }];
    UIAlertAction *fingerprint = [UIAlertAction actionWithTitle:@"指纹登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        FingerPrintViewController *vc = [[FingerPrintViewController alloc]init];
//        vc.type = fingerPrintTypeLogin;
//        [self presentViewController:vc animated:YES completion:nil];
        [CommoneTools alertOnView:self.view content:@"请选择账号密码登录"];
    }];
    UIAlertAction *cance     = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertSheet addAction:handlogin];
    [alertSheet addAction:fingerprint];
    [alertSheet addAction:cance];
    [self presentViewController:alertSheet animated:YES completion:nil];
}

@end
