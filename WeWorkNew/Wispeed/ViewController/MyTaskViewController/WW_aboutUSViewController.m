//
//  WW_aboutUSViewController.m
//  Wispeed
//
//  Created by RainGu on 17/4/25.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "WW_aboutUSViewController.h"
#import "Masonry.h"
@interface WW_aboutUSViewController ()
@end

@implementation WW_aboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    
    self.contentText = [[UILabel alloc]init];
    self.contentText.textColor = [UIColor lightGrayColor];
    self.contentText.font =[UIFont systemFontOfSize:14.0];
    self.contentText.numberOfLines = 0;
    self.contentText.text = @"唯沃客是一款适用于公司员工彼此交流的软件。它可以让员工随时谁地的了解自己的工作任务状态以及查看自己的工作绩效。从而更好的安排自己的时间与精力以致提高工作效率.";

    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight)];
    [_contentView setBackgroundColor: [UIColor whiteColor]];

    [self.contentView addSubview:self.contentText];
    [self.view addSubview:self.contentView];
    [self updateView];
}

-(void)updateView{
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(84);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.right.mas_equalTo(self.contentView).offset(-20);

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
