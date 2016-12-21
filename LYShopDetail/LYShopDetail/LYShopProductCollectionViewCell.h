//
//  LYShopProductCollectionViewCell.h
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYShopProductCollectionCellViewModel.h"

@interface LYShopProductCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong,readonly) LYShopProductCollectionCellViewModel *viewModel;
- (void)bindData:(id)data;

@end
