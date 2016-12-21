//
//  LYCommonCollectionView.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYCommonCollectionView.h"
#import "LYCommonCollectionViewModel.h"
#import "LYShopProductCollectionViewCell.h"
static NSString *const  ShopProductCollectionViewCell = @"GMPShopProductCollectionViewCell";

@interface LYCommonCollectionView () <UICollectionViewDataSource>

@property (nonatomic, strong) LYCommonCollectionViewModel *viewModel;

@end

@implementation LYCommonCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if(self){
        if(!_viewModel){
            _viewModel = [[LYCommonCollectionViewModel alloc]init];
            self.delegate = _viewModel;
            self.dataSource = self;
        }
        
        self.backgroundColor = [UIColor colorWithARGB:0xececec];
        
        [self registerClass:[LYShopProductCollectionViewCell class] forCellWithReuseIdentifier:ShopProductCollectionViewCell];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self){
        if(!_viewModel){
            _viewModel = [[LYCommonCollectionViewModel alloc]init];
            self.delegate = _viewModel;
            self.dataSource = self;
        }
        
        self.backgroundColor = [UIColor colorWithARGB:0xe4e4e4];
        
        [self registerClass:[LYShopProductCollectionViewCell class] forCellWithReuseIdentifier:ShopProductCollectionViewCell];
    }
    return self;
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYShopProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopProductCollectionViewCell forIndexPath:indexPath];
    [cell bindData:[self.viewModel.dataSource objectAtIndex:indexPath.item]];
    return cell;
}
@end
