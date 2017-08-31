//
//  RGBaseViewController.m
//  Wispeed
//
//  Created by RainGu on 2017/5/3.
//  Copyright © 2017年 Wispeed. All rights reserved.

#import "RGBaseViewController.h"
#import "NavigationView.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
#import "WW_SetViewController.h"
#import "WW_aboutUSViewController.h"
#import "UserLogViewController.h"
#import "YBPopupMenu.h"
#import "WW_marketViewController.h"
#import "SDScanViewController.h"
#import "HttpRequestSerVice.h"
@interface RGBaseViewController ()<sendInfoDelegate,HomeMenuViewDelegate,YBPopupMenuDelegate>
{
    NavigationView *_navView;
    UIButton *rightBtn;
}
@property (nonatomic ,strong)MenuView      *leftmenu;
@end

@implementation RGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navView  = [[NavigationView alloc]initWithFrame:CGRectMake(0,0,44,44) view:self.view tag:0];
    _navView.delegate =self;
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:_navView];

    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:24/255.0 green:147/255.0 blue:30/255.0 alpha:0.6];
    self.navigationController.navigationBar.barTintColor =[UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    

    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(navRightClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)navRightClick{
    NSArray *titles = @[@"扫一扫",@"市场"];
    NSArray *images =@[@"scan_big",@"create_task_big"];
    [YBPopupMenu showAtPoint:CGPointMake(ScreenWidth-30, 64) titles:titles icons:images menuWidth:160 fag:200 delegate:self];
}

-(void)jumpMarketView{
    WW_marketViewController *vc =[[WW_marketViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scanView{
    SDScanViewController *VC = [[SDScanViewController alloc]init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)sendInfo:(NSInteger)fag imageType:(id)type{
    LeftMenuViewDemo *demo = [[LeftMenuViewDemo alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 0.8, [[UIScreen mainScreen] bounds].size.height)];
    demo.customDelegate = self;
    
    MenuView *menu = [MenuView MenuViewWithDependencyView:self.view MenuView:demo isShowCoverView:YES];
    self.leftmenu = menu;
    [self.leftmenu show];
}

-(void)LeftMenuViewClick:(NSInteger)tag{
    [self.leftmenu hidenWithAnimation];
    WW_SetViewController *vc = [[WW_SetViewController alloc]init];
    switch (tag) {
        case 0:
            [self.navigationController pushViewController:vc animated:YES];
            break;
        case 1:
            [self jumpAboutUS];
            break;
        case 2:
            [self exit];
            break;
        default:
            break;
    }
}

-(void)jumpAboutUS{
    WW_aboutUSViewController *us = [[WW_aboutUSViewController alloc]init];
    us.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:us animated:YES];
}

-(void)exit{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults  removeObjectForKey:@"UserLog"];
    [defaults removeObjectForKey:@"userID"];
    
    [defaults removeObjectForKey:@"Token"];
    [defaults removeObjectForKey:@"UserName"];
    [defaults removeObjectForKey:@"CompanyID"];
    [defaults removeObjectForKey:@"password"];
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 0;
    UserLogViewController *VC = [[UserLogViewController alloc]initWithNibName:@"UserLogViewController" bundle:nil];
    [VC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:VC animated:YES completion:nil];
}

-(void)alterController:(UIViewController *)view{
    UIAlertController *alterController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UserLogViewController *VC = [[UserLogViewController alloc]initWithNibName:@"UserLogViewController" bundle:nil];
        [VC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults  removeObjectForKey:@"UserLog"];
        [defaults removeObjectForKey:@"userID"];
        
        [defaults removeObjectForKey:@"Token"];
        [defaults removeObjectForKey:@"UserName"];
        [defaults removeObjectForKey:@"CompanyID"];
        [defaults removeObjectForKey:@"password"];
        //[self.navigationController pushViewController:logVC animated:YES];
        [view presentViewController:VC animated:YES completion:nil];
    }];
    [alterController addAction:OK];
    [view presentViewController:alterController animated:YES completion:nil];
}

@end
