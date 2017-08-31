//
//  MyTaskSkimTableViewController.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/13.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTaskSkimTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)int flowid;
@property(nonatomic,assign)int pid;
@property(nonatomic,assign)int runID;
@property(nonatomic,assign)int FlowStepID;
@property(nonatomic,assign)int fRunStepID;
@property(nonatomic,assign)viewType viewtype;
@property(nonatomic,assign)NSInteger SampleType;
@property(nonatomic,strong)UITableView *tableView;
@end

