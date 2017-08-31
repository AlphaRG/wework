//
//  WW_NewMyTaskViewController.h
//  Wispeed
//
//  Created by RainGu on 2017/5/3.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "RGBaseViewController.h"

@interface WW_NewMyTaskViewController :RGBaseViewController
@property(nonatomic,strong)UITableView *taskListTableView;
@property (nonatomic,strong)NSArray *secondTitles;
@property (nonatomic,strong)UIScrollView *buttomScrollView;
@property (nonatomic,assign)viewType  viewType;
@end
