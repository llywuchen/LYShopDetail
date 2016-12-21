//
//  LYShopDetailCollectionViewModel.h
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYShopDetailCollectionViewModel : NSObject

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) int pageNum;

- (void)refreshWithTag:(NSInteger)tag;

@end
