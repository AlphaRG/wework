//
//  WW_SetViewController.m
//  Wispeed
//
//  Created by RainGu on 17/4/12.
//  Copyright © 2017年 Wispeed. All rights reserved.
#import "WW_SetViewController.h"
#import "MyselfnextTableViewCell.h"
#import "loginAndSafeController.h"
@interface WW_SetViewController ()
{
    NSMutableDictionary *_cellDic;
}
@end

@implementation WW_SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    _cellDic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSDictionary *dic = @{@"imageName":@"login_safe",@"name":@"登录与安全"};
    [_cellDic addEntriesFromDictionary:dic];
    [self setTableView];
}

-(void)setTableView{
    NSArray *arr = @[@"登录与安全"];
    [self.dataArray addObject:arr];
    [self.tableView registerClass:@[@"MyselfnextTableViewCell"]];
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    MyselfnextTableViewCell *loginAndSafe = [tableView dequeueReusableCellWithIdentifier:@"MyselfnextTableViewCell" forIndexPath:indexPath];
    [loginAndSafe configData:_cellDic];
    cell = loginAndSafe;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        loginAndSafeController *vc = [[loginAndSafeController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
