//
//  HttpRequestSerVice.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "BaseHttpRequest.h"
typedef void (^HttpSuccessBlock)(NSDictionary *dic);
typedef void (^HttpFailuerBlock)(NSString *str) ;
typedef void  (^HttpSuccessBlockA)(NSArray *dataArray);
@interface HttpRequestSerVice : BaseHttpRequest

+(void)LoginUserName:(NSString *)UserName andPassWord:(NSString *)PassWord IVerifyCode:(NSDictionary *)IVerifyCode SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock;

+(void)TaskListloginUser:(NSString *)loginUser stepType:(NSInteger)stepType page:(NSInteger)page rows:(NSInteger)rows
                andToken:(NSString*)Token companyID:(int)companyID title:(NSString *)title SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock;

+(void)getUserInfoid:(int)ID  Token:(NSString *)Token  SuccessBlock:(HttpSuccessBlock)SuccessBlock
        FailuerBlock:(HttpFailuerBlock)FailuerBlock;

+(void)getUserCompanyid:(int)ID andToken:(NSString *)Token SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock;

+(void)getAppURL:(NSString *)urltype SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock;

+(void)getDicUrl:(NSString *)url Dic:(NSDictionary *)dic Title:(NSString *)title SuccessBlock:(HttpSuccessBlock)successblock  FailuerBlock:(HttpFailuerBlock)failuerblock;

+(NSDictionary *)getmacdic;
@end
