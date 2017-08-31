//
//  MyTaskTableViewController.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/11.
//  Copyright © 2016年 Wispeed. All rights reserved.

#import "MyTaskTableViewController.h"
#import "MyTaskTableViewCell.h"
#import "NavigationView.h"
#import "MyTaskSelectTableViewCell.h"
#import  "MyTaskSkimTableViewController.h"
#import "HttpRequestSerVice.h"
#import "Single.h"
#import "MJRefresh.h"
#import "UserLogViewController.h"
#import "SDScanViewController.h"
#import "YBPopupMenu.h"
#import "WW_SetViewController.h"
#import "WW_marketViewController.h"
#import "WW_aboutUSViewController.h"
#import "WJDropdownMenu.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"

@interface MyTaskTableViewController ()<sendInfoDelegate,YBPopupMenuDelegate,WJMenuDelegate,HomeMenuViewDelegate>
{
    NavigationView *navView;
    NSMutableArray *finallyArray;
    Single *single;
    NSInteger pageNum,Tfag;
    UISegmentedControl * _segmentC,*_control;
    MBProgressHUD *_Hud;
    UIButton      *rightBtn;
    NSInteger    Htag;
    NSArray *companyArr;
    NSMutableArray *companyNameArr;
    
}
@property (nonatomic,weak)WJDropdownMenu *menu;
@property (nonatomic ,strong)MenuView      *leftmenu;


@end
@implementation MyTaskTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:24/255.0 green:147/255.0 blue:30/255.0 alpha:0.6];
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    single =[Single Send];
    self.title= @"我的任务";
    Htag  =0;
    self.SegTab.center = self.navigationController.view.center;

    companyNameArr = [NSMutableArray arrayWithCapacity:0];
    finallyArray =[NSMutableArray arrayWithCapacity:0];
    navView  = [[NavigationView alloc]initWithFrame:CGRectMake(0,0,44,44) view:self.view tag:0];
    navView.delegate =self;
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:navView];

    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(navRightClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem ;

    self.tableView.footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self getPastAndNowTask:Tfag];
    }];
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageNum =0;
        [self getPastAndNowTask:Tfag];
    }];
    self.tableView.footer.hidden =YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    for (NSDictionary *companydic in single.companyArr){
//        [companyNameArr addObject:companydic[@"CompanyName"]];
//    }
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)navRightClick{
    NSArray *titles = @[@"扫一扫",@"市场"];
    NSArray *images =@[@"scan_big",@"create_task_big"];
    [YBPopupMenu showRelyOnView:rightBtn titles:titles icons:images menuWidth:160 delegate:self];
}

-(void)moreBtn{
    NSArray *titles = @[@"测试",@"管理",@"全部"];
    [YBPopupMenu showAtPoint:CGPointMake(ScreenWidth-40, 100) titles:titles icons:nil menuWidth:80 fag:100 delegate:self];
}

-(void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu{
    if (ybPopupMenu.type == YBPopupMenuTypeDefault) {
        switch (index) {
            case 0:
                [self getToken:0];
            break;
            case 1:
                [self getToken:0];
            break;
            case 2:
                [self getToken:0];
            break;
            case 3:
                [self getToken:0];
            break;
                
            case 4:
                [self getToken:0];
            break;
            case 5:
                [self getToken:0];
            break;
            default:
                break;
        }
    }else{
        switch (index) {
          case 0:
                [self scanView];
           break;
         default:
                [self jumpMarketView];
            break;
       }
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

-(void)viewDidAppear:(BOOL)animated{
  self.tableView.frame = CGRectMake(0,42+64,ScreenWidth, ScreenHeight-42-64);
}

-(void)viewWillAppear:(BOOL)animated{
    _segmentC = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"待办",@"发起",@"关注",@"更多",nil]];
    _segmentC.frame = CGRectMake(0,65,ScreenWidth,40);
    _segmentC.tintColor = [UIColor whiteColor];
    _segmentC.backgroundColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
    _segmentC.layer.cornerRadius = 5.0;
    _segmentC.layer.masksToBounds = YES;
    _segmentC.selectedSegmentIndex =0;
    [_segmentC addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:_segmentC];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait){
        [UIViewController attemptRotationToDeviceOrientation];
        _segmentC.frame = CGRectMake(0,64,ScreenWidth,40);
        Htag =0;
    }
    else{
        _segmentC.frame = CGRectMake(0,32,ScreenWidth,40);
        Htag =1;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:)name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    if ([single.imageNavType isKindOfClass:[UIImage class]]) {
        [navView.companyBtn setImage:single.imageNavType forState:UIControlStateNormal];
    }else{
        [navView.companyBtn sd_setImageWithURL:[NSURL URLWithString:single.imageNavType] forState:UIControlStateNormal];
    }
    pageNum = 0;
    [self getToken:1];
}

- (void)statusBarOrientationChange:(NSNotification *)notification{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait){
        [UIViewController attemptRotationToDeviceOrientation];
        _segmentC.frame = CGRectMake(0,64,ScreenWidth,40);
        Htag =0;
    }
    else{
        _segmentC.frame = CGRectMake(0,32,ScreenWidth,40);
        Htag =1;
    }
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    if (Htag == 0) {
        self.tableView.frame = CGRectMake(0,42+64,ScreenWidth, ScreenHeight-42-64);
    }else{
        self.tableView.frame = CGRectMake(0,34+30,ScreenWidth, ScreenHeight-32-30);
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [_Hud hide:YES];
    [self.tableView.footer endRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated{
    [_segmentC removeFromSuperview];
    [self.menu removeFromSuperview];
    [UIViewController attemptRotationToDeviceOrientation];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

-(void)getPastAndNowTask:(NSInteger)fag {
    Tfag = fag;
    [_Hud hide:YES];
    _Hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _Hud.labelText = @"加载中……";
    _Hud.labelFont = [UIFont systemFontOfSize:12];
    _Hud.margin = 10.0f;
    _Hud.removeFromSuperViewOnHide = YES;
    single.CompanyID =0;
    [HttpRequestSerVice TaskListloginUser:single.UserName  stepType:fag page:pageNum rows:20 andToken:single.Token companyID:single.CompanyID title:@"" SuccessBlock:^(NSDictionary *dic) {
        if([dic[@"Flag"]isEqualToString:@"S"]){
        if (pageNum ==0) {
            [finallyArray removeAllObjects];
        }
        pageNum ++;
        NSMutableArray *dataArray =[NSMutableArray arrayWithCapacity:0];
        [dataArray removeAllObjects];
        dataArray = dic[@"FlowRunStepList"];
        [finallyArray addObjectsFromArray:dic[@"FlowRunStepList"]];
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
        if (dataArray.count==0) {
            [self.tableView.footer endRefreshingWithNoMoreData];
        }
        [_Hud hide:YES];
        [self.tableView reloadData];
        }else{
            [self alterController:self];
            [_Hud hide:YES];
         }
      } FailuerBlock:^(NSString *str) {
          MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          hud.mode = MBProgressHUDModeText;
          hud.labelText = @"您的网络不给力!";
          [hud hide: YES afterDelay: 2];
     }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger row;
    row = finallyArray.count;
    return row;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger indexH;
    indexH=60;
    return indexH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    MyTaskTableViewCell *myTaskCell =[tableView dequeueReusableCellWithIdentifier:@"MyTaskTableViewCell" forIndexPath:indexPath];
        myTaskCell.taskNumber.text= [NSString stringWithFormat:@"%ld",indexPath.row+1];
        NSString *str ;
        if ([finallyArray[indexPath.row][@"StepFlag"]isEqualToString:@"1"] ) {
            str =@"未接受";
        }
        else if ([finallyArray[indexPath.row][@"StepFlag"]isEqualToString:@"2"]){
            str =@"办理中";
        }
        else{
            str =@"已办理";
        }
        myTaskCell.taskContent.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",finallyArray[indexPath.row][@"RunID"],finallyArray[indexPath.row][@"RunName"],finallyArray[indexPath.row][@"ID"],finallyArray[indexPath.row][@"RStepID"],finallyArray[indexPath.row][@"StepName"],str];
        cell= myTaskCell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        MyTaskSkimTableViewController *skimVC = [[MyTaskSkimTableViewController alloc]init];
        skimVC.flowid     =  [finallyArray[indexPath.row][@"FlowID"] intValue];
        if (![finallyArray[indexPath.row][@"FormID"]isKindOfClass:[NSNull class]]) {
            skimVC.pid        =  [finallyArray[indexPath.row][@"FormID"] intValue];
        }
        if (![finallyArray[indexPath.row][@"RunID"]isKindOfClass:[NSNull class]]) {
            skimVC.runID      =  [finallyArray[indexPath.row][@"RunID"] intValue];
        }
        if (![finallyArray[indexPath.row][@"FlowStepID"]isKindOfClass:[NSNull class]]) {
            skimVC.FlowStepID =  [finallyArray[indexPath.row][@"FlowStepID"]intValue];
        }
        if (![finallyArray[indexPath.row][@"ID"]isKindOfClass:[NSNull class]]) {
            skimVC.fRunStepID =  [finallyArray[indexPath.row][@"ID"]intValue];
        }
//      skimVC.companyID = single.CompanyID ;
        skimVC.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:skimVC animated:YES];
    }
}

- (IBAction)selectTaskClick:(id)sender {
    _control =sender;
    pageNum = 0;
    switch (_control.selectedSegmentIndex) {
        case 0:
            _control.momentary = NO;
            [self getToken:1];
            break;
        case 1:
            _control.momentary = NO;
            [self getToken:5];
         break;
            
         case 2:
            _control.momentary = NO;
            [self getToken:1];
         break;
            
         case 3:
            _control.momentary = YES;
            [self moreBtn];
        break;
            
        default:
            break;
    }
}

-(void)click:(UISegmentedControl *)segmetC{
    NSInteger index  = segmetC.selectedSegmentIndex;
    switch (index) {
        case 0:
            pageNum =0 ;
            [self getToken:1];
            break;
        case 1:
            pageNum =0 ;
            [self getToken:3];
            break;
        case 2:
            pageNum =0 ;
            [self getToken:4];
            break;
        case 3:
            pageNum = 0;
            [self moreBtn];
            break;
        case 4:
            pageNum = 0;
            [self getToken:0];
            break;
        case 5:
            pageNum = 0;
            [self getToken:0];
            break;
        default:
            break;
    }
}

-(void)getToken:(int)fag{
    [self getPastAndNowTask:fag];
}

-(void)sendInfo:(NSInteger)fag imageType:(id)type{
//    if ([type isKindOfClass:[UIImage class]]) {
//        [navView.companyBtn setImage:type forState:UIControlStateNormal];
//    }else{
//        [navView.companyBtn sd_setImageWithURL:[NSURL URLWithString:type] forState:UIControlStateNormal];
//    }
//    pageNum =0;
//    [self getPastAndNowTask:fag];
    
    //    WW_SetViewController *VC = [[WW_SetViewController alloc]init];
    //    [self.navigationController pushViewController:VC animated:YES];

    LeftMenuViewDemo *demo = [[LeftMenuViewDemo alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 0.8, [[UIScreen mainScreen] bounds].size.height)];
    demo.customDelegate = self;
    
    MenuView *menu = [MenuView MenuViewWithDependencyView:self.view MenuView:demo isShowCoverView:YES];
    self.leftmenu = menu;
    [self.leftmenu show];
    
}

-(void)alterController:(UIViewController *)view{
    UIAlertController *alterController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UserLogViewController *VC = [[UserLogViewController alloc]initWithNibName:@"UserLogViewController" bundle:nil];
        [VC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults  removeObjectForKey:@"UserLog"];        [defaults removeObjectForKey:@"userID"];

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


-(void)getCompanyInfo{
    single =[Single Send];
    companyArr = [NSArray array];
    [HttpRequestSerVice getUserCompanyid:single.userID andToken:single.Token SuccessBlock:^(NSDictionary *dic){
        if ([dic[@"Flag"]isEqualToString:@"S"]) {
            companyArr = dic[@"CompanyArray"];
        }
    } FailuerBlock:^(NSString *str) {
        
    }];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults  removeObjectForKey:@"UserLog"];
    [defaults removeObjectForKey:@"userID"];
    [defaults removeObjectForKey:@"Token"];
    [defaults removeObjectForKey:@"UserName"];
    [defaults removeObjectForKey:@"CompanyID"];
    [defaults removeObjectForKey:@"password"];
    [self presentViewController:VC animated:YES completion:nil];
}

@end
