//
//  ViewController.m
//  LYShopDetail
//
//  Created by lly on 16/12/19.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailViewController.h"
#import "LYShopDetailHeaderView.h"
#import "LYShopDetailScrollView.h"
#import "LYShopDetailTabScrollView.h"
#import "LYShopDetailCollectionView.h"
#import "LYShopDetailNavigationBar.h"

#import "LYShopDetailViewModel.h"

#pragma mark -
#pragma mark ------------------GMPShopDetailBottomView-----------------------------------
@interface LYShopDetailBottomView : UIView

@property (nonatomic,strong) NSMutableArray *buttonArray;

@end

@implementation LYShopDetailBottomView
- (instancetype)initWithTitleArray:(NSArray *)titleArray{
    self = [super init];
    if(self){
        self.backgroundColor =[UIColor whiteColor];
        _buttonArray = [NSMutableArray array];
        for(int i=0;i<titleArray.count;i++){
            UIButton *btn = [[UIButton alloc]init];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.backgroundColor = [UIColor colorWithRGB:0xf9f9f9];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRGB:0x4c5053] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRGB:0x4c5053] forState:UIControlStateDisabled];
            btn.layer.borderWidth = 0.25;
            btn.layer.borderColor = [UIColor colorWithRGB:0xededed].CGColor;
            btn.tag = i;
            [self addSubview:btn];
            [_buttonArray addObject:btn];
        }
        
        [_buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [_buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self);
        }];
    }
    
    return self;
}

#pragma mark -
#pragma mark - action
- (void)addtarget:(id)target sel:(SEL)sel{
    for(UIButton *btn in _buttonArray){
        [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
}

@end

#pragma mark -
#pragma mark - ViewController
#define HeaderHeight 95
#define TabBarHeight 60
#define TabBarTopHeight 35
@interface LYShopDetailViewController () <LYSelectTabBarDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) LYShopDetailNavigationBar *navigationBar;
@property (nonatomic,strong) UIScrollView *mianScrollView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) LYShopDetailHeaderView *headerView;
@property (nonatomic,strong) LYSelectTabBar *selectBar;
@property (nonatomic,strong) LYShopDetailScrollView *scrollView;
@property (nonatomic,strong) LYShopDetailBottomView *bottomView;

@property (nonnull,strong) LYShopDetailViewModel *viewModel;

@end

@implementation LYShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[LYShopDetailViewModel alloc]init];
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.mianScrollView];
    _contentView = [[UIView alloc]init];
    [self.mianScrollView addSubview:_contentView];
    _headerView = [[LYShopDetailHeaderView alloc]init];
    [_contentView addSubview:_headerView];
    [_contentView addSubview:self.selectBar];
    [self configureScrollView];
    [self configureBottomView];
    
    [self configureContraints];
    [self bindViewModel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureScrollView{
    _scrollView = [[LYShopDetailScrollView alloc]initWithSubViews:@[
                  [[LYShopDetailCollectionView alloc]init],
                  [[LYShopDetailTabScrollView alloc]initWithShopId:0],
                  [[LYShopDetailCollectionView alloc]init],
                  [[LYShopDetailCollectionView alloc]init]]];
    [_contentView addSubview:self.scrollView];
    
    @weakify(self)
    [self.scrollView setTranslationBlock:^(CGFloat offset) {
        @strongify(self)
        CGFloat y = self.mianScrollView.contentOffset.y;
        if(offset>0){
            self.mianScrollView.contentOffset = CGPointMake(0, MIN((y+offset),(self.mianScrollView.contentSize.height-self.mianScrollView.frame.size.height)));
        }else if (offset<0){
            self.mianScrollView.contentOffset = CGPointMake(0, MAX((y+offset),0));
        }
        if(offset>0&&!self.scrollView.couldScroll&&y==0){
            self.scrollView.couldScroll = false;
        }else if (offset<0&&self.scrollView.couldScroll&&y>0){
            self.scrollView.couldScroll = false;
        }else if(y>=HeaderHeight+TabBarHeight-TabBarTopHeight){
            self.scrollView.couldScroll = true;
        }else if (y==0){
            self.scrollView.couldScroll = offset<=0?true:false;
        }
    }];
    [self.scrollView setTabBarSelBlock:^(NSInteger index) {
        @strongify(self)
        [self.selectBar setSelectedIndex:index];
        [self.viewModel showTabActionAtIndex:index];
    }];
}

- (void)configureBottomView{
    _bottomView = [[LYShopDetailBottomView alloc]initWithTitleArray:@[@"宝贝分类",@"领金币",@"联系卖家"]];
    [self.view addSubview:self.bottomView];
}

- (void)configureContraints{
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    
    [self.mianScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mianScrollView);
        make.width.equalTo(self.mianScrollView);
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_contentView);
        make.height.mas_equalTo(HeaderHeight);
    }];

    [self.selectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
        make.height.equalTo(@(TabBarHeight));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_contentView);
        make.top.equalTo(self.selectBar.mas_bottom).offset(0);
        make.height.equalTo(@(kScreenHeight-64 -TabBarTopHeight -49));
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView.mas_bottom);
    }];
}

- (void)bindViewModel{
    @weakify(self)
    [RACObserve(self.viewModel,shopInfo) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        LYShopDetailInfo *info = x;
        [self.headerView bindData:info.bgImage icon:info.icon name:info.name level:info.level fansCount:info.fansCount isConcern:info.isConcern];
    }];
    [[RACObserve(self.viewModel, homeDataSource) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable x) {
        LYShopDetailCollectionView *view = (LYShopDetailCollectionView *)[self.scrollView subScorllViewAtIndex:0];
        [view bindData:x];
        [view setTotalPage:self.viewModel.homeTotalPage];
    }];
    [[RACObserve(self.viewModel, newsDataSource) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable x) {
        LYShopDetailCollectionView *view = (LYShopDetailCollectionView *)[self.scrollView subScorllViewAtIndex:2];
        [view bindData:x];
        [view setTotalPage:self.viewModel.newTotalPage];
    }];
    [[RACObserve(self.viewModel, dymicDataSource) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable x) {
        LYShopDetailCollectionView *view = (LYShopDetailCollectionView *)[self.scrollView subScorllViewAtIndex:3];
        [view bindData:x];
        [view setTotalPage:self.viewModel.dymicTotalPage];
    }];
}
#pragma mark -
#pragma mark - getter and setter
- (LYShopDetailNavigationBar *)navigationBar{
    if(!_navigationBar){
        _navigationBar = [[LYShopDetailNavigationBar alloc]init];
    }
    return _navigationBar;
}

- (LYSelectTabBar *)selectBar{
    if(!_selectBar){
        _selectBar = [[LYSelectTabBar alloc]initTitles:self.viewModel.tabBarTitleArray images:self.viewModel.tabBarTitleImageArray selectImages:self.viewModel.tabBarTitleSelImageArray indicatorImage:nil];
        _selectBar.delegate = self;
        _selectBar.selectedColor = [UIColor colorWithRGB:0xf74600];
        _selectBar.unSelectedColor = [UIColor blackColor];
        _selectBar.font = [UIFont systemFontOfSize:10];
    }
    
    return _selectBar;
}

- (UIScrollView *)mianScrollView{
    if(!_mianScrollView){
        _mianScrollView = [[UIScrollView alloc]init];
        _mianScrollView.delegate = self;
        _mianScrollView.showsVerticalScrollIndicator = NO;
        _mianScrollView.scrollEnabled = false;
        _mianScrollView.bounces = NO;
    }
    return _mianScrollView;
}
#pragma mark -
#pragma mark ---- UISCrolloView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if(y<=(HeaderHeight+TabBarHeight-TabBarTopHeight)&&y>=HeaderHeight){
        y = -(y-HeaderHeight)/((TabBarHeight-TabBarTopHeight)/10);
        [self.selectBar setButtonImageAlpha:1 - ABS(y)/10];
        [self.selectBar setTitleFontSize:10+ABS(y)/3];
    }else{
        [self.selectBar setButtonImageAlpha:1];
        [self.selectBar setTitleFontSize:10];
    }
}

#pragma mark -
#pragma mark - delegate
- (void)tabBar:(LYSelectTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to toAssistStatus:(LYTabBatAssistStatus)status{
    NSLog(@"didSelectButtonFrom %ld to %ld",from,to);
    if(from==to) return;
    [self.scrollView showSubView:to];
    [self.viewModel showTabActionAtIndex:to];
}

@end
