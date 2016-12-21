//
//  LYShopDetailTabScrollView.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailTabScrollView.h"
#import "LYShopDetailScrollView.h"
#import "LYShopDetailTabScrollViewModel.h"
#import "LYShopDetailCollectionView.h"
#import <LYSelectBar/LYSelectTabBar.h>

@interface LYShopDetailTabScrollView ()<LYSelectTabBarDelegate>

@property (nonatomic,strong) LYSelectTabBar *tabBar;
@property (nonatomic,strong) LYShopDetailScrollView *scrollView;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,copy) void (^translationBlock)(CGFloat offset,BOOL isScrollTop);

@property (nonatomic,strong) LYShopDetailTabScrollViewModel *viewModel;

@end

@implementation LYShopDetailTabScrollView

- (instancetype)initWithShopId:(long)shopId{
    
    self = [super init];
    if(self){
        self.viewModel = [[LYShopDetailTabScrollViewModel alloc]init];
        NSMutableArray *subViews = [NSMutableArray array];
        
        NSInteger count = [self.viewModel tabBarTitleArray].count;
        @weakify(self)
        for(NSInteger i=0;i<count;i++){
            LYShopDetailCollectionView *view = [[LYShopDetailCollectionView alloc]initWithLoadMoreBlock:^{
                @strongify(self)
                [self.viewModel loadDataRequestAtIndex:i isLoadMore:true];
            }];
            [subViews addObject:view];
        }
        
        [self configureTabBar];
        
        _scrollView = [[LYShopDetailScrollView alloc]initWithSubViews:subViews];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * count, kScreenHeight - 120 - 80 - 64 - 40 -40);
        _scrollView.bounces = NO;
//        _scrollView.backgroundColor = GM_JS_ORDER_COLOR_BG;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        [self configureSubContraints];
        [self bindViewModel];
    }
    
    return self;
}


- (void)configureSubContraints{
    [_tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tabBar.mas_bottom);
        make.left.width.bottom.equalTo(self);
    }];
    
}

- (void)configureTabBar{
//    _tabBar = [[LYSelectTabBar alloc]initGMBTabBarWithDelegate:self Titles:[_viewModel tabBarTitleArray] selectedColor:[UIColor colorWithARGB:0xf66a6b] titleFont:[UIFont systemFontOfSize:12] animate:false indicatorImage:nil];
    _tabBar = [[LYSelectTabBar alloc]initTitles:[_viewModel tabBarTitleArray] images:nil selectImages:nil indicatorImage:nil];
    _tabBar.indicatorHeight = 0;
    _tabBar.backgroundColor = [UIColor colorWithRGB:0xffffff];
    [self addSubview:_tabBar];
    
//    NSArray *images = [self.viewModel tabBarTitleImageArray];
//    NSArray *selImages = [self.viewModel tabBarTitleSelImageArray];
//    if(images.count&&selImages.count){
//        for(int i=0;i<images.count;i++){
//            NSString *imageStr = images[i];
//            if(imageStr.length>0&&selImages.count>i){
//                NSString *selImageStr = selImages[i];
//                [_tabBar setTabButtonImage:imageStr selImageStr:selImageStr atIndex:i imageWidth:30];
//            }
//        }
//    }
}

- (void)bindViewModel{
    @weakify(self)
    [RACObserve(self.viewModel, allCommonDataSource) subscribeNext:^(id x) {
        @strongify(self)
        [self bindData:x atIndex:0];
    }];
    [RACObserve(self.viewModel, allSalesDataSource) subscribeNext:^(id x) {
        @strongify(self)
        [self bindData:x atIndex:1];
    }];
    [RACObserve(self.viewModel, allPriceDataSource) subscribeNext:^(id x) {
        @strongify(self)
        [self bindData:x atIndex:2];
    }];
    [RACObserve(self.viewModel, allNewDataSource) subscribeNext:^(id x) {
        @strongify(self)
        [self bindData:x atIndex:3];
    }];
    
//    [RACObserve(self.viewModel, toastMessage) subscribeNext:^(id x) {
//        @strongify(self)
//        NSString *text = x;
//        if(text.length==0) return;
//        [self showGMToastToWindow:x];
//        [self.scrollView showNoNetWorkDefaultView];
//    }];
    
}

#pragma mark --- getter and setter
- (void)setTranslationBlock:(void (^)(CGFloat,BOOL))translationBlock{
    _translationBlock = translationBlock;
    for(UIView *view in self.scrollView.subViews){
        [view setValue:_translationBlock forKey:@"translationBlock"];
    }
}
- (UIButton *)scrollToTopBtn{
    return nil;
}

- (LYShopDetailCollectionView *)currentCollectionView{
    return (LYShopDetailCollectionView *)self.scrollView.subViews[_currentIndex];
}


#pragma mark --- bind data-----
- (void)bindData:(id)data atIndex:(NSInteger)index{
    LYShopDetailCollectionView *view = (LYShopDetailCollectionView *)[self.scrollView subScorllViewAtIndex:index];
    [view setTotalPage:[self.viewModel getTotalPageAtIndex:index]];
    [view bindData:data];
}

- (void)reloadData{
    [self.currentCollectionView.collectionView reloadData];
}

- (void)loadDefaultData{
    if(_currentIndex==0){
        [self.viewModel loadDataRequestAtIndex:0 isLoadMore:false];
    }
}
#pragma mark ---- action

#pragma mark --- delegate
- (void)tabBar:(LYSelectTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to{
    if(from!=to){
        _currentIndex = to;
        [self.scrollView showSubView:to];
//        [self.tabBar setButtonTitleColorSelected:false index:from];
//        [self.tabBar setButtonTitleColorSelected:true index:to];
        [self.viewModel loadDataRequestAtIndex:_currentIndex isLoadMore:false];
    }
    else{
//        UIButton *selectedBtn = [tabBar buttonAtIndex:from];
//        [selectedBtn setSelected:!selectedBtn.isSelected];
//        [self.tabBar setButtonTitleColorSelected:true index:to];
//        [self butttonClick:selectedBtn.isSelected buttonIndex:selectedBtn.tag];
    }
}

- (void)butttonClick:(BOOL)isSelected buttonIndex:(NSInteger)index{
    NSLog(@"btn index:%ld,isSelected:%d",index,isSelected);
    if(index==2){
        self.viewModel.allPriceDataSource = nil;
        [self.viewModel loadDataRequestAtIndex:_currentIndex isLoadMore:false isOrder:isSelected];
    }
}

#pragma mark ---
-(void)footerEndRefreshing{
    
}

- (void)showNoNetWorkDefaultView{
    
}

- (void)setCouldScroll:(BOOL)scrollEnabled;{
    [self.scrollView setCouldScroll:scrollEnabled];
}

//- (void)setContentOffset:(CGFloat)offset{
//    for(LYShopDetailCollectionView *view in self.scrollView.subViews){
//        [view setContentOffset:offset];
//    }
//}

@end
