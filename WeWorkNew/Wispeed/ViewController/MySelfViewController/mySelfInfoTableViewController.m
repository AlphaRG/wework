//  mySelfInfoTableViewController.m
//  Wispeed
//  Created by sunshaoxun on 16/7/26.
//  Copyright © 2016年 Wispeed. All rights reserved.

#import "mySelfInfoTableViewController.h"
#import "mySelfInfoTableViewCell.h"
#import  "UserLogViewController.h"
@interface mySelfInfoTableViewController ()<ExitDelegate>

@end

@implementation mySelfInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:@[@"mySelfInfoTableViewCell"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.title = self.titlename;
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
