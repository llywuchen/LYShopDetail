//
//  LYShopDetailUserCase.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailUserCase.h"
#import "LYShopProductCollectionCellViewModel.h"

@implementation LYShopDetailInfo

+ (instancetype)testInfo{
    LYShopDetailInfo *info = [[LYShopDetailInfo alloc]init];
    info.bgImage = @"";
    info.icon = @"";
    info.name = @"路无尘超级旗舰店";
    info.level = 1000;
    info.fansCount = 1000;
    info.isConcern = false;
    return info;
}
@end

#pragma mark -
#pragma mark - LYShopDetailUserCase
@implementation LYShopDetailUserCase

- (void)shopInfoRequestWithShopId:(long)shopId
                          Success:(void(^)(LYShopDetailInfo *))successBlock
                             fail:(void(^)(NSString *errorMsg))failBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        LYShopDetailInfo *info = [LYShopDetailInfo testInfo];
        successBlock(info);
    });
}

- (void)shopProductInfoRequestWithShopId:(long)shopId
                                    type:(NSInteger)type
                                 Success:(void(^)(NSArray *))successBlock
                                    fail:(void(^)(NSString *errorMsg))failBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *array = [NSMutableArray arrayWithObject:[LYShopProductCollectionCellViewData testInfo]];
        for(int i=0;i<35;i++){
            [array addObject:[LYShopProductCollectionCellViewData testInfo]];
        }
        successBlock(array);
    });
}

@end
