//
//  WW_marketViewController.m
//  Wispeed
//
//  Created by RainGu on 17/4/12.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "WW_marketViewController.h"

@interface WW_marketViewController ()
{
    UISegmentedControl *_segmentC;
}
@end

@implementation WW_marketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"市场";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    _segmentC = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"智域资源市场",@"我订购的资源",nil]];
    _segmentC.frame = CGRectMake(0,65,ScreenWidth,40);
    _segmentC.tintColor = [UIColor whiteColor];
    _segmentC.backgroundColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
    _segmentC.layer.cornerRadius = 5.0;
    _segmentC.layer.masksToBounds = YES;
    _segmentC.selectedSegmentIndex =0;
    [_segmentC addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:_segmentC];
    
    UILabel  *labletext = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, ScreenWidth, 1)];
    labletext.backgroundColor = [UIColor blackColor];
    [self.view addSubview:labletext];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    self.view.frame = CGRectMake(0,42+64,ScreenWidth, ScreenHeight-42-64);
}

-(void)click:(UISegmentedControl *)segmetC{
    
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [_segmentC removeFromSuperview];
}

@end
