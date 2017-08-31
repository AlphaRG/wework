//  WW_NewMyTaskViewController.m
//  Wispeed
//  Created by RainGu on 2017/5/3.
//  Copyright © 2017年 Wispeed. All rights reserved.

#import "WW_NewMyTaskViewController.h"
#import "UIView+RGExtension.h"
#import "RightTableViewCell.h"
#import "Masonry.h"
#import "WW_heardView.h"
#import "YBPopupMenu.h"
#import "Single.h"
#import "MJRefresh.h"
#import "MyTaskSkimTableViewController.h"
#import "DataBaseManager.h"
#define LabelWidth 70
#define LabelHeight 30
@interface WW_NewMyTaskViewController ()<UITableViewDelegate,UITableViewDataSource,sendBtnInfoDelegate,YBPopupMenuDelegate,noticeBtnDelegate>{
    
    UISegmentedControl *_segmentC;
    NSMutableArray *finallyArray,*HeadTitleArray,*numArray;
    Single *single;
    NSInteger pageNum,Tfag;
    MBProgressHUD *_Hud;
    NSString *taskTitle;
    UILabel *lab ,*lab2,*lab3 ;
}
@end

@implementation WW_NewMyTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的任务";
    single = [Single Send];
 
    finallyArray =[NSMutableArray arrayWithCapacity:0];
    HeadTitleArray   =[NSMutableArray arrayWithCapacity:0];
    numArray         = [NSMutableArray arrayWithCapacity:0];
    
    taskTitle = @"FlowRunStepList";
    self.viewType = readyView;
    pageNum = 0;
    [self getTitleContent:1];
    [self loadRightTableView];
    self.taskListTableView.footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getPastAndNowTask:Tfag fag:0];
    }];
    self.taskListTableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageNum =0;
        [self getPastAndNowTask:Tfag fag:0];
        UITabBarItem * item=[self.tabBarController.tabBar.items objectAtIndex:0];
        item.badgeValue = nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
  [_Hud hide:YES];
  [self getTaskType];
}

- (void)loadRightTableView{
    _segmentC = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"待办",@"已办",@"关注",@"更多",nil]];
    _segmentC.frame = CGRectMake(0,64,ScreenWidth,40);
    _segmentC.tintColor = [UIColor whiteColor];
    _segmentC.backgroundColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
    _segmentC.layer.cornerRadius = 5.0;
    _segmentC.layer.masksToBounds = YES;
    _segmentC.selectedSegmentIndex =0;
    [_segmentC addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: _segmentC];
    
    lab = Label.addTo(self.view).xywh(ScreenWidth/4-18,64,18,18).bgColor(@"blue").color(@"white").centerAlignment.borderRadius(9).fnt(14).str(@"12");
    lab2 = Label.addTo(self.view).xywh(ScreenWidth/2-18,64,18,18).bgColor(@"blue").color(@"white").centerAlignment.borderRadius(9).fnt(14).str(@"12");
    lab3 = Label.addTo(self.view).xywh((ScreenWidth/4 *3)-18,64,18,18).bgColor(@"blue").color(@"white").centerAlignment.borderRadius(9).fnt(14).str(@"12");
    lab.hidden  = YES;
    lab2.hidden = YES;
    lab3.hidden = YES;
    
    UILabel  *labletext = [[UILabel alloc]initWithFrame:CGRectMake(0,105, ScreenWidth, 1)];
    labletext.backgroundColor = [UIColor blackColor];
    [self.view addSubview:labletext];
    
    self.taskListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,HeadTitleArray.count * (LabelWidth+5)+LabelWidth*6 ,ScreenHeight) style:UITableViewStylePlain];
    self.taskListTableView.delegate   = self;
    self.taskListTableView.dataSource = self;
    self.taskListTableView.showsVerticalScrollIndicator = NO;
    
    self.buttomScrollView = [[UIScrollView alloc] init];
    self.buttomScrollView.contentSize = CGSizeMake(self.taskListTableView.bounds.size.width, 0);
    self.buttomScrollView.bounces = NO;
    self.buttomScrollView.showsHorizontalScrollIndicator = NO;
    [self.buttomScrollView addSubview:self.taskListTableView];
    [self.view addSubview:self.buttomScrollView];
    
    [self.buttomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.and.left.equalTo(self.view);
        make.top.mas_equalTo(_segmentC.mas_bottom).offset(3);
    }];
    self.taskListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  }

-(void)click:(UISegmentedControl *)sender{
        NSInteger index  = sender.selectedSegmentIndex;
        switch (index) {
            case 0:
                pageNum = 0 ;
                self.viewType = readyView;
                taskTitle = @"FlowRunStepList";
                [self getPastAndNowTask:1 fag:0];
                [self getTitleContent:1];
                break;
            case 1:
                pageNum = 0 ;
                self.viewType = alreadyView;
                taskTitle = @"FlowRunStepList";
                [self getTitleContent:2];
                [self getPastAndNowTask:2 fag:0];
                break;
            case 2:
                pageNum = 0 ;
                self.viewType = noticeView;
                taskTitle = @"FlowRunStepList";
                [self getTitleContent:3];
                [self getPastAndNowTask:3 fag:0];
                break;
            case 3:
                [self moreBtn];
                break;
            case 4:
            
                break;
            case 5:
               
                break;
            default:
                break;
        }

}

-(void)moreBtn{
    NSArray *titles = @[@"发起",@"测试",@"管理",@"总览"];
    [YBPopupMenu showAtPoint:CGPointMake(ScreenWidth-40, 105) titles:titles icons:nil menuWidth:80 fag:100 delegate:self];
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:HeadTitleArray.count Fag:self.viewType];
    cell.nodelegate =self;
    [cell coreData:finallyArray[indexPath.row] fag:self.viewType cell:cell];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTaskSkimTableViewController *skimVC = [[MyTaskSkimTableViewController alloc]init];
    skimVC.flowid     =  [finallyArray[indexPath.row][@"FlowID"] intValue];
    skimVC.pid        =  [finallyArray[indexPath.row][@"FormID"] intValue];
    skimVC.runID      =  [finallyArray[indexPath.row][@"RunID"] intValue];
    skimVC.FlowStepID =  [finallyArray[indexPath.row][@"FlowStepID"]intValue];
    skimVC.fRunStepID =  [finallyArray[indexPath.row][@"ID"]intValue];
    skimVC.SampleType =  [finallyArray[indexPath.row][@"SampleType"] integerValue];
    skimVC.viewtype = self.viewType;
    skimVC.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:skimVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return finallyArray.count;
}

#pragma mark --设置头部view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WW_heardView *rightHeaderView = [[WW_heardView alloc]init];
    UIView *titleview ;
    switch (self.viewType) {
        case 0:
            self.taskListTableView.frame =CGRectMake(0,0,HeadTitleArray.count * (LabelWidth+5)+LabelWidth*6,ScreenHeight);
            self.buttomScrollView.contentSize = CGSizeMake(self.taskListTableView.bounds.size.width, 0);
            titleview = [rightHeaderView viewWithButtonNumber:HeadTitleArray.count];
            break;
        case 1:
            self.taskListTableView.frame =CGRectMake(0,0,HeadTitleArray.count * (LabelWidth+5)+LabelWidth*5 ,ScreenHeight);
            self.buttomScrollView.contentSize = CGSizeMake(self.taskListTableView.bounds.size.width, 0);
            titleview  = [rightHeaderView viewWithButtonNumber1:HeadTitleArray.count];
            break;
        case 2:
            self.taskListTableView.frame =CGRectMake(0,0,HeadTitleArray.count * (LabelWidth+5)+LabelWidth*7,ScreenHeight);
            self.buttomScrollView.contentSize = CGSizeMake(self.taskListTableView.bounds.size.width, 0);
            titleview  = [rightHeaderView viewWithButtonNumber2:HeadTitleArray.count];
            break;
        case 3:
            self.taskListTableView.frame =CGRectMake(0,0,HeadTitleArray.count * (LabelWidth+5)+LabelWidth*7,ScreenHeight);
            self.buttomScrollView.contentSize = CGSizeMake(self.taskListTableView.bounds.size.width, 0);
            titleview  = [rightHeaderView viewWithButtonNumber3:HeadTitleArray.count];
            break;
        case 4:
            self.taskListTableView.frame =CGRectMake(0,0,HeadTitleArray.count * (LabelWidth+5)+LabelWidth*5,ScreenHeight);
            self.buttomScrollView.contentSize = CGSizeMake(self.taskListTableView.bounds.size.width, 0);
            titleview  = [rightHeaderView viewWithButtonNumber4:HeadTitleArray.count];
            break;
        case 5:
            self.taskListTableView.frame =CGRectMake(0,0,HeadTitleArray.count * (LabelWidth+5)+LabelWidth*7,ScreenHeight);
            self.buttomScrollView.contentSize = CGSizeMake(self.taskListTableView.bounds.size.width, 0);
            titleview  = [rightHeaderView viewWithButtonNumber5:HeadTitleArray.count];
            break;
        case 6:
            self.taskListTableView.frame =CGRectMake(0,0,HeadTitleArray.count * (LabelWidth+5)+LabelWidth*6 ,ScreenHeight);
            self.buttomScrollView.contentSize = CGSizeMake(self.taskListTableView.bounds.size.width, 0);
            titleview = [rightHeaderView viewWithButtonNumber5:HeadTitleArray.count];
            break;
        default:
            break;
    }
    rightHeaderView.delegate = self;
    int i = 0;
    for (id view in titleview.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.text = HeadTitleArray[i++][@"title"];
        }
    }
    titleview.backgroundColor = [UIColor whiteColor];
    return titleview;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,160)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

-(void)noticeBtnDelegat:(id)tag{
    UIButton *btn = (UIButton *)tag;
    [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    UITableViewCell *cell = (UITableViewCell *)[[[btn superview] superview] superview];
    NSIndexPath *indexPath = [self.taskListTableView indexPathForCell:cell];
    NSInteger ID = [finallyArray[indexPath.row][@"ID"] integerValue];
    NSNumber *nID = [NSNumber numberWithInteger:ID];
    
    NSDictionary *dic = @{@"ID":nID,@"UID":[NSNumber numberWithInt:single.userID],@"Token":single.Token};
    [self notivced:dic];
}

-(void)notivced:(NSDictionary *)dic1{
    NSString *url = [NSString stringWithFormat:@"%@UserMark",URLM];
    NSInteger type = 1;
    pageNum = pageNum -1;
    switch (self.viewType) {
        case 0:
            type =1;
            break;
        case 1:
            type = 4;
            break;
        case 2:
            type = 3;
            break;
        case 3:
            type = 7;
            break;
        case 4:
            type = 5 ;
            break;
         case 5:
            type = 0;
            break;
         case 6:
            type= 2;
            break;
        default:
            break;
    }
   [HttpRequestSerVice getDicUrl:url Dic:dic1 Title:nil SuccessBlock:^(NSDictionary *dic) {
       [self getPastAndNowTask:type fag:0];
   } FailuerBlock:^(NSString *str) {
      [CommoneTools alertOnView:self.view content:str];
  }];
}
//必须实现以下方法才可以使用自定义头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 160;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.taskListTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}

-(void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu{
    if (ybPopupMenu.fag == 100) {
        switch (index) {
            case 0:
                pageNum = 0 ;
                self.viewType = findView;
                taskTitle = @"FlowList";
                [self getTitleContent:4];
                [self getPastAndNowTask:4 fag:0];
                break;
            case 1:
                pageNum = 0 ;
                self.viewType = testView;
                taskTitle = @"FlowRunStepList";
                [self getTitleContent:7];
                [self getPastAndNowTask:7 fag:0];
                break;
            case 2:
                pageNum = 0 ;
                self.viewType = managerView;
                 taskTitle = @"FlowList";
                [self getTitleContent:5];
                [self getPastAndNowTask:5 fag:0];
                break;
            case 3:
                pageNum = 0 ;
                self.viewType = allView;
                [self getTitleContent:0];
                taskTitle = @"FlowRunStepList";
                [self getPastAndNowTask:0 fag:0];
                break;
            default:
                break;
        }
    }else if(ybPopupMenu.fag == 200){
            switch (index) {
            case 0:
                [self scanView];
                break;
            default:
                [self jumpMarketView];
                break;
        }
    }else{
        pageNum = 0 ;
        self.viewType = readyView;
        [self getPastAndNowTask:1 fag:0];
        [self getTitleContent:1];
    }
}

-(void)getTaskType{
    NSInteger type = 1;
    if(pageNum != 0){
     pageNum = pageNum -1;
    }
    switch (self.viewType) {
        case 0:
            type =1;
            break;
        case 1:
            type = 4;
            break;
        case 2:
            type = 3;
            break;
        case 3:
            type = 7;
            break;
        case 4:
            type = 5 ;
            break;
        case 5:
            type = 0;
            break;
        case 6:
            type= 2;
            break;
        default:
            break;
    }
    [self getPastAndNowTask:2 fag:2];
    [self getPastAndNowTask:3 fag:3];
    [self getPastAndNowTask:1 fag:1];
    [self getPastAndNowTask:type fag:0];
}

-(void)getPastAndNowTask:(NSInteger)fag fag:(NSInteger)viewtag{
    Tfag = fag;
    [_Hud hide:YES];
    _Hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _Hud.labelText = @"加载中……";
    _Hud.labelFont = [UIFont systemFontOfSize:12];
    _Hud.margin = 10.0f;
    _Hud.removeFromSuperViewOnHide = YES;
    [_Hud hide:YES afterDelay:10];
    single.CompanyID =0;
    [HttpRequestSerVice TaskListloginUser:single.UserName  stepType:fag page:pageNum rows:5000 andToken:single.Token companyID:single.CompanyID title:taskTitle SuccessBlock:^(NSDictionary *dic) {
        if([dic[@"Flag"]isEqualToString:@"S"]){
            if (pageNum ==0) {
                [finallyArray removeAllObjects];
            }
            NSMutableArray *dataArray =[NSMutableArray arrayWithCapacity:0];
            [dataArray removeAllObjects];
            dataArray = dic[@"FlowRunStepList"];
            if (viewtag == 0) {
                pageNum ++;
                [finallyArray addObjectsFromArray:dic[@"FlowRunStepList"]];
            }else{
                [numArray removeAllObjects];
                [numArray addObjectsFromArray:dic[@"FlowRunStepList"]];
            }
            [self.taskListTableView.footer endRefreshing];
            [self.taskListTableView.header endRefreshing];
            if (dataArray.count==0) {
                [self.taskListTableView.footer endRefreshingWithNoMoreData];
            }
            [_Hud hide:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.taskListTableView reloadData];
            });
        }else{
            [_Hud hide:YES];
            [finallyArray removeAllObjects];
            [self.taskListTableView reloadData];
            [CommoneTools alertOnView:self.view content:dic[@"FlowRunStepList"]];
         }
        [self setNum:viewtag];
        if (viewtag==0) {
            [self getlocalData];
        }
        } FailuerBlock:^(NSString *str) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力!";
        [hud hide: YES afterDelay: 2];
    }];
}

-(void)getTitleContent:(NSInteger)fag{
    NSString *url = [NSString stringWithFormat:@"%@TaskTitle",URLM];
    NSNumber *UID = [NSNumber numberWithInteger:single.userID];
    NSNumber *type= [NSNumber numberWithInteger:fag];
    NSDictionary *dic=@{
                        @"UID":UID,
                        @"SetType":type,
                        @"Token":single.Token
                        };
    [HttpRequestSerVice getDicUrl:url Dic:dic Title:nil SuccessBlock:^(NSDictionary *dic) {
      if ([dic[@"OMsg"][@"Flag"] isEqualToString:@"S"]) {
           [HeadTitleArray removeAllObjects];
           [HeadTitleArray addObjectsFromArray:dic[@"Columns"]];
           [self.taskListTableView reloadData];
        }else{
        }
    } FailuerBlock:^(NSString *str) {
    }];
}

-(void)setNum:(NSInteger)fag{
    switch (fag) {
            case 1:
            lab.hidden = NO;
            lab.str(numArray.count);
            break;
            
            case 2:
            lab2.hidden = NO;
            lab2.str(numArray.count);
            break;
            case 3:
            lab3.hidden = NO;
            lab3.str(numArray.count);
            break;
        default:
            break;
    }
    switch (self.viewType) {
            case 0:
            lab.hidden = NO;
            lab.xy(ScreenWidth/4 -18,64).str(finallyArray.count);
            if (finallyArray.count == 0) {
                lab.hidden = YES;
                UIApplication *app = [UIApplication sharedApplication];
                app.applicationIconBadgeNumber = 0;
            }else{
                lab.hidden = NO;
                UIApplication *app = [UIApplication sharedApplication];
                app.applicationIconBadgeNumber = finallyArray.count;
             }
            break;
            case 6:
            lab2.hidden = NO;
            lab2.str(finallyArray.count);
            break;
            case 2:
            lab3.hidden = NO;
            lab3.str(finallyArray.count);
            break;
        default:
            break;
    }
    
}

-(void)getlocalData{
    DataBaseManager *localManager = [DataBaseManager sharedDataBase:DATANAME];
    __weak typeof(self) weakSelf = self;
    if (localManager.typestatic) {
        [localManager selectedData:DATANAME Params:@{@"url":[NSString stringWithFormat:@"select * from  %@  where viewType = %ld and userID = %d",DATATABLE,(long)self.viewType,single.userID]} result:^(bool res,__weak id data) {
            UITabBarItem * item=[self.tabBarController.tabBar.items objectAtIndex:0];
            NSMutableArray *arr = (NSMutableArray *)data;
            NSInteger Arrcount = finallyArray.count -arr.count;
            if (Arrcount == 0) {
                item.badgeValue = nil;
            }else{
                item.badgeValue = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%ld",finallyArray.count-arr.count]];
            }
        }];
        
    }else{
        [localManager insertData:DATANAME Params:@{@"url":CREATEFMDBDATA} result:^(bool res, __weak id data) {
            __weak
            UITabBarItem * item=[weakSelf.tabBarController.tabBar.items objectAtIndex:0];
            item.badgeValue = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%ld",finallyArray.count]];
            localManager.typestatic = YES;
        }];
    }
}
@end
