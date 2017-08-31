//
//  AppDelegate.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/11.
//  Copyright © 2016年 Wispeed. All rights reserved.
#import "AppDelegate.h"
#import "PTSingletonManager.h"
#import "MyReportTableViewController.h"
#import "IQKeyboardManager.h"
#import "UserLogViewController.h"
#import "Single.h"
#import "HttpRequestSerVice.h"
#import "DBSerVice.h"
#import "MyTaskTableViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "AFNetworkActivityIndicatorManager.h"
#import "PCCircleViewConst.h"
#import "GestureViewController.h"
#import "NSUserDefaultsInfo.h"
#import "FingerPrintViewController.h"
#import "UMessage.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate>
{
    DBSerVice *DBService;
}
@end

@implementation AppDelegate

- (void)umengTrack {
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58c7b33e1c5dd00390001c44"];
    [self configUSharePlatforms];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[IQKeyboardManager sharedManager ]setShouldResignOnTouchOutside:YES];
    [IQKeyboardManager sharedManager].enable =YES;
    [SMSSDK registerApp:appkey withSecret:appsecret];
//  [self createData];
    [self getURL];
    [self judgeUserLog];
    [self umengTrack];
    [self UNotifications:launchOptions];
    [self AFNet];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
    }
    return result;
}

-(void)getURL{
    DBService  = [[DBSerVice alloc]init];
    NSString *path  = [DBService getDBpath:@"data.sqlite"];
    NSFileManager *filemanager =[NSFileManager defaultManager];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if ([filemanager fileExistsAtPath:path]) {
       NSString *sql = [NSString stringWithFormat:@"select * from URL WHERE id = 1;"];
       [DBService getDBInfo:sql getInfo:^(NSString *info) {
           if ([info isEqualToString:@"F"]||info== nil) {
               [self getRequestURL];
            }
           else{
               NSDate *date = [formatter dateFromString:info];
               NSCalendar *calendar = [NSCalendar currentCalendar];
               NSDateComponents *dCom = [calendar components:NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:0];
               if (dCom.day>0){
                   NSString *sql2 = [NSString stringWithFormat:@"delete from URL;"];
                   [DBService getDBInfo:sql2 gettimeInfo:^(NSString *info) {
                       if ([info isEqualToString:@"S"]) {
                           [self getRequestURL];
                       }
                 }];
               }
    else{
            [self judgeUserLog];
        }
            }
        }];
}
else{
       NSString *sql =[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS URL (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,time varchar NULL,time1 varchar  NULL);"];
       [DBService getDBInfo:sql gettimeInfo:^(NSString *info) {
           if ([info isEqualToString:@"S"]) {
            [self getRequestURL];
           }
       }];
       }
}

-(void)getRequestURL{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date =[NSDate date];
    NSString * str1 = [formatter stringFromDate:date];
    [HttpRequestSerVice getAppURL:@"" SuccessBlock:^(NSDictionary *dic) {
        if ([dic[@"Flag"]isEqualToString:@"S"]){
            NSUserDefaults *defaults;
            [defaults removeObjectForKey:@"userURL"];
            [defaults removeObjectForKey:@"URL"];
            [defaults removeObjectForKey:@"URLWeb"];
            for (NSDictionary *urldic in dic[@"ListAppIUrls"]) {
                if ([urldic[@"UrlType"]isEqualToString:@"usercenter"]) {
                    [[NSUserDefaults standardUserDefaults]setObject:urldic[@"Url"] forKey:@"userURL"];
                }if ([urldic[@"UrlType"]isEqualToString:@"wework"]) {
                    [[NSUserDefaults standardUserDefaults]setObject:urldic[@"Url"] forKey:@"URL"];
                }if ([urldic[@"UrlType"]isEqualToString:@"weworkweb"]) {
                    [[NSUserDefaults standardUserDefaults]setObject:urldic[@"Url"] forKey:@"URLWeb"];
                }if ([urldic[@"UrlType"]isEqualToString:@"usercenter_img"]) {
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"imgURL"];
                    [[NSUserDefaults standardUserDefaults]setObject:urldic[@"Url"] forKey:@"imgURL"];
                }

            }
            NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO URL(time) VALUES ('%@');",str1];
            [DBService getDBInfo:sql1 gettimeInfo:^(NSString *info) {
                if ([info isEqualToString:@"S"]) {
                }
            }];
            [self judgeUserLog];
        }
    } FailuerBlock:^(NSString *str) {
        [self judgeUserLog];
    }];
}


-(void)judgeUserLog{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLog"]boolValue]){
        [self getloginWay];
}else{
    self.window = [[UIWindow alloc]init];
    UIViewController *VC;
    VC = [[UserLogViewController alloc]initWithNibName:@"UserLogViewController" bundle:nil];
    self.window.rootViewController =VC;
    [self.window makeKeyAndVisible];
  }
}

-(void)getloginWay{
   NSInteger tag =[[PCCircleViewConst getGestureWithKey:loginKeyWay] integerValue];
    switch (tag) {
        case 0:
            [NSUserDefaultsInfo getInfo];
            break;
        case 1:
        {
            GestureViewController *gestureVc = [[GestureViewController alloc] init];
            gestureVc.type = GestureViewControllerTypeLogin;
            self.window = [[UIWindow alloc]init];
            self.window.rootViewController =gestureVc;
            [self.window makeKeyAndVisible];
        }
            break;
        case 2:
        {
            FingerPrintViewController *fingerVC = [[FingerPrintViewController alloc]init];
            fingerVC.type = fingerPrintTypeLogin;
            self.window = [[UIWindow alloc]init];
            self.window.rootViewController = fingerVC;
            [self.window makeKeyAndVisible];
        }
            break;
            
        default:
            break;
    }
   
}

-(void)createData{
    // 如果数组有改变
    NSArray * titleArray = [[NSArray alloc]init];
    NSArray * imageArray = [[NSArray alloc]init];
    NSArray * idArray = [[NSArray alloc]init];
    titleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"title"];
    imageArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
    idArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"gridID"];
    NSLog(@"array = %@",titleArray);
    NSArray * moretitleArray = [[NSArray alloc]init];
    NSArray * moreimageArray = [[NSArray alloc]init];
    NSArray * moreidArray = [[NSArray alloc]init];
    moretitleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"moretitle"];
    moreimageArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"moreimage"];
    moreidArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"moregridID"];
    // Home按钮数组 体验账号
    [PTSingletonManager shareInstance].showGridArray = [[NSMutableArray alloc]initWithCapacity:0];
    [PTSingletonManager shareInstance].showImageGridArray = [[NSMutableArray alloc]initWithCapacity:0];
    [PTSingletonManager shareInstance].moreshowGridArray=[[NSMutableArray alloc]initWithCapacity:0];
    [PTSingletonManager shareInstance].moreshowImageGridArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [PTSingletonManager shareInstance].showGridArray = [NSMutableArray arrayWithObjects:@"绩效考核",@"月绩效",@"年绩效",@"更多",nil];
    [PTSingletonManager shareInstance].showImageGridArray =
    [NSMutableArray arrayWithObjects:
     @"report_kpi",@"report_month", @"report_year",
     @"report_more", nil];
    [PTSingletonManager shareInstance].showGridIDArray =
    [NSMutableArray arrayWithObjects:
     @"1000",@"1001", @"1002",
     @"0", nil];
    
    [PTSingletonManager shareInstance].moreshowGridArray=[NSMutableArray arrayWithObjects:@"系统报表",@"业务报表",@"个人报表",nil];
    [PTSingletonManager shareInstance].moreshowImageGridArray=[NSMutableArray arrayWithObjects:@"systerm_report.png",@"work_report.png",@"source.png", nil];
    [PTSingletonManager shareInstance].moreshowGridIDArray=[NSMutableArray arrayWithObjects:@"1003",@"1004",@"1005",nil];
    
//    NSLog(@"moreID is %@",[PTSingletonManager shareInstance].moreshowGridIDArray);
    
    // 对比数组
    NSMutableString * defaString = [[NSMutableString alloc]init];
    NSMutableString * localString = [[NSMutableString alloc]init];
    
    // 默认
    for (int i = 0; i< [PTSingletonManager shareInstance].showGridArray.count; i++) {
        [defaString appendString:[PTSingletonManager shareInstance].showGridArray[i]];
        //        NSLog(@"defaString = %@",defaString);
    }
    // 本地
    for (int i = 0; i< titleArray.count; i++) {
        [localString appendString:titleArray[i]];
        //NSLog(@"localString = %@",localString);
    }
    // 如果本地数组有改变
    if (![localString isEqualToString:defaString] && localString.length>4) {
        [PTSingletonManager shareInstance].showGridArray = [[NSMutableArray alloc]initWithArray:titleArray];
        [PTSingletonManager shareInstance].showImageGridArray = [[NSMutableArray alloc]initWithArray:imageArray];
        [PTSingletonManager shareInstance].showGridIDArray = [[NSMutableArray alloc]initWithArray:idArray];
        [PTSingletonManager shareInstance].moreshowGridArray = [[NSMutableArray alloc]initWithArray:moretitleArray];
        [PTSingletonManager shareInstance].moreshowImageGridArray = [[NSMutableArray alloc]initWithArray:moreimageArray];
        [PTSingletonManager shareInstance].moreshowGridIDArray = [[NSMutableArray alloc]initWithArray:moreidArray];
    }
}

-(void)configUSharePlatforms{
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx017314492bcb358d" appSecret:@"0afa9f79ffd62506ee7a83f9fdc385ce" redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"4166837494"  appSecret:@"2a4f67a6ac24a27561de39d380df653b" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

-(void)AFNet{
 [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
 [[AFNetworkReachabilityManager sharedManager] startMonitoring];
 [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"网络似乎已经断开连接";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:3];
    }
  }];
}

-(void)UNotifications:(NSDictionary *)launchOptions{
    [UMessage startWithAppkey:@"58c7b33e1c5dd00390001c44" launchOptions:launchOptions httpsEnable:YES];
    [UMessage registerForRemoteNotifications];
    [UMessage openDebugMode:YES];

    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
           
        } else {
                    }
    }];
    [UMessage setLogEnabled:YES];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UIApplication sharedApplication].applicationIconBadgeNumber=5;
    [UMessage didReceiveRemoteNotification:userInfo];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString * token = [[[[deviceToken description]
                          stringByReplacingOccurrencesOfString: @"<" withString: @""]
                         stringByReplacingOccurrencesOfString: @">" withString: @""]
                        stringByReplacingOccurrencesOfString: @" " withString: @""];
     NSLog(@"友盟token:%@",token);
    [PCCircleViewConst saveGesture:token Key:@"deviceToken"];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken获取失败，原因：%@",error);
}

@end
