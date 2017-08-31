//
//  HttpRequestSerVice.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "HttpRequestSerVice.h"
#import "UserLogViewController.h"
#import "Single.h"
@implementation HttpRequestSerVice

+(NSDictionary *)userNamejudge:(NSString *)userName{
    NSString *url ;
    NSDictionary *dic;
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:userName]) {
        url  = [NSString stringWithFormat:@"%@api/Account/MemberMobileLogin",USERURL];
        dic=@{@"MobileNum":userName,@"url":url};
    }else{
        url     =  [NSString stringWithFormat:@"%@api/Account/MemberUserLogin",USERURL];
        dic=@{@"UserName":userName,@"url":url};
    }
    return dic;
}


+(NSDictionary *)getmacdic{
    NSMutableDictionary *macDic = [[NSMutableDictionary alloc]init];
    NSDictionary *Macdic = @{@"IMEI":@"NO Message ",@"MacAddress":@"NO Message",@"GPSLocation":@"No Message"};
    [macDic addEntriesFromDictionary:Macdic];
    return macDic;
}

+(NSString *)getappversion{
    NSDictionary *dicInfo = [[NSBundle mainBundle]infoDictionary];
    NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    return  strAppVersion;
}

+(NSString *)getClientDevice{
    NSString *strSysName =[[UIDevice currentDevice]systemName];
    return  strSysName;
}



+(void)LoginUserName:(NSString *)UserName andPassWord:(NSString *)PassWord IVerifyCode:(NSDictionary *)IVerifyCode SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock{
    NSString *url;
    NSDictionary *userdic;
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:UserName]) {
        url  = [NSString stringWithFormat:@"%@api/Account/MemberMobileLogin",USERURL];
        userdic=@{@"MobileNum":UserName};
    }else{
        url     =  [NSString stringWithFormat:@"%@api/Account/MemberUserLogin",USERURL];
        userdic=@{@"UserName":UserName};
    }

    NSDictionary *dic             =  @{
                                       @"PassWord":PassWord,
                                       @"IVerifyCode":IVerifyCode,
                                       @"ClientDevice":[self getClientDevice],
                                       @"SoftVesion":[self getappversion],
                                       @"ClientInformation":@"No Message",
                                       @"ClientInfor":@"NO Message",
                                       @"FormPlatform":@20,
                                       @"ClientType":@10
                                       };
    NSMutableDictionary *lastdic = [[NSMutableDictionary alloc]init];
    [lastdic addEntriesFromDictionary:dic];
    [lastdic addEntriesFromDictionary:userdic];
    [self sendRequestHttp:url parameters:lastdic Success:^(NSDictionary *dicData) {
        NSMutableDictionary  *dic1 =  [[NSMutableDictionary alloc]init];
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
            [dic1 addEntriesFromDictionary:dicData[@"Members"]];
            [dic1 setObject:dicData[@"Token"] forKey:@"Token"];
            [dic1 setObject:@"S" forKey:@"Flag"];
        }
        else{
            [dic1 setValue:@"F" forKey:@"Flag"];
            [dic1 setObject:dicData[@"OMsg"][@"Msg"]forKey:@"Msg"];
            }
        SuccessBlock(dic1);
    } Failuer:^(NSString *errorInfo) {
       FailuerBlock(errorInfo);
    }];    
}

+(void)TaskListloginUser:(NSString *)loginUser stepType:(NSInteger)stepType page:(NSInteger)page rows:(NSInteger)rows andToken:(NSString *)Token companyID:(int)companyID title:(NSString *)title SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock{
    Single *single = [Single Send];
    id companyid,where;
    NSString *url       =[NSString stringWithFormat:@"%@TaskList",URLM];
    NSNumber *steptype  =[NSNumber numberWithInteger:stepType];
    NSNumber *Page      =[NSNumber numberWithInteger:page];
    NSNumber *Rows      =[NSNumber numberWithInteger:rows];
    where = @"<null>";
    if (companyID == 0) {
         companyid = @"<null>";
    }else{
        companyid =[NSNumber numberWithInt:companyID];
    }
    NSNumber *uid       =[NSNumber numberWithInt:single.userID];
    NSDictionary *dic  =@{@"loginUser":loginUser,@"stepType":steptype,@"page":Page,@"rows":Rows,@"Token":Token,@"companyID":companyid,@"UID":uid,@"where":where};
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        NSMutableDictionary  *dic1 =  [[NSMutableDictionary alloc]init];
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]){
            if ([title isEqualToString:@"FlowList"]) {
                [dic1 setObject:dicData[@"FlowList"] forKey:@"FlowRunStepList"];
            }else{
                [dic1 setObject:dicData[@"FlowRunStepList"] forKey:@"FlowRunStepList"];
            }
            [dic1 setObject:@"S" forKey:@"Flag"];
            SuccessBlock(dic1);
        }
        else{
            [dic1 setObject:@"F" forKey:@"Flag"];
            [dic1 setObject:dicData[@"OMsg"][@"Msg"] forKey:@"FlowRunStepList"];
            SuccessBlock(dic1);
            }
    } Failuer:^(NSString *errorInfo) {
        FailuerBlock(errorInfo);
        }];
}

+(void)getUserInfoid:(int)ID Token:(NSString *)Token  SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock{
    NSString *url = [NSString stringWithFormat:@"%@GetDepartmentInfo?userID=%d&token=%@",URLM,ID,Token];
    NSNumber *userID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =@{@"userID":userID,@"Token":Token};
    [self sendRequestHttpGet:url parameters:dic Success:^(NSDictionary *dicData) {
        SuccessBlock (dicData);
    } Failuer:^(NSString *errorInfo) {
        FailuerBlock(errorInfo);
    }];
}

+(void)getUserCompanyid:(int)ID andToken:(NSString *)Token SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock{
    NSString *url = [NSString stringWithFormat:@"%@GetCompanyList?userID=%d&token=%@",URLM,ID,Token];
    NSNumber *userID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =@{@"userID":userID,@"Token":Token};
    NSMutableDictionary  *dic1 =  [[NSMutableDictionary alloc]init];
    [self sendRequestHttpGet:url parameters:dic Success:^(NSDictionary *dicData) {
       if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
           [dic1 setObject:@"S" forKey:@"Flag"];
           [dic1 setObject:dicData[@"ListISUserComDepMapping"] forKey:@"CompanyArray"];
       }
    else{
          [dic1 setObject:@"F" forKey:@"Flag"];
          [dic1 setObject:dicData[@"OMsg"][@"Msg"] forKey:@"Msg"];
        }
        SuccessBlock(dic1);
     } Failuer:^(NSString *errorInfo) {
         FailuerBlock(errorInfo);
    }];
}

+(void)getAppURL:(NSString *)urltype SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock{
    NSString *url = [NSString stringWithFormat:@"http://www.wispeed.com/geturlapis.ashx?urltype="];
    [self sendRequestHttpGet:url parameters:nil Success:^(NSDictionary *dicData) {
     NSMutableDictionary  *dic1 =  [[NSMutableDictionary alloc]init];
     if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]){
            [dic1 setObject:@"S" forKey:@"Flag"];
            [dic1 setObject:dicData[@"ListAppIUrls"] forKey:@"ListAppIUrls"];
            SuccessBlock(dic1);
        }
     else{
          [dic1 setObject:@"F" forKey:@"Flag"];
          SuccessBlock(dic1);
         }
    }
    Failuer:^(NSString *errorInfo){
        FailuerBlock(errorInfo);
    }];
}

+(void)getDicUrl:(NSString *)url Dic:(NSDictionary *)dic Title:(NSString *)title SuccessBlock:(HttpSuccessBlock)successblock FailuerBlock:(HttpFailuerBlock)failuerblock{
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        if (title !=nil) {
            successblock([dicData objectForKey:title]);
        }else{
            successblock(dicData);
        }
    } Failuer:^(NSString *errorInfo) {
        failuerblock(errorInfo);
    }];
}
@end
