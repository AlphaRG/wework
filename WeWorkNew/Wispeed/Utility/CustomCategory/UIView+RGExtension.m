//
//  UIView+RGExtension.m
//  Wispeed
//
//  Created by RainGu on 17/1/10.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "UIView+RGExtension.h"

#define LabelWidth 80
#define LabelHeight 40
@implementation UIView(RGExtension)

-(CGFloat)rg_height{
    return self.frame.size.height;
}

-(void)setRg_height:(CGFloat)rg_height{
    CGRect temp = self.frame;
    temp.size.height = rg_height;
    self.frame = temp;
}

-(CGFloat)rg_width{
    return self.frame.size.width;
}

-(void)setRg_width:(CGFloat)rg_width{
    CGRect temp = self.frame;
    temp.size.height = rg_width;
    self.frame = temp;
}

-(CGFloat)rg_x{
    return self.frame.origin.x;
}

-(void)setRg_x:(CGFloat)rg_x{
    CGRect temp = self.frame;
    temp.origin.x = rg_x;
    self.frame = temp;
}

-(CGFloat)rg_y{
    return self.frame.origin.y;
}

-(void)setRg_y:(CGFloat)rg_y{
    CGRect temp = self.frame;
    temp.origin.y = rg_y;
    self.frame = temp;
}

+ (UIView *)viewWithLabelNumber:(NSInteger)num{
    UIView *view = [[self alloc] initWithFrame:CGRectMake(0, 0, (LabelWidth +5) * num, LabelHeight*2)];
    for (int i = 0; i < num; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(LabelWidth * i+i*5, 0, LabelWidth, LabelHeight)];
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
    }
    return view;
}
@end
