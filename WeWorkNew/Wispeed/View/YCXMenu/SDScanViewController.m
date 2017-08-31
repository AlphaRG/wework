//
//  MyTaskTableViewController.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/11.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "SDScanViewController.h"
#import "UIView+RGExtension.h"
#import <AVFoundation/AVFoundation.h>

static const CGFloat kBorderW = 64;
static const CGFloat kMargin  = 15;
@interface SDScanViewController () <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, weak) UIView *maskView;

@end

@implementation SDScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码扫描";
//  [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)]];
    self.view.clipsToBounds = YES;
    
    [self setupMaskView];
    
    [self setupBottomBar];
    
    [self setupScanWindowView];
    [self beginScanning];
}

- (void)setupMaskView{
    UIView *mask = [[UIView alloc] init];
    _maskView = mask;

    mask.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    mask.layer.borderWidth = kBorderW;
    mask.bounds = CGRectMake(0,0, self.view.rg_width, self.view.rg_width);
    mask.center = self.view.center;
    [self.view addSubview:mask];
}

- (void)setupBottomBar{
    CGFloat height = (self.view.rg_height-self.view.rg_width)/2;
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.rg_height * 0.9, self.view.rg_width, self.view.rg_height * 0.1)];
    bottomBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,kBorderW,self.view.rg_width,height-kBorderW)];
    topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.rg_height-height,self.view.rg_width,height-bottomBar.bounds.size.height)];
    bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    UILabel * bottomLable  = [[UILabel alloc]initWithFrame:CGRectMake(0,self.view.rg_height-height-kBorderW+10,self.view.rg_width, 21)];
    bottomLable.backgroundColor = [UIColor clearColor];
    bottomLable.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    bottomLable.font = [UIFont systemFontOfSize:12.0];
    bottomLable.text      = @"将二维码/或条码放入框内，即可自动扫描";
    bottomLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomBar];
    [self.view addSubview:topView];
    [self.view addSubview:bottomView];
    [self.view addSubview:bottomLable];

}

- (void)setupScanWindowView
{
//  CGFloat scanWindowH = self.view.rg_height * 0.9 - kBorderW * 2;
//  CGFloat scanWindowW = self.view.rg_width - kMargin * 2;
    CGFloat height = (self.view.rg_height-self.view.rg_width)/2;
    CGFloat scanWindowH = self.view.rg_width-kBorderW*2;
    CGFloat scanWindowW = self.view.rg_width-kBorderW*2;
    UIView *scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kBorderW,height+kBorderW,self.view.rg_width-kBorderW*2,self.view.rg_width-kBorderW*2)];
    scanWindow.clipsToBounds = YES;
    [self.view addSubview:scanWindow];
    
    CGFloat scanNetImageViewH = 241;
    CGFloat scanNetImageViewW = scanWindow.rg_width;
    UIImageView *scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
    CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
    scanNetAnimation.keyPath = @"transform.translation.y";
    scanNetAnimation.byValue = @(scanWindowH);
    scanNetAnimation.duration = 2.0;
    scanNetAnimation.repeatCount = MAXFLOAT;
    [scanNetImageView.layer addAnimation:scanNetAnimation forKey:nil];
    [scanWindow addSubview:scanNetImageView];
    
    CGFloat buttonWH = 18;

    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [scanWindow addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowW - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowH - buttonWH, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(topRight.rg_x, bottomLeft.rg_y, buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [scanWindow addSubview:bottomRight];
}

- (void)beginScanning{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) return;
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    output.rectOfInterest = CGRectMake(0.1, 0, 0.9, 1);
//    output.rectOfInterest = CGRectMake(0.35, 0.3, 0.65, 0.7);
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    [_session addInput:input];
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
}

-(void)viewWillAppear:(BOOL)animated{
    [_session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        NSURL *url = [NSURL URLWithString:metadataObject.stringValue];
        if([[UIApplication sharedApplication]canOpenURL:url]){
            [[UIApplication sharedApplication] openURL: url];
        }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:metadataObject.stringValue delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"再次扫描", nil];
            [alert show];
        }
    }
    [self disMiss];
}

- (void)disMiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)willMoveToParentViewController:(UIViewController *)parent{
    if (!parent) {
        self.navigationController.navigationBar.hidden = NO;
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self disMiss];
    } else if (buttonIndex == 1) {
        [_session startRunning];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
