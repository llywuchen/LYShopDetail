//
//  LYShopDetailHeaderView.h
//  LYShopDetail
//
//  Created by lly on 2016/12/20.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYShopDetailHeaderView : UIView

- (void)bindData:(NSString *)bg icon:(NSString *)icon name:(NSString *)name level:(NSInteger)level fansCount:(NSInteger)fansCount isConcern:(BOOL)isConcern;
@end
