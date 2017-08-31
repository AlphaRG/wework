//
//  GlobalKey.h
//  Wispeed
//
//  Created by RainGu on 17/3/14.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#ifndef GlobalKey_h
#define GlobalKey_h

#endif /* GlobalKey_h */

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define URLM [[NSUserDefaults standardUserDefaults]objectForKey:@"URL"]   

#define URLMWWEB [[NSUserDefaults standardUserDefaults]objectForKey:@"URLWeb"]
#define USERURL [[NSUserDefaults standardUserDefaults]objectForKey:@"userURL"]
#define companyname [[NSUserDefaults standardUserDefaults]objectForKey:@"CompanyName"]
#define IMGURL   [[NSUserDefaults standardUserDefaults]objectForKey:@"imgURL"]

#define TABBAR_COLOR  [UIColor colorWithRed:24/255.0 green:147/255.0 blue:30/255.0 alpha:0.6]
#define TINT_COLOR    [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:1.0]


#define CREATEFMDBDATA  @"CREATE TABLE task_table (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,stepID integer NOT NULL,viewType integer NOT NULL,userID integer NOT NULL);"

#define DATANAME @"task.sqlite"

#define DATATABLE @"task_table"
