//
//  LeftMenuViewDemo.m
//  MenuDemo
//
//  Created by Lying on 16/6/12.
//  Copyright © 2016年 Lying. All rights reserved.
//
#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200

#import "LeftMenuViewDemo.h"
#import "Single.h"
@interface LeftMenuViewDemo ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView    *contentTableView;

@end

@implementation LeftMenuViewDemo

 
-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return  self;
}

-(void)initView{
    
    Single *single = [Single Send];
    //添加头部
    UIView *headerView     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Frame_Width, 90)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    CGFloat width          = 90/2;
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(12, (90 - width) / 2, width, width)];
//    [imageview setBackgroundColor:[UIColor redColor]];
    imageview.layer.cornerRadius = imageview.frame.size.width / 2;
    imageview.layer.masksToBounds = YES;
    
    if ([single.headImg isEqualToString:@"Kobe.jpg"]||[single.headImg isEqualToString:@""]) {
        imageview.image = [UIImage imageNamed:@"Kobe.jpg"];
    }
    else{
        NSString *Imgstr;
        if ([single.headImg rangeOfString:@"http"].length>0)  {
            Imgstr=[single.headImg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        }else{
            NSString *str = [NSString stringWithFormat:@"%@/%@",IMGURL,single.headImg];
            Imgstr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        }
        NSURL *imageUrl =[NSURL URLWithString:Imgstr];
        [ imageview sd_setImageWithURL:imageUrl];
    }
    
    [headerView addSubview:imageview];
    width                  = 15;
    UIImageView *arrow     = [[UIImageView alloc]initWithFrame:CGRectMake(Frame_Width - width - 10, (90 - width)/2, width, width)];
    arrow.contentMode      = UIViewContentModeScaleAspectFit;
    [arrow setImage:[UIImage imageNamed:@"person-icon0"]];
    [headerView addSubview:arrow];
    
    UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.size.width + imageview.frame.origin.x * 2, imageview.frame.origin.y, 90, imageview.frame.size.height)];
    [NameLabel setText:single.NickName];
    [headerView addSubview:NameLabel];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headViewClick)];
    ges.numberOfTapsRequired =1 ;
    ges.numberOfTouchesRequired=1;
    [headerView addGestureRecognizer:ges];
    
    [self addSubview:headerView];
    
    
    //中间tableview
    UITableView *contentTableView        = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, Frame_Width, self.frame.size.height - headerView.frame.size.height * 2)
                                                                       style:UITableViewStylePlain];
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    contentTableView.tableFooterView = [UIView new];
    self.contentTableView = contentTableView;
    [self addSubview:contentTableView];
    
    //添加尾部
    width              = 90;
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - headerView.frame.size.height, Frame_Width, self.frame.size.height)];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *LoginImageview = [[UIImageView alloc]initWithFrame:CGRectMake(8 + 5, (width - ImageviewWidth)/2, ImageviewWidth, ImageviewWidth)];
    [LoginImageview setImage:[UIImage imageNamed:@"person-icon8"]];
    [footerView addSubview:LoginImageview];
    width = 30;

    
    [self addSubview:footerView];
}

-(void)headViewClick{
    [self.customDelegate LeftMenuViewClick:-1];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"LeftView%li",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];

    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setTextColor:[UIColor grayColor]];

    cell.hidden = NO;
    switch (indexPath.row) {
        case 0:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"tabbar_set"]];
            [cell.textLabel setText:@"设置"];
        }
            break;
            
        case 1:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"tabbar_aboutus"]];
            [cell.textLabel setText:@"关于公司"];
        }
            break;
        case 2:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"tabbar_exict"]];
            [cell.textLabel setText:@"退出"];
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:indexPath.row];
    }
}
@end
