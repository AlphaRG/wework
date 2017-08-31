//
//  WW_heardView.m
//  Wispeed
//  Created by RainGu on 2017/5/4.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "WW_heardView.h"
#define LabelWidth 70
#define LabelHeight 40

@implementation WW_heardView

-(instancetype)init{
    self= [super init];
    return self;
}

- (UIView *)viewWithLabelNumber:(NSInteger)num{
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num+LabelWidth*6, LabelHeight * 2);
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(15, 0, LabelWidth/2, LabelHeight)];
    btn.tag = 0;
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    for (int i = 1; i< num; i++) {
         UILabel  *lable;
        if (i<2){
             lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth, LabelHeight)];
         }else if(i == 2){
            lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth*4, LabelHeight)];
         }else if (i>2&&i<8){
             lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*3, 0, LabelWidth, LabelHeight)];
         }else if (i==8){
             lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*3, 0, LabelWidth*2, LabelHeight)];
         }else if (i==9){
             lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*4, 0, LabelWidth*2, LabelHeight)];
         }else if (i==10){
             lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*5, 0, LabelWidth, LabelHeight)];
         }else if (i==11){
             lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*5, 0, LabelWidth*2, LabelHeight)];
         }else {
            lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*6, 0, LabelWidth, LabelHeight)];
        }
        lable.tag = i;
        lable.font = [UIFont systemFontOfSize:12.0];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.numberOfLines = 0;
        [self addSubview:lable];
    }
    return self;
}

-(UIView *)viewWithLabelNumber1:(NSInteger)num{
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num+LabelWidth*5, LabelHeight * 2);
    for (int i = 0; i< num; i++) {
        UILabel  *lable;
        if (i<4){
            lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i*2+i*5+5, 0, LabelWidth*2, LabelHeight)];
        }else if(i==4){
            lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i*2+i*5+5, 0, LabelWidth, LabelHeight)];
        }else if (i==5){
            lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i*2+i*5+5-LabelWidth, 0, LabelWidth*2, LabelHeight)];
        }
        else {
            lable = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i*2+i*5-LabelWidth, 0, LabelWidth, LabelHeight)];
        }
        lable.tag = i;
        lable.font = [UIFont systemFontOfSize:12.0];
        lable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lable];
    }
    return self;
}

-(UIView *)viewWithLabelNumber2:(NSInteger)num{
    
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num+LabelWidth*7, LabelHeight * 2);
    for (int i = 0; i < num; i++) {
        UILabel *label;
        if (i==0) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i<3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth, 0, LabelWidth*2, LabelHeight)];
        }else if (i== 3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth, 0, LabelWidth*4, LabelHeight)];
        }else if (i<9&&i>3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*4, 0, LabelWidth, LabelHeight)];
        }else if (i ==9){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*4, 0, LabelWidth*2, LabelHeight)];
        }else if (i==10){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*5, 0, LabelWidth*2, LabelHeight)];
        }else if (i==11){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*6, 0, LabelWidth, LabelHeight)];
        }else if (i==12){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*6, 0, LabelWidth*2, LabelHeight)];
        }
        else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*7, 0, LabelWidth, LabelHeight)];
        }
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12.0];
        label.numberOfLines = 0;
        [self addSubview:label];
    }
    return self;
}

-(UIView *)viewWithLabelNumber3:(NSInteger)num{
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num+LabelWidth*7, LabelHeight * 2);
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(15, 0, LabelWidth, LabelHeight)];
    btn.tag = 0;
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    for (int i = 1; i < num; i++) {
        UILabel *label;
        if (i<3) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth, LabelHeight)];
        }
        else if (i==3) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5,0, LabelWidth*4, LabelHeight)];
        }else if(i<9&&i>3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*3+5, 0, LabelWidth, LabelHeight)];
        }else if (i ==9){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*3+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i ==10){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*4+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i==11){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*5+5, 0, LabelWidth, LabelHeight)];
        }else if(i ==12){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*5+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i ==13){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*6+5, 0, LabelWidth*2, LabelHeight)];
        }
        else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*7+5, 0, LabelWidth, LabelHeight)];
        }
        
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:label];
    }
    return self;
}

-(UIView *)viewWithLabelNumber4:(NSInteger)num{
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num+LabelWidth*5, LabelHeight);
    for (int i = 0; i < num; i++) {
        UILabel *label;
        if (i==0) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth, LabelHeight)];
        }
        else if (i ==1) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5,0, LabelWidth*4, LabelHeight)];
        }else if (i<5&&i>1){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*3,0, LabelWidth, LabelHeight)];
        }else if (i == 5){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*3,0, LabelWidth*2, LabelHeight)];
        }else if (i == 6){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*4,0, LabelWidth, LabelHeight)];
        }
        else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*5,0, LabelWidth, LabelHeight)];
        }
        
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12.0];        
        [self addSubview:label];
    }
    return self;
}

-(UIView *)viewWithLabelNumber5:(NSInteger)num{
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num+LabelWidth*7, LabelHeight * 2);
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(15, 0, LabelWidth, LabelHeight)];
    btn.tag = 0;
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    for (int i = 1; i < num; i++) {
        UILabel *label;
        if (i<3) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth, LabelHeight)];
        }
        else if (i==3) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5,0, LabelWidth*4, LabelHeight)];
        }else if(i<9&&i>3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*3+5, 0, LabelWidth, LabelHeight)];
        }else if (i ==9){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*3+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i ==10){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*4+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i==11){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*5+5, 0, LabelWidth, LabelHeight)];
        }else if(i ==12){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*5+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i ==13){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*6+5, 0, LabelWidth*2, LabelHeight)];
        }
        else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*7+5, 0, LabelWidth, LabelHeight)];
        }
        
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:label];
    }
    return self;
}

- (UIView *)viewWithButtonNumber:(NSInteger)num{
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num +LabelWidth*6, LabelHeight);
    for (int i = 0; i < num; i++) {
        UILabel *label;
        if (i <2) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth, LabelHeight)];
//            button = [[UIButton alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, LabelHeight +2, LabelWidth/2, LabelHeight-2)];
        }
//         else if (i <2&&i>0) {
//            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5-LabelWidth/2+5,0, LabelWidth, LabelHeight)];
//            button = [[UIButton alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5-LabelWidth/2+5, LabelHeight +2, LabelWidth, LabelHeight-2)];
//        }
     else if(i == 2){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth*4, LabelHeight)];

//            button = [[UIButton alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5-LabelWidth/2+5, LabelHeight +2, LabelWidth*2, LabelHeight-2)];
     }else if (i>2&&i<8){
         label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*3, 0, LabelWidth, LabelHeight)];
     }else if (i== 8){
         label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*3, 0, LabelWidth*2, LabelHeight)];
     }else if ( i ==9){
         label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*4, 0, LabelWidth*2, LabelHeight)];
     }else if (i == 10){
         label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*5, 0, LabelWidth, LabelHeight)];
     }else if (i== 11){
         label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*5, 0, LabelWidth*2, LabelHeight)];
     }else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*6+5, 0, LabelWidth, LabelHeight)];
//            button = [[UIButton alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth/2+5, LabelHeight +2, LabelWidth, LabelHeight-2)];
        }
        
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
        label.numberOfLines = 0;
        [self addSubview:label];
    }
    return self;
}

-(UIView *)viewWithButtonNumber1:(NSInteger)num{
  self.frame= CGRectMake(0, 0, (LabelWidth +5)* num +LabelWidth*5, LabelHeight);
  for (int i = 0; i < num; i++) {
        UILabel *label;
        if (i<4) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth *2* i+i*5+5, 0, LabelWidth*2, LabelHeight)];
         }else if (i==4){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i*2+i*5+5,9, LabelWidth, LabelHeight)];
         }else if (i==5){
             label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth *2* i+i*5+5-LabelWidth, 0, LabelWidth*2, LabelHeight)];
         }
         else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i*2+i*5-LabelWidth+5, 0, LabelWidth, LabelHeight)];
            
         }
        
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines =0 ;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
        
      [self addSubview:label];
    }
    return self;
}

-(UIView *)viewWithButtonNumber2:(NSInteger)num{
    
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num +LabelWidth*7, LabelHeight);
    for (int i = 0; i < num; i++) {
        UILabel *label;
        if (i==0) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i<3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth, 0, LabelWidth, LabelHeight)];
        }else if (i== 3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth, 0, LabelWidth*4, LabelHeight)];
        }else if (i<9&&i>3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*4, 0, LabelWidth, LabelHeight)];
        }else if (i ==9){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*4, 0, LabelWidth*2, LabelHeight)];
        }else if (i==10){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*5, 0, LabelWidth*2, LabelHeight)];
        }else if (i==11){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*6, 0, LabelWidth, LabelHeight)];
        }else if (i==12){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*6, 0, LabelWidth*2, LabelHeight)];
        }
        else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*7, 0, LabelWidth, LabelHeight)];
         }
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.0];
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
    
        [self addSubview:label];
    }
    return self;
}

-(UIView *)viewWithButtonNumber3:(NSInteger)num{
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num+LabelWidth*7, LabelHeight);
    for (int i = 0; i < num; i++) {
        UILabel *label;
        if (i<3) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth, LabelHeight)];
        }
        else if (i==3) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5,0, LabelWidth*4, LabelHeight)];
        }else if(i<9&&i>3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*3+5, 0, LabelWidth, LabelHeight)];
        }else if (i ==9){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*3+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i ==10){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*4+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i==11){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*5+5, 0, LabelWidth, LabelHeight)];
        }else if(i ==12){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*5+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i ==13){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*6+5, 0, LabelWidth*2, LabelHeight)];
        }
        else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*7+5, 0, LabelWidth, LabelHeight)];
        }
        
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
        [self addSubview:label];
    }
    return self;
}

-(UIView *)viewWithButtonNumber4:(NSInteger)num{
    
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num+LabelWidth*5, LabelHeight);
    for (int i = 0; i < num; i++) {
        UILabel *label;
        if (i==0) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth, LabelHeight)];
        }
        else if (i ==1) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5,0, LabelWidth*4, LabelHeight)];
        }else if (i<5&&i>1){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*3,0, LabelWidth, LabelHeight)];
        }else if (i == 5){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*3,0, LabelWidth*2, LabelHeight)];
        }else if (i == 6){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*4,0, LabelWidth, LabelHeight)];
        }
        else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5+LabelWidth*5,0, LabelWidth, LabelHeight)];
        }
        
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
        
        [self addSubview:label];
    }
    return self;
}

-(UIView *)viewWithButtonNumber5:(NSInteger)num{
    self.frame= CGRectMake(0, 0, (LabelWidth +5)* num+LabelWidth*7, LabelHeight);
    for (int i = 0; i < num; i++) {
        UILabel *label;
        if (i<3) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5, 0, LabelWidth, LabelHeight)];
        }
        else if (i==3) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+5,0, LabelWidth*4, LabelHeight)];
        }else if(i<9&&i>3){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*3+5, 0, LabelWidth, LabelHeight)];
        }else if (i ==9){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*3+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i ==10){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*4+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i==11){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*5+5, 0, LabelWidth, LabelHeight)];
        }else if(i ==12){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*5+5, 0, LabelWidth*2, LabelHeight)];
        }else if (i ==13){
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*6+5, 0, LabelWidth*2, LabelHeight)];
        }
        else {
            label = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth * i+i*5+LabelWidth*7+5, 0, LabelWidth, LabelHeight)];
        }
        
        label.tag = i;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithRed:111/255.0 green:187/255.0 blue:120/255.0 alpha:1.0];
        [self addSubview:label];
    }
    return self;
}

-(void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(sendBtnInfo:)]) {
        [self.delegate sendBtnInfo:btn];
    }
}

@end
