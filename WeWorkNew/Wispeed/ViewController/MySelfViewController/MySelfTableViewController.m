//
//  MySelfTableViewController.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/11.
//  Copyright © 2016年 Wispeed. All rights reserved.

#import "MySelfTableViewController.h"
#import "NavigationView.h"
#import "MyselfTableViewCell.h"
#import "SelfInfoTableViewCell.h"
#import "HttpRequestSerVice.h"
#import "Single.h"
#import "mySelfInfoTableViewController.h"
#import "MyTaskTableViewController.h"
#import "MyselfnextTableViewCell.h"
#import "ThirdAccountRegisterTableViewCell.h"
#import "WWMySelfViewController.h"
#import "LeftMenuViewDemo.h"
@interface MySelfTableViewController ()<sendInfoDelegate>
{
    NavigationView *navView;
    NSMutableDictionary *finallyDic;
    Single *single;
}
@end
@implementation MySelfTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    single =[Single Send];
    [self.tableView registerClass:@[@"MyselfnextTableViewCell",@"ThirdAccountRegisterTableViewCell"]];
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:5/255.0 green:5/255.0 blue:5/255.0 alpha:1.0];
    finallyDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navView  = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0,44,44) view:self.view tag:1];
    navView.delegate =self;
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:navView];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)sendInfo:(NSInteger)fag imageType:(id)type{
    if ([type isKindOfClass:[UIImage class]]) {
        [navView.companyBtn setImage:type forState:UIControlStateNormal];
    }else{
        [navView.companyBtn sd_setImageWithURL:[NSURL URLWithString:type] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

-(void)getselfInfo{
    NSMutableArray *compayArray = [NSMutableArray arrayWithCapacity:0];
    [HttpRequestSerVice getUserInfoid:single.userID Token:single.Token SuccessBlock:^(NSDictionary *dic) {
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
            if ([companyDic[@"CompanyLogo"]isKindOfClass:[NSNull class]]) {
                logo =@"";
            }else{
                logo = companyDic[@"CompanyLogo"];
            }
            NSArray *dataA = @[@[@{@"name":@"公司",@"info":logo,@"tag":@"0",@"companyname":companyName},@{@"name":@"公司名",@"info":companyName,@"tag":@"1",@"companyname":companyName},@{@"name":@"部门",@"info":departmentName,@"tag":@"1",@"companyname":companyName},@{@"name":@"岗位",@"info":station,@"tag":@"1",@"companyname":companyName}]];
            [compayArray addObjectsFromArray:dataA];
        }
        InfoVC.dataArray = compayArray;
        InfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:InfoVC animated:YES];
      }else{
          [CommoneTools alertOnView:self.view content:dic[@"OMsg"][@"Msg"]];
      }
        } FailuerBlock:^(NSString *str) {
            [CommoneTools alertOnView:self.view content:str];
        }];
}

-(void)viewWillAppear:(BOOL)animated{
    if ([single.imageNavType isKindOfClass:[UIImage class]]) {
        [navView.companyBtn setImage:single.imageNavType forState:UIControlStateNormal];
    }else{
        [navView.companyBtn sd_setImageWithURL:[NSURL URLWithString:single.imageNavType] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger row;
    if (section ==0) {
        row =1;
    }else if (section ==1){
        row =1;
    }else{
        row = 1;
    }
    return row;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat heghit;
    if (indexPath.section==0) {
        heghit=102;
    }
    else{
        heghit =44;
    }
    return heghit;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height;
    if (section != 2) {
        height = 5;
    }else{
        height = 1;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section==0) {
        MyselfTableViewCell * selfCell = [tableView dequeueReusableCellWithIdentifier:@"MyselfTableViewCell" forIndexPath:indexPath];
        if ([single.headImg isEqualToString:@"Kobe.jpg"]||[single.headImg isEqualToString:@""]) {
            selfCell.userHeadImage.image = [UIImage imageNamed:@"Kobe.jpg"];
        }
        else{
            NSString *Imgstr;
            if ([single.headImg rangeOfString:@"http"].length>0)  {
                Imgstr=[single.headImg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            }else{
                NSString *str = [NSString stringWithFormat:@"%@/%@",IMGURL,single.headImg];
                Imgstr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            }
            NSURL *imageUrl =[NSURL URLWithString:Imgstr];
            [ selfCell.userHeadImage sd_setImageWithURL:imageUrl];
        }
        selfCell.userName.text = single.UserName;
        selfCell.userNickName.text = single.NickName;
        if ([single.sex boolValue]==true) {
            selfCell.userSex.text = [NSString stringWithFormat:@"性别:%@",@"男"];
        }
        else{
            selfCell.userSex.text = [NSString stringWithFormat:@"性别:%@",@"女"];
       }
        cell=selfCell;
    }
    else if(indexPath.section==1){
        MyselfnextTableViewCell *infocell = [tableView dequeueReusableCellWithIdentifier:@"MyselfnextTableViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            infocell.titleImg.image = [UIImage imageNamed:@"belong.png"];
            infocell.titleName.text = @"公司信息";
        }else{
            infocell.titleImg.image = [UIImage imageNamed:@"have.png"];
            infocell.titleName.text = @"拥有";
        }
        cell =infocell;
    }else if (indexPath.section==2){
        MyselfnextTableViewCell *infocell = [tableView dequeueReusableCellWithIdentifier:@"MyselfnextTableViewCell" forIndexPath:indexPath];
        infocell.titleImg.image = [UIImage imageNamed:@"source.png"];
        infocell.titleName.text = @"自有资源";
        cell = infocell;
    }
    else{
        MyselfnextTableViewCell *infocell = [tableView dequeueReusableCellWithIdentifier:@"MyselfnextTableViewCell" forIndexPath:indexPath];
        infocell.titleImg.image = [UIImage imageNamed:@"bild.png"];
        infocell.titleName.text = @"绑定";
        cell = infocell;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
     mySelfInfoTableViewController *InfoVC = [[mySelfInfoTableViewController alloc]initWithNibName:@"mySelfInfoTableViewController" bundle:nil];
    if (indexPath.section == 0) {
        NSString *usex;
        if ([single.sex boolValue] == true) {
            usex =@"男";
        }else{
            usex = @"女";
        }
         NSArray *dataA = @[@[@{@"name":@"头像",@"info":single.headImg,@"tag":@"0"},@{@"name":@"用户名",@"info":single.UserName,@"tag":@"1"},@{@"name":@"姓名",@"info":single.NickName,@"tag":@"1"},@{@"name":@"性别",@"info":usex,@"tag":@"1"}],@[@{@"name":@"手机",@"info":single.tel,@"tag":@"1"},@{@"name":@"邮箱",@"info":single.email,@"tag":@"1"},@{@"name":@"住址",@"info":single.area,@"tag":@"1"}],@[@{@"name":@"删除",@"info":@"",@"tag":@"2"}]];
        InfoVC.titlename = @"个人信息";
        InfoVC.dataArray = dataA;
        InfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:InfoVC animated:YES];
    }
    else if (indexPath.section == 1){
            [self getselfInfo];
    }else if (indexPath.section ==2){
        
    }
    else{
        WWMySelfViewController *VC = [[WWMySelfViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

-(void)CheckNull:(id)kindController textContent:(NSString *)textContent andnullText:(NSString *)nullText{
    if([textContent isKindOfClass:[NSNull class]]){
        kindController = nullText;
    }
    else{
        kindController = textContent;
    }
}
@end
