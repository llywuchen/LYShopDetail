//
//  LYShopDetailViewModel.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailViewModel.h"

#pragma mark -
#pragma mark - LYShopDetailViewModel

@interface LYShopDetailViewModel ()

@property (nonatomic,strong) LYShopDetailUserCase *userCase;

@end

@implementation LYShopDetailViewModel

- (instancetype)init{
    self = [super init];
    if(self){
        [self refresh];
    }
    return self;
}

#pragma mark -
#pragma mark - getter and setter
- (NSArray *)tabBarTitleArray{
    return @[@"店铺首页",@"全部宝贝",@"新品上架",@"微淘动态"];
}

- (NSArray *)tabBarTitleImageArray{
    return @[@"tab1",@"tab2",@"tab3",@"tab4"];
}

- (NSArray *)tabBarTitleSelImageArray{
    return @[@"tab1-on",@"tab2-on",@"tab3-on",@"tab4-on"];
}

- (LYShopDetailUserCase *)userCase{
    if(!_userCase){
        _userCase = [[LYShopDetailUserCase alloc]init];
    }
    return _userCase;
}

- (NSMutableArray *)dataSourceAtIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            return self.homeDataSource;
        }
            break;
//        case 1:
//        {
//            return self.allDataSource;
//        }
//            break;
        case 2:
        {
            return self.newsDataSource;
        }
            break;
        case 3:
        {
            return self.dymicDataSource;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)setDataSoure:(NSArray *)datasource AtIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore{
    NSArray *oldDataSource = [self dataSourceAtIndex:index];
    NSMutableArray *newDataSource = [NSMutableArray arrayWithArray:datasource];
    if(isLoadMore){
        [newDataSource addObjectsFromArray:oldDataSource];
    }
    switch (index) {
        case 0:
        {
            self.homeDataSource = newDataSource;
        }
            break;
        case 2:
        {
            self.newsDataSource = newDataSource;
        }
            break;
        case 3:
        {
            self.dymicDataSource = newDataSource;
        }
            break;
            
        default:
            break;
    }
}


#pragma mark -
- (void)refresh{
    [self requestShopDetail];
    [self requestDefaultData];
}


- (void)requestDefaultData{
    [self requestDataAtIndex:_currentIndex isLoadMore:false];
}

- (void)requestDataAtIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore{
    if(!isLoadMore&&[self dataSourceAtIndex:index].count>0)
        return;
    if(_currentIndex==1){
        
    }else{
        [self.userCase shopProductInfoRequestWithShopId:_shopId type:_currentIndex order:false pageNum:0 pageSize:20 Success:^(NSArray *array) {
            [self setDataSoure:array AtIndex:index isLoadMore:isLoadMore];
        } fail:^(NSString *errorMsg) {
            
        }];
    }
}

- (void)requestShopDetail{
    [self.userCase shopInfoRequestWithShopId:_shopId Success:^(LYShopDetailInfo *info) {
        self.shopInfo = info;
    } fail:^(NSString *errorMsg) {
        
    }];
}

- (void)showTabActionAtIndex:(NSInteger)index{
    self.currentIndex = index;
    [self requestDefaultData];
}

#pragma mark data convert
//- (NSMutableArray<GMBShopProductCollectionCellViewData *> *)transfrom:(NSArray<GMBItemsExtModel *> *)data{
//    NSMutableArray *array = [NSMutableArray array];
//    for(GMBItemsExtModel *items in data){
//        GMBShopProductCollectionCellViewData *vd = [[GMBShopProductCollectionCellViewData alloc]initWithProductID:items.item.id shopID:items.item.shopId productMainImage:items.item.mainImage productName:items.item.name productsalePrice:items.item.salePrice originalPrice:items.item.price isRebate:items.item.isRebate isDiscount:items.item.isDiscount onShelfAt:items.item.onShelfAt];
//        [array addObject:vd];
//    }
//    return array;
//}

@end
