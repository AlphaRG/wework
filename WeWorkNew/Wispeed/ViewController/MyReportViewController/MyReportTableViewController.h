//
//  MyReportTableViewController.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/11.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyReportTableViewController : UITableViewController
//@property(nonatomic, strong)NSMutableArray *addGridTitleArray;//接收更多标签页面传过来的值
//@property(nonatomic, strong)NSMutableArray *addGridImageArray;//image
//@property(nonatomic, strong)NSMutableArray *addGridIDArray;//gridId
@property(nonatomic, strong)NSMutableArray *gridListArray;

@property(nonatomic, strong)NSMutableArray *showGridArray; //title
@property(nonatomic, strong)NSMutableArray *showGridImageArray;//image
@property(nonatomic, strong)NSMutableArray *showGridIDArray;//gridId

//更多页面显示应用
@property(nonatomic, strong)NSMutableArray *moreGridTitleArray;
@property(nonatomic, strong)NSMutableArray *moreGridIdArray;
@property(nonatomic, strong)NSMutableArray *moreGridImageArray;//image

@end
