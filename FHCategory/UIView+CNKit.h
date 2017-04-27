//
//  UIView+CNKit.h
//  SalesAssistantApp
//
//  Created by xyt on 15/1/13.
//  Copyright (c) 2015年 好居. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CNKit)

/**
 *  获取UIImage
 *
 *  @return UIImage
 */
-(UIImage *)getImage;

/**
 *  动画切换效果  push方式
 *
 *  @param direction 动画切换方向 kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
 */
-(void)switchContentViewWithAnimation:(NSString *)direction;

/**
 *  动画切换效果
 *
 *  @param direction      动画切换方向 kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
 *  @param transitionType 动画切换方式 kCATransitionFade、kCATransitionMoveIn、kCATransitionPush、kCATransitionReveal
 */
-(void)switchContentViewWithAnimation:(NSString *)direction type:(NSString *)transitionType;

/**
 *  动画切换效果
 *
 *  @param direction      动画切换方向 kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
 *  @param transitionType 动画切换方式 kCATransitionFade、kCATransitionMoveIn、kCATransitionPush、kCATransitionReveal
 *  @param duration       时长
 */
-(void)switchContentViewWithAnimation:(NSString *)direction type:(NSString *)transitionType duration:(float)duration;

/**
 *  添加点击事件
 *
 *  @param target   目标
 *  @param selector 事件
 */
- (void)addActionWithTarget:(id)target action:(SEL)selector;

/* @property如果写在分类里面就不会生成成员属性,只会生成get,set方法
*  快速设置控件的frame
*/
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic,assign)  CGFloat centerX;
@property (nonatomic,assign)  CGFloat centerY;

/**
 *  详细属性
 */
@property (nonatomic, copy) NSDictionary *info_Dict;


@property (nonatomic, copy) NSString *description;

@end
