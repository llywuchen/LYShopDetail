//
//  LYCommonCollectionViewModel.h
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYCommonCollectionViewModel : NSObject <UICollectionViewDelegate>

/**dataSource*/
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
