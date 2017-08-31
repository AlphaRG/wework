
//
//  WW_reportViewController.m
//  Wispeed
//
//  Created by RainGu on 17/4/12.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "WW_reportViewController.h"
#import "NavigationView.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
#import "WW_aboutUSViewController.h"
#import "WW_SetViewController.h"
#import "UserLogViewController.h"
#import "YBPopupMenu.h"
#import "WW_marketViewController.h"
#import "SDScanViewController.h"
@interface WW_reportViewController ()<sendInfoDelegate,HomeMenuViewDelegate,YBPopupMenuDelegate>
{
    UISegmentedControl *_segmentC;
    NavigationView *navView;
    UIButton       *rightBtn;
}
@property (nonatomic ,strong)MenuView      *leftmenu;
@end

@implementation WW_reportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的报表";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:24/255.0 green:147/255.0 blue:30/255.0 alpha:0.6];
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navView  = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0,44,44) view:self.view tag:1];
    navView.delegate =self;
    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(navRightClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem ;
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:navView];
}

-(void)navRightClick{
    NSArray *titles = @[@"扫一扫",@"市场"];
    NSArray *images =@[@"scan_big",@"create_task_big"];
    [YBPopupMenu showAtPoint:CGPointMake(ScreenWidth-30, 64) titles:titles icons:images menuWidth:160 fag:200 delegate:self];
}
-(void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu{
    switch (index) {
        case 0:
            [self scanView];
            break;
        default:
            [self jumpMarketView];
            break;
    }

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


-(void)viewWillAppear:(BOOL)animated{
    _segmentC = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"系统报表",@"业务报表",@"个人报表",nil]];
    _segmentC.frame = CGRectMake(0,65,ScreenWidth,40);
    _segmentC.tintColor = [UIColor whiteColor];
    _segmentC.backgroundColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
    _segmentC.layer.cornerRadius = 5.0;
    _segmentC.layer.masksToBounds = YES;
    _segmentC.selectedSegmentIndex =0;
    [_segmentC addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:_segmentC];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0,42+64,ScreenWidth, ScreenHeight-42-64);
}

-(void)viewWillDisappear:(BOOL)animated{
    [_segmentC removeFromSuperview];
}

-(void)click:(UISegmentedControl *)segmetC{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UserLogViewController *VC = [[UserLogViewController alloc]initWithNibName:@"UserLogViewController" bundle:nil];
    [VC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:VC animated:YES completion:nil];
}
@end
