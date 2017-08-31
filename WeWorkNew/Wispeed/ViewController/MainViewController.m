//
//  MainViewController.m
//  Wispeed
//  Created by sunshaoxun on 16/7/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
#import "MainViewController.h"
#import "MyTaskSkimTableViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate {
//    UINavigationController *nav = self.selectedViewController;
//    UIViewController *vc = nav.topViewController;
//    if ([vc isKindOfClass:[MyTaskSkimTableViewController class]] &&
//        [vc respondsToSelector:@selector(shouldAutorotate)]) {
//        return [vc shouldAutorotate];
//    }
//    return NO;
    return YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UINavigationController *nav = self.selectedViewController;
    UIViewController *vc = nav.topViewController;
//    if ([vc isKindOfClass:[MyTaskSkimTableViewController class]] &&
//        [vc respondsToSelector:@selector(supportedInterfaceOrientations)]) {
//        return [vc supportedInterfaceOrientations];
//    }
//    return UIInterfaceOrientationMaskPortrait;
    return [vc supportedInterfaceOrientations];

}

@end
