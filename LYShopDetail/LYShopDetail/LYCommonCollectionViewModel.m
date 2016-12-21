//
//  LYCommonCollectionViewModel.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYCommonCollectionViewModel.h"
static NSString *const  ShopProductCollectionViewCell = @"LYShopProductCollectionViewCell";

@implementation LYCommonCollectionViewModel

- (instancetype)init{
    self = [super init];
    if(self){

    }
    return self;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellW = (kScreenWidth-1)/2;
    CGFloat cellH = 270*(cellW/187);
    return CGSizeMake(cellW , cellH);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}
#pragma mark ---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"进入到商品详情页");
}

@end
