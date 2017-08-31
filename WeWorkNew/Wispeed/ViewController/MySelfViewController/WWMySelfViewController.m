//
//  WWMySelfViewController.m
//  Wispeed
//
//  Created by RainGu on 17/3/15.
//  Copyright © 2017年 Wispeed. All rights reserved.

#import "WWMySelfViewController.h"
#import "ZZBaseTableViewCell.h"
#import "ThirdAccountRegisterTableViewCell.h"
#import "Single.h"
#import "MM_UnbildViewController.h"
@interface WWMySelfViewController ()<UIAlertViewDelegate>
{
    NSArray      *_thirdRegisterA;
    NSMutableArray *_bindListA;
    Single *single;
    NSInteger  Bindtag;
    NSDictionary *requestdic;
}

@end

@implementation WWMySelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:@[@"ThirdAccountRegisterTableViewCell"]];
    self.title = @"绑定与解绑";
    _thirdRegisterA = @[@{@"image":@"tel.png",@"name":@"手机号",@"BindType":@"10"},@{@"image":@"wexin.png",@"name":@"微信",@"BindType":@"20"},@{@"image":@"weibo.png",@"name":@"微博",@"BindType":@"30"}];
     single = [Single Send];
    _bindListA= [NSMutableArray arrayWithCapacity:0];
    [self.dataArray addObject:_thirdRegisterA];
    [self getbindlist];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    height = 44 ;
    return height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    ThirdAccountRegisterTableViewCell *TCell = [tableView dequeueReusableCellWithIdentifier:@"ThirdAccountRegisterTableViewCell" forIndexPath:indexPath];
     TCell.tag = indexPath.row;
     TCell.bindlistArray = _bindListA;
     [TCell setdatainfo:_thirdRegisterA[indexPath.row]];
     cell = TCell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UMSocialPlatformType platformType ;
    switch (indexPath.row){
        case 0:
            [self mobileBild];
            break;
        case 1:
            platformType = UMSocialPlatformType_WechatSession;
            [self RegplatformType:platformType];
            break;
        case 2:
            platformType = UMSocialPlatformType_Sina;
            [self RegplatformType:platformType];
            break;
        default:
            break;
    }
}


-(void)mobileBild{
    MM_UnbildViewController *vc = [[MM_UnbildViewController alloc]initWithNibName:@"MM_UnbildViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)RegplatformType:(UMSocialPlatformType)platformType{
    [[UMSocialManager defaultManager]getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
        }else{
            if ([result isKindOfClass:[UMSocialUserInfoResponse class]]) {
                UMSocialUserInfoResponse *response = result;
                NSString     *url ;
                switch (platformType) {
                    case 0:
                        Bindtag = 1;
                        url = [NSString stringWithFormat:@"%@%@",USERURL,@"api/Bind/BindWeibo"];
                        requestdic = @{
                                       @"weibouid":response.uid,
                                       @"access_token":response.accessToken,
                                       @"UID":[NSNumber numberWithInt:single.userID],
                                       @"Token":single.Token,
                                       @"FormPlatform":@20,
                                       @"ClientType":@10
                                       };
                        [self bindTird:requestdic url:url];
                        break;
                    case 1:
                        Bindtag = 2;
                        url = [NSString stringWithFormat:@"%@%@",USERURL,@"api/Bind/BindWeixin"];
                        requestdic = @{
                                       @"openid":response.openid,
                                       @"access_token":response.accessToken,
                                       @"UID":[NSNumber numberWithInt:single.userID],
                                       @"Token":single.Token,
                                       @"FormPlatform":@20,
                                       @"ClientType":@10
                                       };
                        [self bindTird:requestdic url:url];
                        break;
                    default:
                        break;
                }
                
            }else{
                
            }
        }
    }];
}

-(void)bindTird:(NSDictionary *)reqdic url:(NSString *)url{
    [HttpRequestSerVice getDicUrl:url Dic:requestdic Title:nil SuccessBlock:^(NSDictionary *dic) {
        if ([dic[@"Flag"] isEqualToString:@"S"]) {
            [self getbindlist];
            [CommoneTools alertOnView:self.view content:@"绑定成功"];
        }else if ([dic[@"Flag"] isEqualToString:@"F"]){
            [self alterViewContrllerBind:requestdic];
        }
    } FailuerBlock:^(NSString *str) {
        
    }];
}

-(void)alterViewContrllerBind:(NSDictionary *)dic{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ThirdAccountRegisterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell.noOryes.text isEqualToString:@"绑定"]) {
        UIAlertView *okView = [[UIAlertView alloc]initWithTitle:@"是否解绑" message:@"该账号已经被绑定是否解绑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [okView show];
    }else{
        [CommoneTools alertOnView:self.view content:@"此第三方账号已绑定其它唯沃客账号，无法再与您的唯沃客账号绑定"];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self unbindTird];
            break;
        default:
            break;
    }
}

-(void)unbindTird{
    NSString *url;
    switch (Bindtag) {
        case 0:
            url = [NSString stringWithFormat:@"%@api/Bind/UnBindMobileNum",USERURL];
            break;
        case 1:
            url = [NSString stringWithFormat:@"%@api/Bind/UnBindWeibo",USERURL];
            break;
        case 2:
            url =[NSString stringWithFormat:@"%@api/Bind/UnBindWeixin",USERURL];
            break;
        case 3:
            url = [NSString stringWithFormat:@"%@api/Account/MemberUpdate",USERURL];
        default:
            break;
    }
    
      [HttpRequestSerVice getDicUrl:url Dic:requestdic Title:nil SuccessBlock:^(NSDictionary *dic) {
       if ([dic[@"Flag"] isEqualToString:@"S"]) {
               [self getbindlist];
               [CommoneTools alertOnView:self.view content:@"解绑成功"];
       }else if ([dic[@"Flag"] isEqualToString:@"F"]){
           [CommoneTools alertOnView:self.view content:@"解绑失败"];
       }
     } FailuerBlock:^(NSString *str) {
    
    }];
}

-(void)getbindlist{
    NSDictionary *binddic;
    NSString     *url = [NSString stringWithFormat:@"%@api/Bind/MemberBindList",USERURL];
    NSNumber *ID  = [NSNumber numberWithInt:single.userID];
    binddic = @{@"UID":ID ,@"Token":single.Token,@"ClientType":@10};
    [HttpRequestSerVice getDicUrl:url Dic:binddic Title:nil SuccessBlock:^(NSDictionary *dic) {
        if ([dic[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
            [_bindListA addObjectsFromArray:dic[@"IlistMembers_Bind"]];
        }else{
            [CommoneTools alertOnView:self.view content:dic[@"OMsg"][@"Msg"]];
        }
        [self.tableView reloadData];
    } FailuerBlock:^(NSString *str) {
    }];
}

@end
