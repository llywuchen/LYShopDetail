//
//  LYShopDetailScrollView.h
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYShopDetailScrollView : UIScrollView

@property (nonatomic,strong,readonly) NSArray<UIView *> *subViews;
@property (nonatomic,copy) void (^tabBarSelBlock)(NSInteger index);
@property (nonatomic,copy) void (^translationBlock)(CGFloat offset);
@property (nonatomic,assign) BOOL couldScroll;

- (instancetype)initWithSubViews:(NSArray *)subViews;
- (void)showSubView:(NSInteger)index;

- (UIScrollView *)currentSubScorllView;
- (UIScrollView *)subScorllViewAtIndex:(NSInteger)index;

- (void)showNoNetWorkDefaultView;

@end
