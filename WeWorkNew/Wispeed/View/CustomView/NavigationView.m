//
//  NavigationView.m
//  Wispeed
//
//  Created by sunshaoxun on 16/7/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "NavigationView.h"
#import "YCXMenu.h"
#import "HttpRequestSerVice.h"
#import "Single.h"
@implementation NavigationView
{
    Single *single;
    NSArray *DataArr;
    int fag;
}


-(instancetype)initWithFrame:(CGRect)frame view:(UIView *)view tag:(int)tag{
   [self.companyBtn.layer setMasksToBounds:YES];
    self.companyBtn.layer.cornerRadius = 10 ;
    self.companyBtn.clipsToBounds = YES;
    single = [Single Send];
    if(self = [super initWithFrame:frame]){
        self = [[[NSBundle mainBundle] loadNibNamed:@"NavigationView" owner:self options:nil] firstObject];
        self.frame = frame;
    }
    _view = view;
     fag = tag;
    return self;
    
}
-(void)getinfo{
    single =[Single Send];
    DataArr = [NSArray array];
    [HttpRequestSerVice getUserCompanyid:single.userID andToken:single.Token SuccessBlock:^(NSDictionary *dic){
        if ([dic[@"Flag"]isEqualToString:@"S"]) {
            DataArr = dic[@"CompanyArray"];
            [self addSet];
        }
    } FailuerBlock:^(NSString *str) {
        
    }];
}

- (IBAction)companyBtnClick:(id)sender {
    [self.delegate sendInfo:1 imageType:@"1"];
    if (fag == 0) {
   //[self getinfo];
    }
}

-(NSMutableArray *)items {
 if(!_items) {
        _items = [NSMutableArray array];
        NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:0];
        [dataArr addObject:[YCXMenuItem menuItem:@"我(全部公司)" image:[UIImage imageNamed:@""] tag:0 userInfo:@{@"title":@""}]];
        for (int i =0;i<DataArr.count;i++) {
        [dataArr addObject:[YCXMenuItem menuItem:DataArr[i][@"CompanyName"]
                                             image:[UIImage imageNamed:@""]
                                               tag:[DataArr[i][@"CompanyID"] intValue]
                                           userInfo:@{@"title":DataArr[i][@"CompanyLogo"]}]];
        }
      [_items addObjectsFromArray:dataArr];
    }
    return _items;
}

-(void)addSet{
    [YCXMenu setTintColor:[UIColor colorWithRed:0.25 green:0.27 blue:0.29 alpha:1]];
    if ([YCXMenu isShow]){
        [YCXMenu dismissMenu];
    } else {
        if (DataArr.count==0) {
        }
        else{
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
        [YCXMenu showMenuInView:window fromRect:CGRectMake(0,self.frame.size.height+10, 0, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"CompanyID"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",(long)item.tag] forKey:@"CompanyID"];
            
            single = [Single Send];
            single.CompanyID = [[[NSUserDefaults standardUserDefaults]objectForKey:@"CompanyID"] intValue];
            id imageType;
            if (![item.userInfo[@"title"] isKindOfClass:[NSNull class]]&&![item.userInfo[@"title"]isEqualToString:@""]) {
                [self.companyBtn sd_setImageWithURL:[NSURL URLWithString:DataArr[index][@"CompanyLogo"]] forState:UIControlStateNormal];
                imageType = DataArr[index][@"CompanyLogo"];
            }else{
                UIImage *imageN;
              if(index==0){
//                [self.companyBtn setImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
                  imageN = [UIImage imageNamed:@"black.png"];
              }else{
                 imageN = [self imageAddText:[UIImage imageNamed:@"white_image.png"] text:item.title];
//               [self.companyBtn setImage:imageN forState:UIControlStateNormal];
                }
             imageType=imageN;
            }
            single.imageNavType = imageType;
            [self.delegate sendInfo:index imageType:imageType];
            }];
        }
    }
}

- (UIImage *)imageAddText:(UIImage *)img text:(NSString *)logoText{
    NSString *str0 = [logoText substringWithRange:NSMakeRange(0, 4)];
    NSString *str1 = [str0 substringToIndex:2];
    NSString *str2 = [str0 substringFromIndex:2];
    
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    NSDictionary *attr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:9], NSForegroundColorAttributeName : [UIColor whiteColor]  };
    //位置显示
    [str1 drawInRect:CGRectMake(5,5, w*0.8, h*0.3) withAttributes:attr];
    [str2 drawInRect:CGRectMake(5,15,w*0.8, h*0.3) withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
}

@end
