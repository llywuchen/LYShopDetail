//
//  LYShopProductCollectionCellViewModel.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopProductCollectionCellViewModel.h"

@implementation LYShopProductCollectionCellViewData
- (instancetype)initWithProductID:(long)id shopID:(long)shopId productMainImage:(NSString *)mainImage productName:(NSString *)name productsalePrice:(NSInteger)salePrice originalPrice:(NSInteger)originalPrice isRebate:(BOOL)isRebate isDiscount:(BOOL)isDiscount onShelfAt:(long long)onShelfAt
{
    self = [super init];
    if(self){
        _id = id;
        _shopId = shopId;
        _mainImage = mainImage;
        _name = name;
        _salePrice = salePrice;
        _originalPrice = originalPrice;
        _isRebate = isRebate;
        _isDiscount = isDiscount;
        _onShelfAt = onShelfAt/1000;
    }
    return  self;
}
+ (instancetype)testInfo{
    NSInteger price = (arc4random()+100000000)%100000;
    NSInteger originalPrice = (arc4random()+100000000)%100000;
    NSInteger index = (arc4random()+100)%100;
    LYShopProductCollectionCellViewData *data = [[LYShopProductCollectionCellViewData alloc]initWithProductID:0 shopID:0 productMainImage:@"product-icon" productName:[NSString stringWithFormat:@"超强人工智能机器人%ld代III",index] productsalePrice:price originalPrice:originalPrice isRebate:YES isDiscount:YES onShelfAt:5435345345345];
    return data;
}
@end


@interface LYShopProductCollectionCellViewModel ()

@end
@implementation LYShopProductCollectionCellViewModel

- (instancetype)init{
    self = [super init];
    if(self){
        _viewData = [[LYShopProductCollectionCellViewData alloc]init];
    }
    return self;
}
- (void)bindViewData:(id)data{
    _viewData = data;
}

@end
