//
//  mySelfInfoTableViewCell.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/26.
//  Copyright © 2016年 Wispeed. All rights reserved.

#import "mySelfInfoTableViewCell.h"

@implementation mySelfInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 25;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO  animated:NO];
}

- (IBAction)BtnClick:(id)sender {
    UIButton *btn  = (UIButton *)sender;
    
    [self.delegate exit:btn.tag];
}

-(void)SetcellName:(NSString *)cellName textName:(NSString *)textName  indexpath:(int)code
{
    self.LableName.text = cellName ;
    if (code == 0) {
        _headImageView.image = [UIImage imageNamed:@"Kobe.jpg"];
    }
    else{
        if ([textName isKindOfClass:[NSNull class]]) {
            [_BtnName setTitle:@"" forState:UIControlStateNormal];
        }else{
            [_BtnName setTitle:textName forState:UIControlStateNormal];
        }
    }
}

-(void)setViewInfo:(id)data{
    NSUInteger tag = [data[@"tag"] intValue];
    switch (tag) {
        case  0:
            self.LableName.text = data[@"name"];
            self.headImageView.hidden = NO;
            self.LableName.hidden = NO;
            self.BtnName.hidden   = YES;
            self.BtnExit.hidden   = YES;
            if ([data[@"info"]isEqualToString:@""]) {
                UIImage *Cimage = [self imageAddText:[UIImage imageNamed:@"Kobe.png"] text:data[@"companyname"]];
                _headImageView.image = Cimage;
            }else{
                if ([data[@"info"] rangeOfString:@"http"].length>0) {
                    [_headImageView sd_setImageWithURL:[NSURL URLWithString:data[@"info"]]];
                }else{
                    _headImageView.image = [UIImage imageNamed:data[@"info"]];
                }
                
            }
            break;
        case 1:
            self.LableName.text = data[@"name"];
            self.headImageView.hidden = YES;
            self.LableName.hidden = NO;
            self.BtnName.hidden   = NO;
            self.BtnExit.hidden   = YES;
            if ([data[@"info"] isKindOfClass:[NSNull class]]) {
                [self.BtnName setTitle:@"" forState:UIControlStateNormal];
            }else{
                [self.BtnName setTitle:data[@"info"] forState:UIControlStateNormal];
            }
            break;
         case 2:
            self.headImageView.hidden = YES;
            self.LableName.hidden = YES;
            self.BtnName.hidden   = YES;
            self.BtnExit.hidden   = NO;
            self.BtnExit.tag      = tag;
            break;
            
        default:
            break;
    }
}

- (UIImage *)imageAddText:(UIImage *)img text:(NSString *)logoText{
    NSString *str0 = [logoText substringWithRange:NSMakeRange(0, 4)];
    NSString *str1 = [str0 substringToIndex:2];
    NSString *str2 = [str0 substringFromIndex:2];
    
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    NSDictionary *attr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:10], NSForegroundColorAttributeName : [UIColor blackColor]  };
    //位置显示
    [str1 drawInRect:CGRectMake(5,5, w*0.8, h*0.3) withAttributes:attr];
    [str2 drawInRect:CGRectMake(5,15,w*0.8, h*0.3) withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
}

@end
