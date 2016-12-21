//
//  LYShopDetailTabScrollView.h
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYShopDetailTabScrollView : UIView

- (instancetype)initWithShopId:(long)shopId;

- (void)reloadData;

- (void)loadDefaultData;

//- (void)setContentOffset:(CGFloat)offset;

- (void)setCouldScroll:(BOOL)scrollEnabled;

@end
