//
//  DataBaseManager.m
//  Wispeed
//
//  Created by RainGu on 2017/6/26.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

-(NSString *)newData:(NSString *)dataName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:dataName];
    
    return dbPath;
}

+ (DataBaseManager *)sharedDataBase:(NSString *)fileName
{
    static DataBaseManager *fmdbDataBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmdbDataBase = [[DataBaseManager alloc] init:fileName];
    });
    return fmdbDataBase;
}

-(instancetype)init:(NSString *)fileName{
    if (self = [super init]) {
        NSFileManager *filemanager =[NSFileManager defaultManager];
        if ([filemanager fileExistsAtPath:[self newData:fileName]]) {
            self.fmDataBase = [FMDatabase databaseWithPath:[self newData:fileName]];
            self.fmDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self newData:fileName]];
            self.typestatic = YES;
        }else{
            self.fmDataBase = [FMDatabase databaseWithPath:[self newData:fileName]];
            self.fmDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self newData:fileName]];
            self.typestatic  = NO;
        }
   }
    return self;
}

-(void)insertData:(NSString *)dataName Params:(NSDictionary *)params result:(resultBlock)Datablock{

    if ([_fmDataBase open]){
        BOOL res = [_fmDataBase executeUpdate:params[@"url"]];
        if (res) {
          __weak NSString *str = @"Success";
          Datablock(res,str);
        }
    }
    [_fmDataBase close];
}

-(void)deleteData:(NSString *)dataName Params:(NSDictionary *)params result:(resultBlock)Datablock{
    if ([_fmDataBase open]) {
     
        
    }
    [_fmDataBase close];
}

-(void)removeData:(NSString *)dataName Params:(NSDictionary *)params result:(resultBlock)Datablock{
    if ([_fmDataBase open]) {
        
    }
    [_fmDataBase close];
}

-(void)fixData:(NSString *)dataName  Params:(NSDictionary *)params   result:(resultBlock)Datablock{
    if ([_fmDataBase open]) {
        
        
    }
    [_fmDataBase close];
}

-(void)selectedData:(NSString *)dataName Params:(NSDictionary *)params result:(resultBlock)Datablock{
    if ([_fmDataBase open]) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        FMResultSet *result = [_fmDataBase executeQuery:params[@"url"]];
        BOOL resultBool;
        while(result.next) {
            NSString *stepID = [result stringForColumn:@"stepID"];
            [arr addObject:stepID];
        }
        if (arr.count>0) {
          resultBool = YES;
        }else{
            resultBool = NO;
        }
        Datablock(resultBool,arr);
    }
    [_fmDataBase close];
}
@end
