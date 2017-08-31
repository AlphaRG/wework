//
//  Single.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/18.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "Single.h"

@implementation Single

static Single *s =nil;
+(Single *)Send
{
    if (s ==nil) {
        s = [[Single alloc]init];
    }
    return s;
}
-(NSString *)tel{
    if (_tel == nil) {
         _tel = @"";
    }
    return _tel;
}

-(NSString *)UserName{
    if (_UserName == nil) {
         _UserName = @"";
    }
    return _UserName;
}

-(NSString *)email{
    if (_email == nil) {
         _email = @"";
    }
    return _email;
}

-(NSString *)area{
    if (_area ==nil ) {
         _area = @"";
    }
    return _area;
}

-(NSString *)NickName {
    if (_NickName == nil) {
         _NickName =@"";
    }
    return _NickName;
}

-(NSString *)headImg{
    if (_headImg == nil) {
        _headImg =@"Kobe.jpg";
    }
    return _headImg;
}

-(NSString *)sex{
    if (_sex == nil) {
        _sex = @"";
    }
    return _sex;
}
-(id)imageNavType{
    if (_imageNavType==nil) {
        _imageNavType = [UIImage imageNamed:@"black.png"];
    }
    return _imageNavType;
}
@end
