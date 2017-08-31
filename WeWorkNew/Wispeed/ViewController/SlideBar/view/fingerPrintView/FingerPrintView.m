//  FingerPrintView.m
//  Wispeed
//  Created by RainGu on 2017/5/10.
//  Copyright © 2017年 Wispeed. All rights reserved.
#import "FingerPrintView.h"
#import "Masonry.h"
#import "PCCircleViewConst.h"
@implementation FingerPrintView
-(instancetype)initWithType:(fingerPrintType)type frame:(CGRect)frame backgroundColor:(UIColor *)color{
    if (self = [super init]) {
        self.type = type;
        self.backgroundColor = color;
        [self setFrame:frame];
        [self setFingerPrintView];
    }
    return self;
}

-(void)setFingerPrintView{
    switch (self.type) {
        case 0:
            [self setView];
         break;
        case 1:
            [self loginView];
        break;
        default:
            [self setView];
            break;
    }
}

-(void)setView{
    [self addSubview:self.switchBtn];
    [self addSubview:self.titlename];
    _titlename.text = @"指纹解锁";
    [self setViewConstraints];
}

-(void)loginView{
    [self addSubview:self.fingerImage];
    [self addSubview:self.titlename];
    _titlename.textColor = [UIColor colorWithRed:57/255.0 green:183/255.0 blue:247/255.0 alpha:1.0];
    [self loginViewConstraints];
}

-(void)setViewConstraints{
    [self.titlename mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.mas_top).offset(74);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 21));
    }];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(74);
        make.size.mas_equalTo(CGSizeMake(42, 21));
    }];
}

-(void)loginViewConstraints{
    [self.fingerImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.mas_top).offset(ScreenHeight/2-100);
        make.left.mas_equalTo(self.mas_left).offset(ScreenWidth/2-50);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [self.titlename mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.fingerImage.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(ScreenWidth/2-100);
        make.size.mas_equalTo(CGSizeMake(200, 21));
    }];
}

-(UIButton *)fingerImage{
    if (_fingerImage == nil) {
        _fingerImage = [UIButton buttonWithType:UIButtonTypeCustom];
        _fingerImage.layer.masksToBounds = YES;
        _fingerImage.layer.cornerRadius = _fingerImage.bounds.size.width/2;
        [_fingerImage setImage:[UIImage imageNamed:@"fingerprint.png"] forState:UIControlStateNormal];
        [_fingerImage addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fingerImage;
}

-(UILabel *)titlename{
    if (_titlename == nil) {
        _titlename = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 21)];
        _titlename.font =[UIFont systemFontOfSize:14.0];
        _titlename.textAlignment = NSTextAlignmentCenter;
        _titlename.text = @"点击指纹进行解锁";
    }
    return _titlename;
}

-(UISwitch *)switchBtn{
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc]init];
        NSInteger tag;
        if (self.type == 0) {
            tag = [[PCCircleViewConst getGestureWithKey:@"SwitchOn"] integerValue];
        }else if (self.type == 2) {
            tag = [[PCCircleViewConst getGestureWithKey:@"gesSwitchOn"] integerValue];
        }else{
            tag = 3;
        }
        switch (tag) {
            case 0:
                [_switchBtn setOn:NO animated:YES];
                break;
             case 1:
                [_switchBtn setOn:YES animated:YES];
                break;
            default:
                [_switchBtn setOn:NO animated:YES];
                break;
        }
        _switchBtn.transform =CGAffineTransformMakeScale(0.7, 0.7);
        [_switchBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchBtn;
}

-(void)change:(UISwitch *)sender{
    [self.delegate sendinfo:[sender isOn]];
}

-(void)BtnClick{
    [self.delegate fingerPrintBtnClick];
}
@end
