//
//  DataBaseManager.h
//  Wispeed
//
//  Created by RainGu on 2017/6/26.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^resultBlock)(_Bool res,id __weak data);

@interface DataBaseManager : NSObject

@property (nonatomic, strong) FMDatabase *fmDataBase;

@property (nonatomic,strong) FMDatabaseQueue *fmDatabaseQueue;

@property(nonatomic,assign)BOOL typestatic;

+ (DataBaseManager *)sharedDataBase:(NSString *)fileName;

-(void)insertData:(NSString *)dataName Params:(NSDictionary *)params result:(resultBlock)Datablock;

-(void)deleteData:(NSString *)dataName Params:(NSDictionary *)params result:(resultBlock)Datablock;

-(void)removeData:(NSString *)dataName Params:(NSDictionary *)params result:(resultBlock)Datablock;

-(void)fixData:(NSString *)dataName  Params:(NSDictionary *)params   result:(resultBlock)Datablock;

-(void)selectedData:(NSString *)dataName Params:(NSDictionary *)params result:(resultBlock)Datablock;

@end
