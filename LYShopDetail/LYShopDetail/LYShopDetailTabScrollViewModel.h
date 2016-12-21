//
//  LYShopDetailTabScrollViewModel.h
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,GMShopDetailAllProduct) {
    LYShopDetailAllProduct_common = 0,
    LYShopDetailAllProduct_sales,
    LYShopDetailAllProduct_new,
    LYShopDetailAllProduct_price
};

@interface LYShopDetailTabScrollViewModel : NSObject

@property (nonatomic,assign) long shopId;
@property (nonatomic,strong) NSMutableArray *allCommonDataSource;
@property (nonatomic,strong) NSMutableArray *allSalesDataSource;
@property (nonatomic,strong) NSMutableArray *allNewDataSource;
@property (nonatomic,strong) NSMutableArray *allPriceDataSource;

- (NSMutableArray *)tabBarTitleArray;

- (void)loadDataRequestAtIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore;
- (void)loadDataRequestAtIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore isOrder:(BOOL)order;

- (NSInteger)getTotalPageAtIndex:(NSInteger)index;

@end
