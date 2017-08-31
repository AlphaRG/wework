//
//  UIView+RGExtension.h
//  Wispeed
//
//  Created by RainGu on 17/1/10.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#define RGColorSet(r,g,b,a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]


@interface UIView(RGExtension)

@property(nonatomic,assign)CGFloat rg_height;
@property(nonatomic,assign)CGFloat rg_width;
@property(nonatomic,assign)CGFloat rg_x;
@property(nonatomic,assign)CGFloat rg_y;
+ (UIView *)viewWithLabelNumber:(NSInteger)num;
@end
