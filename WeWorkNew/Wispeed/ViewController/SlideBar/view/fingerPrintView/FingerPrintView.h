//
//  FingerPrintView.h
//  Wispeed
//
//  Created by RainGu on 2017/5/10.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    fingerPrintTypeSet = 0,
    fingerPrintTypeLogin,
    GestureViewControllerTypeSet
}fingerPrintType ;

@protocol fingerPrintDelegate <NSObject>
@optional
-(void)sendinfo:(BOOL)trueOrfalse;
-(void)fingerPrintBtnClick;
@end

@interface FingerPrintView : UIView
@property(nonatomic,assign)fingerPrintType type;
@property(nonatomic,strong)UIColor *fingerbackgroundColor;
@property(nonatomic,strong)UIButton *fingerImage;
@property(nonatomic,strong)UILabel  *titlename;
@property(nonatomic,strong)UISwitch *switchBtn;
@property(nonatomic,weak)id<fingerPrintDelegate>delegate;

-(instancetype)initWithType:(fingerPrintType)type frame:(CGRect)frame backgroundColor:(UIColor *)color;
@end
