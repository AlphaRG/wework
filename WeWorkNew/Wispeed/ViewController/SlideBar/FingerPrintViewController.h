//
//  FingerPrintViewController.h
//  Wispeed
//
//  Created by RainGu on 2017/5/10.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FingerPrintView.h"
#import "PCCircleView.h"
#import "PCLockLabel.h"
@interface FingerPrintViewController : UIViewController
@property(nonatomic,strong)FingerPrintView *fingerPrintView;
@property(nonatomic,strong)PCCircleView    *lockView;
@property(nonatomic,strong)PCLockLabel     *lockLable;
@property(nonatomic,assign)fingerPrintType type;
@end
