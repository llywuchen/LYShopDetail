//
//  LYShopDetailViewModel.h
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYShopDetailUserCase.h"

@interface LYShopDetailViewModel : NSObject

@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) long shopId;

@property (nonatomic,strong) LYShopDetailInfo *shopInfo;
@property (nonatomic,strong) NSMutableArray *homeDataSource;
@property (nonatomic,strong) NSMutableArray *newsDataSource;
@property (nonatomic,strong) NSMutableArray *dymicDataSource;

@property (nonatomic,assign) int homeTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) int dymicTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) int newTotalPage;//上新tab 当前的分页

- (NSArray *)tabBarTitleArray;

- (NSArray *)tabBarTitleImageArray;

- (NSArray *)tabBarTitleSelImageArray;


- (void)refresh;


- (void)requestDefaultData;

- (void)requestShopDetail;

- (void)showTabActionAtIndex:(NSInteger)index;

@end
