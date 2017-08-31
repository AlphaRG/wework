//
//  Single.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/18.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Single : NSObject
@property(nonatomic,assign)int userID;
@property(nonatomic,strong)NSString*  UserName;
@property(nonatomic,strong)NSString*  Password;
@property(nonatomic,strong)NSString *Token;
@property(nonatomic,assign)int CompanyID;
@property(nonatomic,strong)NSString *NickName;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *tel;
@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSArray  *companyArr;
@property(nonatomic,strong)id imageNavType;
+(Single *)Send;
@end
