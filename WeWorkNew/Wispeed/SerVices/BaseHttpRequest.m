//
//  BaseHttpRequest.m
//  MercyMap
//  Created by sunshaoxun on 16/4/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
#import "BaseHttpRequest.h"
#import "JSONKit.h"
@implementation BaseHttpRequest

+(void)sendRequestHttp:(NSString *)url parameters:(NSDictionary *)dic Success:(RequestSuccessBlock)successBlock Failuer:(RequestFaileBlock)errorBlock
{
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer=[AFHTTPResponseSerializer serializer];
  // [manager setSecurityPolicy:[self customSecurityPolicy]];
    //https 不通过证书验证
    manager.securityPolicy.allowInvalidCertificates =YES;
    
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = (NSData *)responseObject;
        NSString *jsonStr =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSString *str = [jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
        NSDictionary *dic1 = (NSDictionary *)[str objectFromJSONString];
        successBlock(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error.description);
    }];
}

+(void)sendRequestHttpGet:(NSString *)url parameters:(NSDictionary *)dic Success:(RequestSuccessBlock)successBlock Failuer:(RequestFaileBlock)errorBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //https 不通过证书验证
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = (NSData *)responseObject;
        NSString *jsonStr =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSString *str = [jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
        NSDictionary *dic1 = (NSDictionary *)[str objectFromJSONString];
        successBlock(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      errorBlock(error.description);
    }];
}



+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *certSet = [NSSet setWithObject:certData];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}

@end
