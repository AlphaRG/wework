//
//  MyTaskTableViewController.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/11.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTaskTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegTab;
- (IBAction)selectTaskClick:(id)sender;
-(void)getToken:(int)fag;
-(void)alterController :(UIViewController *)view;
@end
