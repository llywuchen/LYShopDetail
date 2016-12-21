//
//  LYShopDetailTabScrollViewModel.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailTabScrollViewModel.h"

@interface LYShopDetailTabScrollViewModel ()

@property (nonatomic,assign) NSInteger commonTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) NSInteger salesTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) NSInteger priceTotalPage;//推荐tab 当前的分页
@property (nonatomic,assign) NSInteger newTotalPage;//推荐tab 当前的分页

@end

@implementation LYShopDetailTabScrollViewModel

- (instancetype)init{
    self = [super init];
    if(self){
        _commonTotalPage = 1;
        _salesTotalPage = 1;
        _newTotalPage = 1;
        _priceTotalPage = 1;
    }
    return self;
}

#pragma mark -
#pragma mark --- getter and setter
- (NSMutableArray *)tabBarTitleArray{
    return [NSMutableArray arrayWithObjects:@"综合",@"销量",@"新品",@"价格",nil];
}


- (NSMutableArray *)dataSourceAtIndex:(NSInteger)index{
    switch (index) {
        case LYShopDetailAllProduct_common:
        {
            return self.allCommonDataSource;
        }
            break;
        case LYShopDetailAllProduct_sales:
        {
            return self.allSalesDataSource;
        }
            break;
        case LYShopDetailAllProduct_price:
        {
            return self.allPriceDataSource;
        }
            break;
        case LYShopDetailAllProduct_new:
        {
            return self.allNewDataSource;
        }
            break;
            
        default:
            return nil;
            break;
    }
    
}

- (void)setDataSource:(NSMutableArray *)array atIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore{
    switch (index) {
        case LYShopDetailAllProduct_common:
        {
            if(isLoadMore){
                if(!self.allCommonDataSource) self.allCommonDataSource = [NSMutableArray array];
                NSMutableArray *data = [NSMutableArray arrayWithArray:self.allCommonDataSource];
                [data addObjectsFromArray:array];
                self.allCommonDataSource = data;
            }else{
                self.allCommonDataSource = array;
            }
        }
            break;
        case LYShopDetailAllProduct_sales:
        {
            if(isLoadMore){
                if(!self.allSalesDataSource) self.allSalesDataSource = [NSMutableArray array];
                NSMutableArray *data = [NSMutableArray arrayWithArray:self.allSalesDataSource];
                [data addObjectsFromArray:array];
                self.allSalesDataSource = data;
            }else{
                self.allSalesDataSource = array;
            }
        }
            break;
        case LYShopDetailAllProduct_price:
        {
            if(isLoadMore){
                if(!self.allPriceDataSource) self.allPriceDataSource = [NSMutableArray array];
                NSMutableArray *data = [NSMutableArray arrayWithArray:self.allPriceDataSource];
                [data addObjectsFromArray:array];
                self.allPriceDataSource = data;
            }else{
                self.allPriceDataSource = array;
            }
        }
            break;
        case LYShopDetailAllProduct_new:
        {
            if(isLoadMore){
                if(!self.allNewDataSource) self.allNewDataSource = [NSMutableArray array];
                NSMutableArray *data = [NSMutableArray arrayWithArray:self.allNewDataSource];
                [data addObjectsFromArray:array];
                self.allNewDataSource = data;
            }else{
                self.allNewDataSource = array;
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)setTotalPageAtIndex:(NSInteger)index totalPage:(NSInteger)totalPage{
    if(index ==0){
        self.commonTotalPage = totalPage;
    }else if (index ==1){
        self.salesTotalPage = totalPage;
    }else if (index ==2){
        self.priceTotalPage = totalPage;
    }else{
        self.newTotalPage = totalPage;
    }
}

- (NSInteger)getTotalPageAtIndex:(NSInteger)index{
    if(index ==0){
        return self.commonTotalPage;
    }else if (index ==1){
        return self.salesTotalPage;
    }else if (index ==2){
        return self.priceTotalPage;
    }else{
        return self.newTotalPage;
    }
}

#pragma mark -
#pragma mark --- request
- (void)loadDataRequestAtIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore{
    BOOL isOrder = true;
    if(index ==2){
        isOrder = false;
    }
    [self loadDataRequestAtIndex:index isLoadMore:isLoadMore isOrder:isOrder];
}

- (void)loadDataRequestAtIndex:(NSInteger)index isLoadMore:(BOOL)isLoadMore isOrder:(BOOL)order{
    int currentPage = 0;
    if(isLoadMore){
        currentPage = (int)([self dataSourceAtIndex:index].count-1)/20+1;
    }else if([self dataSourceAtIndex:index].count>0 && index != 2){
        return;
    }
//    [GMShopDetailUserCaseInstance allProductsRequestWithShopId:self.shopId allProductType:index order:order pageNum:++currentPage pageSize:20 Success:^(GMBShopSearchItemsModel *model) {
//        [self setTotalPageAtIndex:index totalPage:model.pageCount];
//        [self setDataSource:[self transfromSearch:model.items] atIndex:index isLoadMore:isLoadMore];
//        [self.endRefreshingAction execute:nil];
//    } fail:^(NSString *errorMsg) {
//        self.toastMessage = errorMsg;
//        [self.endRefreshingAction execute:nil];
//    }];
}

#pragma mark -
#pragma mark --- data convert
//- (NSMutableArray<GMBShopProductCollectionCellViewData *> *)transfromSearch:(NSArray<GMBItems*> *)data{
//    NSMutableArray *array = [NSMutableArray array];
//    for(GMBItems *items in data){
//        GMBShopProductCollectionCellViewData *vd = [[GMBShopProductCollectionCellViewData alloc]initWithProductID:items.id shopID:items.shopId productMainImage:items.mainImage productName:items.name productsalePrice:items.salePrice originalPrice:items.price isRebate:items.isRebate isDiscount:items.isDiscount onShelfAt:items.onShelfAt];
//        [array addObject:vd];
//    }
//    return array;
//}

@end
