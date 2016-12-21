//
//  LYShopDetailUserCase.h
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LYShopDetailInfo : NSObject

@property (nonatomic,strong) NSString *bgImage;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,assign) NSInteger fansCount;
@property (nonatomic,assign) BOOL isConcern;

+ (instancetype)testInfo;

@end

#pragma mark -
#pragma mark - LYShopDetailUserCase

@interface LYShopDetailUserCase : NSObject

- (void)shopInfoRequestWithShopId:(long)shopId
                          Success:(void(^)(LYShopDetailInfo *))successBlock
                             fail:(void(^)(NSString *errorMsg))failBlock;

- (void)shopProductInfoRequestWithShopId:(long)shopId
                            type:(NSInteger)type
                          Success:(void(^)(NSArray *))successBlock
                             fail:(void(^)(NSString *errorMsg))failBlock;
@end
