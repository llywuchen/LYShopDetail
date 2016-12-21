//
//  LYShopDetailScrollView.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailScrollView.h"
#import "LYShopDetailCollectionView.h"

@interface LYShopDetailScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray<UIView *> *subViews;
@property (nonatomic,assign) NSInteger currentShowIndex;

@end

@implementation LYShopDetailScrollView

- (instancetype)initWithSubViews:(NSArray *)subViews{
    self = [super init];
    if(self){
        _subViews = subViews;
        for(int i = 0;i<_subViews.count;i++){
            UIView *view = _subViews[i];
            view.tag = i;
            [self addSubview:view];
        }
        _canSwip = false;
        self.delegate = self;
        self.scrollEnabled = false;
        [self configureContraints];
    }
    return self;
}

- (void)configureContraints{
    for(int i=0;i<_subViews.count;i++){
        UIView *view = _subViews[i];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self);
            make.width.mas_equalTo(kScreenWidth);
            make.left.mas_equalTo(kScreenWidth*i);
        }];
    }
    
}


- (void)showSubView:(NSInteger)index{
    //主动切换
    _currentShowIndex = index;
    //todo
    CGPoint originOffset = self.contentOffset;
    self.contentOffset = CGPointMake(kScreenWidth*index, originOffset.y);
}


#pragma mark --- getter and setter
- (void)setCouldScroll:(BOOL)scrollEnabled;{
    _couldScroll = scrollEnabled;
    for(LYShopDetailCollectionView *view in self.subViews){
        view.couldScroll = scrollEnabled;
    }
}
- (void)setTranslationBlock:(void (^)(CGFloat))translationBlock{
    _translationBlock = translationBlock;
    for(UIView *view in _subViews){
        [view setValue:_translationBlock forKey:@"translationBlock"];
    }
    
}
- (void)setCanSwip:(BOOL)canSwip{
    _canSwip = canSwip;
    self.scrollEnabled = _canSwip;
}

- (UIScrollView *)currentSubScorllView{
    return (UIScrollView *)self.subViews[_currentShowIndex];
}

- (UIScrollView *)subScorllViewAtIndex:(NSInteger)index{
    return (UIScrollView *)self.subViews[index];
}

- (void)showNoNetWorkDefaultView{
    [(LYShopDetailCollectionView *)self.currentSubScorllView showNoNetWorkDefaultView];
}

#pragma mark --
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //判断tab切换
    int index = scrollView.contentOffset.x/kScreenWidth;
    if(_currentShowIndex!=index){
        _currentShowIndex = index;
        if(_tabBarSelBlock){
            _tabBarSelBlock(_currentShowIndex);
        }
        
    }
}

@end
