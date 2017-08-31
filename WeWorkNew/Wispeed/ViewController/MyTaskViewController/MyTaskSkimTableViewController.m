//  MyTaskSkimTableViewController.m
//  Wispeed
//  Created by sunshaoxun on 16/7/13.
//  Copyright © 2016年 Wispeed. All rights reserved.

#import "MyTaskSkimTableViewController.h"
#import "TaskWebTableViewCell.h"
#import "Single.h"
#import "DataBaseManager.h"
@interface MyTaskSkimTableViewController ()<UIWebViewDelegate, NSURLConnectionDelegate>
{
    Single *single;
    TaskWebTableViewCell *_webcell;
    NSURLRequest *_currentRequest;
    BOOL _judge;
    UISegmentedControl * _segmentC;
    NSString           *_webStr;
}
@end

@implementation MyTaskSkimTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,40,ScreenWidth, ScreenHeight-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:@[@"TaskWebTableViewCell"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"任务详情";
    single = [Single Send];
    [self setWebViewURL];
}

-(void)setWebViewURL{
    switch (self.viewtype) {
        case 0:
            [self setWorkPlag];
            break;
         case 1:
            _webStr =[NSString stringWithFormat:@"%@/IS/CDFormTemp/TabsPage?flowid=%d&token=%@&UserId=%d&showlog=2",URLMWWEB,_flowid,single.Token,single.userID];
            break;
          case 2:
            [self setWorkPlag];
            break;
          case 3:
            [self setWorkPlag];
            break;
          case 4:
            _webStr =[NSString stringWithFormat:@"%@/ISUI/UserDefi/Index?flowid=%d&flowRunStepID=%d&runID=%d&token=%@&UserId=%d&showlog=2",URLMWWEB,_flowid,_fRunStepID,_runID,single.Token,single.userID];
            break;
        case 5:
            [self setWorkPlag];
            break;
            
        default:
            break;
    }
    
}

-(void)setWorkPlag{
    if (self.SampleType == 1) {
        _webStr =[NSString stringWithFormat:@"%@/ISUI/UserDefi/Index?flowid=%d&flowRunStepID=%d&runid=%d&token=%@&UserId=%d&showlog=2",URLMWWEB,_flowid,_fRunStepID,_runID,single.Token,single.userID];
    }else{
        _webStr =[NSString stringWithFormat:@"%@/IS/CDFormTemp?flowid=%d&pid=%d&FlowStepID=%d&fRunStepID=%d&runID=%d&token=%@&UserId=%d&showlog=2",URLMWWEB,_flowid,_pid,_FlowStepID,_fRunStepID,_runID,single.Token,single.userID];
    }
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)statusBarOrientationChange:(NSNotification *)notification{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
   if (orientation == UIInterfaceOrientationPortrait){
       [UIViewController attemptRotationToDeviceOrientation];
       _segmentC.frame = CGRectMake(0,64,ScreenWidth,40);
       self.tableView.frame = CGRectMake(0, 40, ScreenWidth, ScreenHeight-40);
   }
  else{
      _segmentC.frame = CGRectMake(0,32,ScreenWidth,40);
      self.tableView.frame = CGRectMake(0, 40, ScreenWidth, ScreenHeight-40);
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
   _segmentC = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"工作台",@"流程导航",@"日志跟踪",nil]];
    _segmentC.frame = CGRectMake(0,64,ScreenWidth,40);
    _segmentC.tintColor = [UIColor whiteColor];
    _segmentC.backgroundColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
    _segmentC.layer.cornerRadius = 5.0;
    _segmentC.layer.masksToBounds = YES;
    _segmentC.selectedSegmentIndex =0;
    [_segmentC addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:)name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:_segmentC];
}

-(void)viewWillDisappear:(BOOL)animated{
    [_segmentC removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    single = [Single Send];
    TaskWebTableViewCell *webCell = [tableView dequeueReusableCellWithIdentifier:@"TaskWebTableViewCell" forIndexPath:indexPath];
   [webCell.TaskWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webStr]]];
    webCell.TaskWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    webCell.TaskWebView.scalesPageToFit = YES;
    webCell.TaskWebView.multipleTouchEnabled = YES;
    webCell.TaskWebView.userInteractionEnabled = YES;
    webCell.TaskWebView.scrollView.scrollEnabled = YES;
    webCell.TaskWebView.contentMode = UIViewContentModeScaleAspectFill;
    webCell.TaskWebView.delegate = self;
    cell =webCell;
   _webcell =webCell;
    [self insertlocalData];
    return cell;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString* scheme = [[request URL] scheme];
    //判断是不是https
    if(!_judge){
    if ([scheme isEqualToString:@"https"]) {
        //如果是https:的话，那么就用NSURLConnection来重发请求。从而在请求的过程当中吧要请求的URL做信任处理。
        _currentRequest  = request;
        NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [conn start];
        [_webcell.TaskWebView stopLoading];
        return NO;
       }
    }
    return YES;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    if ([challenge previousFailureCount]== 0) {
        //NSURLCredential 这个类是表示身份验证凭据不可变对象。凭证的实际类型声明的类的构造函数来确定。
        NSURLCredential* cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:cre forAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //webview 重新加载请求。
     _judge = YES;
    [_webcell.TaskWebView loadRequest:_currentRequest];
    [connection cancel];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
     [_webcell.TaskWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
}

-(void)click:(UISegmentedControl *)segmetC{
    NSInteger index  = segmetC.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self setWebViewURL];
            [self.tableView reloadData];
            break;
        case 1:
            _webStr = [NSString stringWithFormat:@"%@/ISUI/Partial/LeftDown?flowid=%d&runID=%d&mode=%@&token=%@&UserId=%d",URLMWWEB,_flowid,self.runID,@"phone",single.Token,single.userID];
            [self.tableView reloadData];
            break;
        case 2:
            if (self.SampleType == 1) {
                 _webStr = @"";
            }else{
                _webStr = [NSString stringWithFormat:@"%@/IS/CDFormTemp?flowid=%d&pid=%d&FlowStepID=%d&fRunStepID=%d&runID=%d&token=%@&UserId=%d&showlog=1",URLMWWEB,_flowid,_pid,_FlowStepID,_fRunStepID,_runID,single.Token,single.userID];
            }
            [self.tableView reloadData];
            break;
        case 3:
            _webStr = [NSString stringWithFormat:@"%@/IS/CDFormTemp?flowid=%d&pid=%d&FlowStepID=%d&fRunStepID=%d&runID=%d&token=%@&UserId=%d&showlog=1",URLMWWEB,_flowid,_pid,_FlowStepID,_fRunStepID,_runID,single.Token,single.userID];
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

-(void)insertlocalData{
    DataBaseManager *manager = [DataBaseManager sharedDataBase:DATANAME];
    if (manager.typestatic) {
        [manager selectedData:DATANAME Params:@{@"url":[NSString stringWithFormat:@"select * from  %@  where viewType = %ld and stepID = %d and userID =%d",DATATABLE,_viewtype,self.fRunStepID,single.userID]} result:^(bool res, id data) {
            if (!res) {
                [manager insertData:DATANAME Params:@{@"url":[NSString stringWithFormat:@"insert into %@ (viewType,stepID,userID) values ('%ld',%d,%d);",DATATABLE,(long)self.viewtype,self.fRunStepID,single.userID]} result:^(bool res, id data) {
                    
                }];
            }
            
        }];
    }
    
}

@end
