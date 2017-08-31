//
//  loginAndSafeViewCell.m
//  Wispeed
//
//  Created by RainGu on 2017/5/9.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "loginAndSafeViewCell.h"
#import "Masonry.h"
#import "PCCircleViewConst.h"
@implementation loginAndSafeViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titlename];
        [self.contentView addSubview:self.authority];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(void)configData:(id)data{
    NSInteger fag = [data[@"tag"] integerValue];
    switch (fag) {
        case 0:
            if ([[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length]) {
                self.authority.text = @"使用中";
            }else{
                self.authority.text = @"未使用";
            }
            break;
        case 1:
            if ([[PCCircleViewConst getGestureWithKey:loginKeyWay] isEqualToString:@"2"]) {
                 self.authority.text = @"使用中";
            }else{
                self.authority.text = @"未使用";
            }
            break;
        default:
            break;
    }
    self.titlename.text = data[@"name"];
}

-(void)updateConstraints{
    [super updateConstraints];
    [self.titlename mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.top.mas_equalTo(self.contentView).offset(7);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    [self.authority mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.contentView).offset(7);
        make.width.mas_equalTo(100);
    }];
}

-(UILabel *)titlename{
    if (_titlename == nil) {
        _titlename = [[UILabel alloc]init];
        _titlename.font =  [UIFont systemFontOfSize:14.0];
    }
    return _titlename;
}

-(UILabel *)authority{
    if (_authority == nil) {
        _authority = [[UILabel alloc]init];
        _authority.font =[UIFont systemFontOfSize:14.0];
        _authority.textColor = [UIColor lightGrayColor];
        _authority.textAlignment = NSTextAlignmentRight;
        _authority.text =@"未使用";
    }
    return _authority;
}

@end
