//
//  LYShopDetailCollectionViewModel.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailCollectionViewModel.h"

@implementation LYShopDetailCollectionViewModel
- (instancetype)init{
    self = [super init];
    if(self){
        _dataSource = [NSMutableArray array];
    }
    return self;
}


#pragma mark -
#pragma mark ---action
- (void)refreshWithTag:(NSInteger)tag{
    self.dataSource = nil;
//    PUBLISH([[GMShopDetailRefreshEvent alloc]initWithTabIndex:tag subTabIndex:0]);
}

@end
