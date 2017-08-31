//
//  TaskWebTableViewCell.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskWebTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIWebView *TaskWebView;
-(void)sendUrl:(NSString *)url;

@end
