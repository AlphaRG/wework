//
//  MyselfnextTableViewCell.m
//  Wispeed
//
//  Created by sunshaoxun on 16/10/20.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "MyselfnextTableViewCell.h"
#import "Masonry.h"
@implementation MyselfnextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleName];
        [self.contentView addSubview:self.titleImg];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO  animated:NO];
}

-(void)configData:(id)data{
    self.titleImg.image = [UIImage imageNamed:data[@"imageName"]];
    self.titleName.text = data[@"name"];
}

-(void)updateConstraints{
    [super updateConstraints];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.top.mas_equalTo(self.contentView).offset(7);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleImg.mas_right).offset(50);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.contentView).offset(7);
        make.width.mas_equalTo(80);
    }];
}

-(UIImageView *)titleImg{
    if (_titleImg == nil) {
        _titleImg = [[UIImageView alloc]init];
    }
    return  _titleImg;
}

-(UILabel *)titleName{
    if (_titleName==nil) {
        _titleName = [[UILabel alloc]init];
        _titleName.font = [UIFont systemFontOfSize:14];
        _titleName.textColor = [UIColor lightGrayColor];
    }
    return _titleName;
}
@end
