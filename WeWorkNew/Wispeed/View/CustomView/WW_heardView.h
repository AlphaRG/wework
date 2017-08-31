//
//  WW_heardView.h
//  Wispeed
//
//  Created by RainGu on 2017/5/4.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendBtnInfoDelegate <NSObject>
@optional
-(void)sendBtnInfo:(id)tag;
@end

@interface WW_heardView : UIView
@property(nonatomic,weak) id <sendBtnInfoDelegate> delegate;
@property(nonatomic,strong)UIView *selfVeiw;
-(instancetype)init;
- (UIView *)viewWithLabelNumber:(NSInteger)num;
- (UIView *)viewWithLabelNumber1:(NSInteger)num;
- (UIView *)viewWithLabelNumber2:(NSInteger)num;
- (UIView *)viewWithLabelNumber3:(NSInteger)num;
- (UIView *)viewWithLabelNumber4:(NSInteger)num;
- (UIView *)viewWithLabelNumber5:(NSInteger)num;

-(UIView *)viewWithButtonNumber:(NSInteger)num;
-(UIView *)viewWithButtonNumber1:(NSInteger)num;
-(UIView *)viewWithButtonNumber2:(NSInteger)num;
-(UIView *)viewWithButtonNumber3:(NSInteger)num;
-(UIView *)viewWithButtonNumber4:(NSInteger)num;
-(UIView *)viewWithButtonNumber5:(NSInteger)num;

@end
