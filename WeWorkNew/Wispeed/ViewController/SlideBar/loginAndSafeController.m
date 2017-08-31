//
//  loginAndSafeController.m
//  Wispeed
//
//  Created by RainGu on 2017/5/9.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "loginAndSafeController.h"
#import "loginAndSafeViewCell.h"
#import "GestureViewController.h"
#import "PCCircleViewConst.h"
#import "FingerPrintViewController.h"
@interface loginAndSafeController ()
{
    NSMutableDictionary *celldic;
    loginAndSafeViewCell *_logincell;
}

@end

@implementation loginAndSafeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录与安全";
    celldic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [self setTableViewInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setTableViewInfo{
    NSArray *arr = @[@{@"name":@"手势登录",@"tag":@0},@{@"name":@"指纹登录",@"tag":@1}];
    [self.dataArray addObject:arr];
    [self.tableView registerClass:@[@"loginAndSafeViewCell"]];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    loginAndSafeViewCell *safecell = [tableView dequeueReusableCellWithIdentifier:@"loginAndSafeViewCell" forIndexPath:indexPath];
    [safecell configData:self.dataArray[indexPath.section][indexPath.row]];
    safecell.tag = (indexPath.section +1)*100 +indexPath.row ;
    cell = safecell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self setGestureView];
                break;
            case 1:
                [self setFingerPrintView];
                break;
            default:
                break;
        }
    }
}

-(void)setGestureView{
    GestureViewController *gestureVc = [[GestureViewController alloc] init];
    gestureVc.type = GestureViewControllerTypeSetting;
    gestureVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gestureVc animated:YES];
//    FingerPrintViewController *fingerView = [[FingerPrintViewController alloc] init];
//    fingerView.type = GestureViewControllerTypeSet;
//    fingerView.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:fingerView animated:YES];
}

-(void)setFingerPrintView{
    FingerPrintViewController *fingerView = [[FingerPrintViewController alloc] init];
    fingerView.type = fingerPrintTypeSet;
    fingerView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fingerView animated:YES];
}

@end
