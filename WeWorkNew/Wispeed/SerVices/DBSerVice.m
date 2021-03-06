//
//  DBSerVice.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "DBSerVice.h"

@implementation DBSerVice

/**
 *  获取本地地址
 *
 *  @return
 */
-(NSString *)getDBpath:(NSString *)fileName{
    NSString *paths = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Caches"];
    [[NSFileManager defaultManager]createDirectoryAtPath:paths withIntermediateDirectories:YES attributes:nil error:NULL];
    NSString *dbPath = [paths stringByAppendingPathComponent:fileName];
    return dbPath;
}

/**
 *  查找数据
 *
 *  @param sql     <#sql description#>
 *  @param getInfo <#getInfo description#>
 */
-(void)getDBInfo:(NSString *)sql getInfo:(getDBInfoBlock)getInfo{
    NSString * path = [self getDBpath:@"data.sqlite"];
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
//    [queue inDatabase:^(FMDatabase *db) {
//        [db open];
//        
//    }];
    FMDatabase *database =[FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *result = [database executeQuery:sql];
    if([result next]){
            NSString *success =[result stringForColumn:@"time"];
            [database close];
            getInfo(success);
        }
        else{
            NSString *str =@"F";
            [database close];
            getInfo(str);
        }
}
/**
 *  更新数据调用
 *
 *  @param sql     sql语句
 *  @param gettime 返回成功
 */
-(void)getDBInfo:(NSString *)sql gettimeInfo:(getDBInfoBlock)gettime{
        NSString *path = [self getDBpath:@"data.sqlite"];
        FMDatabase *database =[FMDatabase databaseWithPath:path];
        [database open];
        [database beginTransaction];
        BOOL isRollBack = NO;
        @try {
            BOOL isSuccess = [database executeUpdate:sql];
            if (isSuccess)
            {
                gettime(@"S");
            }
        } @catch (NSException *exception) {
            isRollBack = YES;
            [database rollback];
        } @finally {
            if (!isRollBack)
            {
                [database commit];
            }
         }
        [database close];
    }
@end
