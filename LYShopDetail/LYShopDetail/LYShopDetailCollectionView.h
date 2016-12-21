//
//  LYShopDetailCollectionView.h
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYCommonCollectionView.h"

@interface LYShopDetailCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) LYCommonCollectionView *collectionView;
@property (nonatomic,assign) BOOL couldScroll;
@property (nonatomic,copy) void (^translationBlock)(CGFloat offset);

//@property (nonatomic,strong,readonly) __kindof GMShopDetailCollectionViewModel *viewModel;
/**
 加载更多
 */
- (instancetype)initWithLoadMoreBlock:(void(^)()) loadMoreBlock;
//- (instancetype)initWithFrame:(CGRect)frame viewModel:(GMShopDetailCollectionViewModel *)viewModel;
/**
 根据类型去判断当前页面需要的viewModel
 */
//- (Class)viewModelClass;
/**
 绑定数据
 */
- (void)bindData:(id)data;
/**
 设置页数和总页数
 */
- (void)setTotalPage:(NSInteger)totalPage;
/**
 设置默认缺省页
 */
- (void)showNoNetWorkDefaultView;
/**
 设置CollectionView的HeaderView的高度
 */
- (CGFloat)collectionHeaderHeight;
- (void)setContentOffset:(CGFloat)offset;

@end
