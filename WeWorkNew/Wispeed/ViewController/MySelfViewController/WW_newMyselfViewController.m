//  WW_newMyselfViewController.m
//  Wispeed
//  Created by RainGu on 17/4/20.
//  Copyright © 2017年 Wispeed. All rights reserved.

#import "WW_newMyselfViewController.h"
#import "NavigationView.h"
#import "Single.h"
#import "mySelfInfoTableViewController.h"
#import "UserLogViewController.h"
#import "mySelfInfoTableViewCell.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
#import "WW_SetViewController.h"
#import "WW_aboutUSViewController.h"
#import "YBPopupMenu.h"
#import "WW_marketViewController.h"
#import "SDScanViewController.h"
@interface WW_newMyselfViewController ()<UITableViewDataSource,UITableViewDelegate,ExitDelegate,sendInfoDelegate,HomeMenuViewDelegate,YBPopupMenuDelegate>
{
    UISegmentedControl  *_segment;
    NavigationView      *_navView;
    Single              *_single;
    NSMutableDictionary *finallyDic;
    UITableView         *_myTableView;
    NSMutableArray      *_lastdataA;
    UIButton            *rightBtn;
    
}
@property (nonatomic ,strong)MenuView      *leftmenu;

@end

@implementation WW_newMyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:24/255.0 green:147/255.0 blue:30/255.0 alpha:0.6];
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _navView  = [[NavigationView alloc]initWithFrame:CGRectMake(0,0,44,44) view:self.view tag:0];
    _navView.delegate = self;
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:_navView];
    
    _segment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"个人信息",@"公司信息",@"自有资源",nil]];
    _segment.frame = CGRectMake(0,0,ScreenWidth,40);
    _segment.tintColor = [UIColor whiteColor];
    _segment.backgroundColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
    _segment.layer.cornerRadius = 5.0;
    _segment.layer.masksToBounds = YES;
    _segment.selectedSegmentIndex =0;
    [_segment addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    
    UILabel  *labletext = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, ScreenWidth, 1)];
    labletext.backgroundColor = [UIColor blackColor];
    [self.view addSubview:labletext];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,42, ScreenWidth,ScreenHeight-41) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView registerNib:@[@"mySelfInfoTableViewCell"]];
    [self.tableView registerNib:@[@"mySelfInfoTableViewCell"]];
    [self.view addSubview:_myTableView];
    
    finallyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    _lastdataA = [NSMutableArray arrayWithCapacity:0];
    _single = [Single Send];
    
    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(navRightClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem ;

    [self.view setBackgroundColor:[UIColor blackColor]];
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

-(void)click:(UISegmentedControl *)segmet{
    NSInteger index = segmet.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self sendSelfInfo];
        break;
        case 1:
            [self sendCompanyInfo];
        break;
        case 2:
            [self.dataArray removeAllObjects];
            [_myTableView reloadData];
        break;
            
        default:
            break;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidAppear:(BOOL)animated{
    _segment.selectedSegmentIndex =0;
    [self sendSelfInfo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)sendSelfInfo{
    mySelfInfoTableViewController *InfoVC = [[mySelfInfoTableViewController alloc]initWithNibName:@"mySelfInfoTableViewController" bundle:nil];
    NSString *usex;
    if ([_single.sex boolValue] == true) {
        usex =@"男";
    }else{
        usex = @"女";
    }
    NSArray *dataA = @[@[@{@"name":@"头像",@"info":_single.headImg,@"tag":@"0"},@{@"name":@"用户名",@"info":_single.UserName,@"tag":@"1"},@{@"name":@"姓名",@"info":_single.NickName,@"tag":@"1"},@{@"name":@"性别",@"info":usex,@"tag":@"1"}],@[@{@"name":@"手机",@"info":_single.tel,@"tag":@"1"},@{@"name":@"邮箱",@"info":_single.email,@"tag":@"1"},@{@"name":@"住址",@"info":_single.area,@"tag":@"1"}]];
    [_lastdataA removeAllObjects];
    [_lastdataA addObjectsFromArray:dataA];
    self.dataArray = _lastdataA;
//    InfoVC.titlename = @"个人信息";
//    InfoVC.dataArray = dataA;
//    _myTableView= InfoVC.tableView;
//    InfoVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:InfoVC animated:YES];
    [_myTableView reloadData];
}

-(void)sendCompanyInfo{
    NSMutableArray *compayArray = [NSMutableArray arrayWithCapacity:0];
    [HttpRequestSerVice getUserInfoid:_single.userID Token:_single.Token SuccessBlock:^(NSDictionary *dic) {
        if ([dic[@"OMsg"][@"Flag"] isEqualToString:@"S"]){
            [finallyDic setDictionary:dic];
            mySelfInfoTableViewController *InfoVC = [[mySelfInfoTableViewController alloc]initWithNibName:@"mySelfInfoTableViewController" bundle:nil];
            InfoVC.titlename = @"公司信息";
            NSArray *arr = finallyDic[@"DepartmentList"];
            for (NSDictionary *companyDic in arr) {
                NSString *companyName,*departmentName,*station,*logo;
                if ([companyDic[@"CompanyFullName"]isKindOfClass:[NSNull class]]) {
                    companyName = @"";
                }else{
                    companyName  = companyDic[@"CompanyFullName"];
                }
                if ([companyDic[@"DepartmentName"]isKindOfClass: [NSNull class]]) {
                    departmentName = @"";
                }else{
                    departmentName =companyDic[@"DepartmentName"];
                }
                if ([companyDic[@"Station"]isKindOfClass:[NSNull class]]) {
                    station =@"";
                }else{
                    station = companyDic[@"Station"];
                }
                if ([companyDic[@"CompanyName"]isKindOfClass:[NSNull class]]) {
                    logo =@"";
                }else{
                    logo = companyDic[@"CompanyName"];
                }
                NSArray *dataA = @[@[@{@"name":@"公司简称",@"info":logo,@"tag":@"1",@"companyname":companyName},@{@"name":@"公司名",@"info":companyName,@"tag":@"1",@"companyname":companyName},@{@"name":@"部门",@"info":departmentName,@"tag":@"1",@"companyname":companyName},@{@"name":@"岗位",@"info":station,@"tag":@"1",@"companyname":companyName}]];
                [compayArray addObjectsFromArray:dataA];
                _lastdataA = compayArray;
            }
//            InfoVC.dataArray = compayArray;
//            InfoVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:InfoVC animated:YES];
              self.dataArray = _lastdataA;
              [_myTableView reloadData];
        }else{
            [CommoneTools alertOnView:self.view content:dic[@"OMsg"][@"Msg"]];
        }
    } FailuerBlock:^(NSString *str) {
        [CommoneTools alertOnView:self.view content:str];
    }];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowA = self.dataArray[section];
    return rowA.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger h = [self.dataArray[indexPath.section][indexPath.row][@"tag"] intValue];
    switch (h) {
        case 0:
            return 60;
            break;
        default:
            return 44;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    mySelfInfoTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"mySelfInfoTableViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setViewInfo:self.dataArray[indexPath.section][indexPath.row]];
    return cell;
}

-(void)exit:(NSInteger)tag{
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
