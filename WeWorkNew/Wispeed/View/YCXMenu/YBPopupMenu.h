//
//  YBPopupMenu.h
//  MercyMap
//
//  Created by sunshaoxun on 17/1/7.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , YBPopupMenuType) {
    YBPopupMenuTypeDefault = 0,
    YBPopupMenuTypeDark
};

@class YBPopupMenu;
@protocol YBPopupMenuDelegate <NSObject>

@optional
/**
 点击事件回调
 */
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu;

@end


@interface YBPopupMenu : UIView

/**
 圆角半径 Default is 5.0
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 是否显示阴影 Default is YES
 */
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowShadow;

/**
 选择菜单项后消失 Default is YES
 */
@property (nonatomic, assign) BOOL dismissOnSelected;

/**
 点击菜单外消失  Default is YES
 */
@property (nonatomic, assign) BOOL dismissOnTouchOutside;

/**
 设置字体大小 Default is 15
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 设置字体颜色 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor * textColor;

/**
 设置偏移距离 (>= 0) Default is 0.0 
 */
@property (nonatomic, assign) CGFloat offset;

/**
 设置显示模式 Default is YBPopupMenuTypeDefault
 */
@property (nonatomic, assign) YBPopupMenuType type;

/**
 代理
 */
@property (nonatomic, weak) id <YBPopupMenuDelegate> delegate;

/*
 view tag
 */
@property(nonatomic,assign)NSInteger fag;

/**
 初始化popupMenu

 @param titles    标题数组
 @param icons     图标数组
 @param itemWidth 菜单宽度
 @param delegate  代理
 */
- (instancetype)initWithTitles:(NSArray *)titles
                         icons:(NSArray *)icons
                     menuWidth:(CGFloat)itemWidth
                      delegate:(id<YBPopupMenuDelegate>)delegate;


/**
 在指定位置弹出类方法
 */
+ (instancetype)showAtPoint:(CGPoint)point
                     titles:(NSArray *)titles
                      icons:(NSArray *)icons
                  menuWidth:(CGFloat)itemWidth
                        fag:(NSInteger)fag
                   delegate:(id<YBPopupMenuDelegate>)delegate;


/**
  依赖指定view弹出类方法
 */
+ (instancetype)showRelyOnView:(UIView *)view
                        titles:(NSArray *)titles
                         icons:(NSArray *)icons
                     menuWidth:(CGFloat)itemWidth
                      delegate:(id<YBPopupMenuDelegate>)delegate;


/**
 在指定位置弹出

 @param point 需要弹出的point
 */
- (void)showAtPoint:(CGPoint)point;


/**
 依赖指定view弹出

 @param view 需要依赖的view
 */
- (void)showRelyOnView:(UIView *)view;

/**
 消失
 */
- (void)dismiss;
@end
