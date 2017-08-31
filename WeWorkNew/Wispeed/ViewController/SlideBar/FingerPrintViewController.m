//  FingerPrintViewController.m
//  Wispeed
//  Created by RainGu on 2017/5/10.
//  Copyright © 2017年 Wispeed. All rights reserved.

#import "FingerPrintViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "PCCircleViewConst.h"
#import "NSUserDefaultsInfo.h"
#import "MainViewController.h"
#import "UserLogViewController.h"
#import "GestureViewController.h"
#import "PCCircleView.h"
#import "PCLockLabel.h"
@interface FingerPrintViewController ()<fingerPrintDelegate,CircleViewDelegate>

@end

@implementation FingerPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self FingerPrintView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)FingerPrintView{
    switch (self.type) {
        case 0:
            self.title =@"指纹设置";
            break;
        case 1:
            break;
        default:
            break;
    }
    if (self.type==1&&[[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length]>0) {
        PCCircleView *lockView = [[PCCircleView alloc] init];
        self.lockView = lockView;
        self.lockView.delegate = self;
        [self.lockView setType:CircleViewTypeLogin];
        [self.view addSubview:lockView];
        
        PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
        msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
        msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 30);
        self.lockLable = msgLabel;
        [self.view addSubview:msgLabel];
        
        [self setLoginView];
        [self  setAuthenticationInfo];
    }else{
    FingerPrintView *view = [[FingerPrintView alloc]initWithType:self.type frame:CGRectMake(0, 0,kScreenW, kScreenH) backgroundColor:[UIColor whiteColor]];
    self.fingerPrintView = view;
    self.fingerPrintView.delegate = self;
    [self.view addSubview:view];
    if (self.type ==1 ) {
            [self setLoginView];
            [self  setAuthenticationInfo];
        }
    }
}

-(void)setLoginView{
    UIImageView  *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 65, 65);
    imageView.center = CGPointMake(kScreenW/2,kScreenH/5);
    [imageView setImage:[UIImage imageNamed:@"Kobe.jpg"]];

    UIButton *chooseLoginWay = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenW/2, 21)];
    chooseLoginWay.center = CGPointMake(kScreenW/2, kScreenH-60);
    [chooseLoginWay setTitle:@"登录其他账户" forState:UIControlStateNormal];
    chooseLoginWay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [chooseLoginWay setTitleColor:[UIColor colorWithRed:57/255.0 green:183/255.0 blue:247/255.0 alpha:1.0] forState:UIControlStateNormal];
    [chooseLoginWay addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    if (self.type==1&&[[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length]>0) {
        [self.view addSubview:imageView];
        [self.view  addSubview:chooseLoginWay];
    }else{
        [self.fingerPrintView addSubview:imageView];
        [self.fingerPrintView addSubview:chooseLoginWay];
    }
    
}

-(void)BtnClick{
    UserLogViewController *vc = [[UserLogViewController alloc]initWithNibName:@"UserLogViewController" bundle:nil];;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)sendinfo:(BOOL)trueOrfalse{
    if (trueOrfalse) {
        [PCCircleViewConst saveGesture:@"1" Key:@"SwitchOn"];
        [self setAuthenticationInfo];
    }else{
        [PCCircleViewConst saveGesture:@"0" Key:@"SwitchOn"];
        if([[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length]){
            [PCCircleViewConst saveGesture:@"1" Key:loginKeyWay];
        }else{
            [PCCircleViewConst saveGesture:@"0" Key:loginKeyWay];
        }
    }
}

-(void)fingerPrintBtnClick{
    [self setAuthenticationInfo];
}

-(void)setAuthenticationInfo{
    LAContext *mycontext = [[LAContext alloc]init];
    NSError *authError = nil;
    NSString *title = @"通过Home键验证已有手机指纹";
    if ([mycontext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&authError]) {
        [mycontext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:title reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                if (self.type==0) {
//                  [PCCircleViewConst saveGesture:nil Key:gestureFinalSaveKey];
                    [PCCircleViewConst saveGesture:@"2" Key:loginKeyWay];
                }else{
                    NSInteger tag = [[PCCircleViewConst getGestureWithKey:@"SwitchOn"] integerValue];
                    if (tag==1) {
                    [NSUserDefaultsInfo getInfo];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    UIStoryboard *stoBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    MainViewController *VC =[stoBoard instantiateViewControllerWithIdentifier:@"Main"];
                        [self presentViewController:VC animated:YES completion:nil];
                    }
                }
            }else{
                [self.fingerPrintView.switchBtn setOn:NO];
            }
        }];
    }else{
        [self.fingerPrintView.switchBtn setOn:NO];
    }
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal{
    if (type == CircleViewTypeLogin) {
        if (equal) {
            [self.lockLable showNormalMsg:@"登陆成功！"];
            [NSUserDefaultsInfo getInfo];
            [self.navigationController popToRootViewControllerAnimated:YES];
            UIStoryboard *stoBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *VC =[stoBoard instantiateViewControllerWithIdentifier:@"Main"];
            [self presentViewController:VC animated:YES completion:nil];
        } else {
            [self.lockLable showWarnMsgAndShake:gestureTextGestureVerifyError];
        }
    } else if (type == CircleViewTypeVerify) {
        if (equal) {
            NSLog(@"验证成功，跳转到设置手势界面");
        } else {
            NSLog(@"原手势密码输入错误！");
        }
    }
}

@end
