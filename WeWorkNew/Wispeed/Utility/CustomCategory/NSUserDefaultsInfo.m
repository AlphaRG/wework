//
//  NSUserDefaultsInfo.m
//  Wispeed
//
//  Created by RainGu on 2017/5/10.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "NSUserDefaultsInfo.h"
#import "Single.h"
@implementation NSUserDefaultsInfo
+(void)getInfo{
    Single  *single = [Single Send];
    single.userID    = [[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"] intValue];
    single.Token     = [[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    single.UserName  = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    single.companyArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"CompanyArr"];
    single.sex    =    [[NSUserDefaults standardUserDefaults]objectForKey:@"sex"];
    single.email     = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    single.tel  = [[NSUserDefaults standardUserDefaults]objectForKey:@"tel"];
    single.area = [[NSUserDefaults standardUserDefaults]objectForKey:@"area"];
    single.NickName = [[NSUserDefaults standardUserDefaults]objectForKey:@"NickName"];
}
@end
