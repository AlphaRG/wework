//
//  NavigationView.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Single.h"
@protocol sendInfoDelegate<NSObject>
-(void)sendInfo:(NSInteger)fag imageType:(id)type;
@end

@interface NavigationView : UIView 

-(instancetype)initWithFrame:(CGRect)frame view:(UIView *)view tag:(int)tag;
@property(nonatomic,weak)id <sendInfoDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,weak)UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *companyBtn;
- (IBAction)companyBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@end
