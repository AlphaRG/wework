//
//  RightTableViewCell.m
//  doubleTableView
//
//  Created by tarena13 on 15/10/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "RightTableViewCell.h"
#import "WW_heardView.h"
#import "UIView+RGExtension.h"
@implementation RightTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number Fag:(viewType)fag 
{
    NSString *identifier = [NSString stringWithFormat:@"cell%ld",fag];
    // 1.缓存中取
    RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
         cell = [[RightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        WW_heardView *view = [[WW_heardView alloc]init];
        view.delegate = cell;
        view.tag = 100;

        switch (fag) {
            case 0:
                [cell.contentView addSubview:[view viewWithLabelNumber:number]];
                break;
            case 1:
                [cell.contentView addSubview:[view viewWithLabelNumber1:number]];
                break;
            case 2:
                [cell.contentView addSubview:[view viewWithLabelNumber2:number]];
                break;
            case 3:
                [cell.contentView addSubview:[view viewWithLabelNumber3:number]];
                break;
            case 4:
                [cell.contentView addSubview:[view viewWithLabelNumber4:number]];
                break;
            case 5:
                [cell.contentView addSubview:[view viewWithLabelNumber5:number]];
                break;
            case 6:
                [cell.contentView addSubview:[view viewWithLabelNumber5:number]];
                break;
            default:
                break;
        }
    }
    return cell;
}

-(void)sendBtnInfo:(id)tag{
    [self.nodelegate noticeBtnDelegat:tag];
}

-(void)coreData:(id)data fag:(viewType)fag cell:(UITableViewCell *)cell{
    switch (fag) {
        case 0:
            [self setCellView:cell data:data];
            break;
         case 1:
            [self setCellView1:cell data:data];
            break;
         case 2:
            [self setCellView2:cell data:data];
            break;
         case 3:
            [self setCellView3:cell data:data];
            break;
         case 4:
            [self setCellView4:cell data:data];
            break;
          case 5:
            [self setCellView5:cell data:data];
            break;
          case 6:
            [self setCellView6:cell data:data];
            break;
         default:
            break;
    }
}

-(void)setCellView:(UITableViewCell *)cell data:(id)data{
    UIView *view = [cell.contentView viewWithTag:100];
    UIButton *btn;
    UILabel  *lable2;
    NSInteger tag;
    NSMutableDictionary *dic = (NSMutableDictionary *)data;
    for (id label in view.subviews) {
        if ([label isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)label;
            tag =btn.tag;
        }else{
            lable2 = (UILabel *)label;
            tag = lable2.tag;
        }
        switch (tag) {
            case 0:
            {
                if([dic[@"IsMark"] integerValue]>0){
                    [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
                }else{
                    [btn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
                }
            }
                break;
            case 1:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"StepFlagText"]];
                break;
            case 2:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"RunName"]] ;
                break;
            case 3:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"RunID"]];
                break;
            case 4:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"ID"]] ;
                break;
            case 5:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowLevel"]] ;
                break;
            case 6:
               {
                   NSString *str = [NSString stringWithFormat:@"[%@/%@]",dic[@"FlowStepID"],dic[@"StepCount"]];
                lable2.text = [NSString stringWithFormat:@"%@%@",dic[@"StepName"],str] ;
               }
                break;
            case 7:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowStepLevel"]] ;
                
                break;
            case 8:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"StepTime"]] ;
                
                break;
            case 9:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"DeliverTime"]];
                
                break;
            case 10:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"CycleHour"]] ;
                
                break;
            case 11:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"InTime"]] ;
                
                break;
            case 12:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"FlowCompanyName"]];
                
                break;
            case 13:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"InitiatorUser"]] ;
                
                break;
            case 14:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"Operator"]];
                break;
            case 15:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"AmountOut"]];
                break;
             case 16:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"AmountCost"]];
                break;
              case 17:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FormPageID"]];
                break;
              case 18:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowID"]];
            
                break;
              case 19:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"FormID"]];
                break;
            default:
                break;
        }
    }
}

-(void)setCellView1:(UITableViewCell *)cell data:(id)data{
    UIView *view = [cell.contentView viewWithTag:100];
    NSMutableDictionary *dic = (NSMutableDictionary *)data;
    for (UILabel *label in view.subviews) {
        NSInteger tag = label.tag;
        switch (tag) {
            case 0:
                label.text =[NSString stringWithFormat:@"%@",dic[@"CompanyName"]];
                break;
            case 1:
                label.text =[NSString stringWithFormat:@"%@",dic[@"Name"]];

                break;
              case 2:
                label.text =[NSString stringWithFormat:@"%@",dic[@"Level"]];
                break;
            case 3:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FlowVer"]];

                break;
            case 4:
                label.text =[NSString stringWithFormat:@"%@",dic[@"CreateBy"]];

                break;
            case 5:
                label.text =[NSString stringWithFormat:@"%@",dic[@"ReleaseTime"]];

                break;
             case 6:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FlowCycleHour"]];

                break;
            default:
                break;
        }
    }
}

-(void)setCellView2:(UITableViewCell *)cell data:(id)data{
    UIView *view = [cell.contentView viewWithTag:100];
    NSMutableDictionary *dic = (NSMutableDictionary *)data;
    for (UILabel *label in view.subviews) {
        NSInteger tag = label.tag;
        switch (tag) {
            case 0:
                label.text =[NSString stringWithFormat:@"%@",dic[@"MarkDate"]];
                break;
            case 1:
                label.text =[NSString stringWithFormat:@"%@",dic[@"StepFlagText"]];
                
                break;
            case 2:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FlowCompanyName"]];
                
                break;
            case 3:
                label.text =[NSString stringWithFormat:@"%@",dic[@"RunName"]];
                
                break;
            case 4:
                label.text =[NSString stringWithFormat:@"%@",dic[@"RunID"]];
                
                break;
            case 5:
                label.text =[NSString stringWithFormat:@"%@",dic[@"ID"]];
                
                break;
            case 6:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FlowLevel"]];
                
                break;
            case 7:
            {
                NSString *str = [NSString stringWithFormat:@"[%@/%@]",dic[@"FlowStepID"],dic[@"StepCount"]];
                label.text = [NSString stringWithFormat:@"%@%@",dic[@"StepName"],str] ;
            }
                break;
            case 8:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FlowStepLevel"]];
                
                break;
            case 9:
                label.text =[NSString stringWithFormat:@"%@",dic[@"StepTime"]];
                
                break;
            case 10:
                label.text =[NSString stringWithFormat:@"%@",dic[@"DeliverTime"]];
                
                break;
            case 11:
                label.text =[NSString stringWithFormat:@"%@",dic[@"CycleHour"]];
                
                break;
            case 12:
                label.text =[NSString stringWithFormat:@"%@",dic[@"SubmitTIme"]];
                
                break;
            case 13:
                label.text =[NSString stringWithFormat:@"%@",dic[@"CompanyName"]];
                
                break;
            case 14:
                label.text =[NSString stringWithFormat:@"%@",dic[@"OperatorDeparmentName"]];
                break;
            case 15:
                label.text =[NSString stringWithFormat:@"%@",dic[@"InitiatorUser"]];
                
                break;
            case 16:
                label.text =[NSString stringWithFormat:@"%@",dic[@"Operator"]];
                break;
            case 17:
                label.text =[NSString stringWithFormat:@"%@",dic[@"AmountOut"]];
                
                break;
            case 18:
                label.text =[NSString stringWithFormat:@"%@",dic[@"AmountCost"]];
                
                break;
            case 19:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FormPageID"]];
                
                break;
            case 20:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FlowID"]];
                
                break;

           case 21:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FormID"]];
                
                break;
                
            default:
                break;
        }
    }
}

-(void)setCellView3:(UITableViewCell *)cell data:(id)data{
    UIView *view = [cell.contentView viewWithTag:100];
    UIButton *btn;
    UILabel  *lable2;
    NSInteger tag;
    NSMutableDictionary *dic = (NSMutableDictionary *)data;
    for (id label in view.subviews) {
        if ([label isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)label;
            tag =btn.tag;
        }else{
            lable2 = (UILabel *)label;
            tag = lable2.tag;
        }
        switch (tag) {
            case 0:
            {
                if([dic[@"IsMark"] integerValue]>0){
                    [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
                }else{
                    [btn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
                }
            }
                break;
            case 1:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"StepFlagText"]];
                break;
            case 2:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowCompanyName"]];
                break;
            case 3:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"RunName"] ];
                break;
            case 4:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"RunID"]] ;
                break;
            case 5:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"ID"]] ;
                break;
            case 6:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowLevel"] ];
                break;
            case 7:
            {
                NSString *str = [NSString stringWithFormat:@"[%@/%@]",dic[@"FlowStepID"],dic[@"StepCount"]];
                lable2.text = [NSString stringWithFormat:@"%@%@",dic[@"StepName"],str] ;
            }
                
                break;
            case 8:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"FlowStepLevel"]] ;
                
                break;
            case 9:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"StepTime"]] ;
                
                break;
            case 10:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"DeliverTime"] ];
                
                break;
            case 11:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"CycleHour"] ];
                
                break;
            case 12:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"InTime"] ];
                
                break;
            case 13:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"CompanyName"] ];
                
                break;
            case 14:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"OperatorDeparmentName"] ];
                
                break;
            case 15:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"InitiatorUser"] ];
                
                break;
            case 16:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"Operator"] ];
                
                break;
            case 17:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"AmountOut"] ];
                
                break;
            case 18:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"AmountCost"] ];
                
                break;
            case 19:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"FormPageID"] ];
                
                break;
            case 20:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowID"] ];
                
                break;
            case 21:
                lable2.text =[NSString stringWithFormat:@"%@", dic[@"FormID"] ];
                
                break;
            default:
                break;
        }
    }

}

-(void)setCellView4:(UITableViewCell *)cell data:(id)data{
    UIView *view = [cell.contentView viewWithTag:100];
    NSMutableDictionary *dic = (NSMutableDictionary *)data;
    for (UILabel *label in view.subviews) {
        NSInteger tag = label.tag;
        switch (tag) {
            case 0:
                label.text =[NSString stringWithFormat:@"%@",dic[@"CompanyName"]];
                break;
            case 1:
                label.text =[NSString stringWithFormat:@"%@",dic[@"Name"]];
                
                break;
            case 2:
                label.text =[NSString stringWithFormat:@"%@",dic[@"Level"]];
                break;
            case 3:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FlowVer"]];
                
                break;
            case 4:
                label.text =[NSString stringWithFormat:@"%@",dic[@"CreateBy"]];
                
                break;
                
            case 5:
                label.text =[NSString stringWithFormat:@"%@",dic[@"Created"]];
                
                break;

            case 6:
                label.text =[NSString stringWithFormat:@"%@",dic[@"ReleaseTime"]];
                
                break;
            case 7:
                label.text =[NSString stringWithFormat:@"%@",dic[@"FlowCycleHour"]];
                
                break;
            default:
                break;
        }
    }

    
}

-(void)setCellView5:(UITableViewCell *)cell data:(id)data{
    UIView *view = [cell.contentView viewWithTag:100];
    UIButton *btn;
    UILabel  *lable2;
    NSInteger tag;
    NSMutableDictionary *dic = (NSMutableDictionary *)data;
    for (id label in view.subviews) {
        if ([label isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)label;
            tag =btn.tag;
        }else{
            lable2 = (UILabel *)label;
            tag = lable2.tag;
        }
        switch (tag) {
            case 0:
            {
                if([dic[@"IsMark"] integerValue]>0){
                    [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
                }else{
                    [btn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
                }
            }
                break;
            case 1:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"StepFlagText"]];
                break;
            case 2:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"FlowCompanyName"]];
                
                break;
            case 3:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"RunName"]] ;
                break;
            case 4:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"RunID"]];
                break;
            case 5:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"ID"]] ;
                break;
            case 6:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowLevel"]] ;
                break;
            case 7:
            {
                NSString *str = [NSString stringWithFormat:@"[%@/%@]",dic[@"FlowStepID"],dic[@"StepCount"]];
                lable2.text = [NSString stringWithFormat:@"%@%@",dic[@"StepName"],str] ;
            }
                break;
            case 8:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowStepLevel"]] ;
                
                break;
            case 9:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"StepTime"]] ;
                
                break;
            case 10:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"DeliverTime"]];
                
                break;
            case 11:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"CycleHour"]] ;
                
                break;
            case 12:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"InTime"]] ;
                
                break;
            case 13:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"SubmitTIme"]] ;

                break;
            case 14:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"CompanyName"]] ;

                break;
            case 15:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"OperatorDeparmentName"]] ;

                break;
            case 16:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"InitiatorUser"]] ;
                
                break;
            case 17:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"Operator"]];
                break;
            case 18:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"AmountOut"]];
                break;
            case 19:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"AmountCost"]];
                break;
            case 20:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FormPageID"]];
                break;
            case 21:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowID"]];
                
                break;
            case 22:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"FormID"]];
                break;
            default:
                break;
        }
    }
}
-(void)setCellView6:(UITableViewCell *)cell data:(id)data{
    UIView *view = [cell.contentView viewWithTag:100];
    UIButton *btn;
    UILabel  *lable2;
    NSInteger tag;
    NSMutableDictionary *dic = (NSMutableDictionary *)data;
    for (id label in view.subviews) {
        if ([label isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)label;
            tag =btn.tag;
        }else{
            lable2 = (UILabel *)label;
            tag = lable2.tag;
        }
        switch (tag) {
                case 0:
            {
                if([dic[@"IsMark"] integerValue]>0){
                    [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
                }else{
                    [btn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
                }
            }
                break;
                case 1:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"StepFlagText"]];
                break;
                case 2:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"FlowCompanyName"]];
                
                break;
                case 3:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"RunName"]] ;
                break;
                case 4:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"RunID"]];
                break;
                case 5:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"ID"]] ;
                break;
                case 6:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowLevel"]] ;
                break;
                case 7:
                {
                NSString *str = [NSString stringWithFormat:@"[%@/%@]",dic[@"FlowStepID"],dic[@"StepCount"]];
                lable2.text = [NSString stringWithFormat:@"%@%@",dic[@"StepName"],str] ;
                }
                break;
                
                case 8:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowStepLevel"]] ;
                break;
                
                case 9:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"StepTime"]] ;
                break;
                
                case 10:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"DeliverTime"]];
                break;
                
                case 11:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"CycleHour"]] ;
                break;
               
                case 12:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"SubmitTIme"]] ;
                break;
                
                case 13:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"CompanyName"]] ;
                break;
                
                case 14:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"OperatorDeparmentName"]] ;
                break;
                
                case 15:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"InitiatorUser"]] ;
                break;
                
                case 16:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"Operator"]];
                break;
                
                case 17:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"AmountOut"]];
                break;
                
                case 18:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"AmountCost"]];
                break;
                
                case 19:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FormPageID"]];
                break;
                
                case 20:
                lable2.text = [NSString stringWithFormat:@"%@",dic[@"FlowID"]];
                break;
                
                case 21:
                lable2.text =[NSString stringWithFormat:@"%@",dic[@"FormID"]];
                break;
            default:
                break;
        }
    }
}

@end
