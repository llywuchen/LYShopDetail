//
//  LYShopDetailNavigationBar.m
//  LYShopDetail
//
//  Created by lly on 2016/12/22.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailNavigationBar.h"

@interface LYShopDetailNavigationBar ()

@property (nonatomic,strong) UIView *line;

@end

@implementation LYShopDetailNavigationBar

- (instancetype)init{
    self = [super init];
    if(self){
        [self configureUI];
        [self configureContraints];
    }
    return self;
}

- (void)configureUI{
    self.backgroundColor = [UIColor colorWithRGB:0xf9f9f9];
    _backBtn = [[UIButton alloc]init];
    [_backBtn setImage:[UIImage imageNamed:@"nav-back"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"nav-back"] forState:UIControlStateHighlighted];
    _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    [self setButtonImageInsets:_backBtn];
    [self addSubview:_backBtn];
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [[UIImage imageNamed:@"nav-search-bg"] stretchableImageWithLeftCapWidth:3 topCapHeight:0];
    [_searchBtn setBackgroundImage:image forState:UIControlStateNormal];
    [_searchBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    [_searchBtn setImage:[UIImage imageNamed:@"nav-search"] forState:UIControlStateNormal];
    _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_searchBtn setTitle:@"搜索店铺内商品" forState:UIControlStateNormal];
    [_searchBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 0)];
    [_searchBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 17, 0, 0)];
    [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_searchBtn];
    
    _categoryBtn = [[UIButton alloc]init];
    [_categoryBtn setImage:[UIImage imageNamed:@"nav-catergary"] forState:UIControlStateNormal];
    [_categoryBtn setImage:[UIImage imageNamed:@"nav-catergary"] forState:UIControlStateHighlighted];
//    _categoryBtn.enabled = NO;
    [self setButtonImageInsets:_categoryBtn];
    [self addSubview:_categoryBtn];
    
    _moreBtn = [[UIButton alloc]init];
    [_moreBtn setImage:[UIImage imageNamed:@"nav-more"] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"nav-more"] forState:UIControlStateHighlighted];
    [self setButtonImageInsets:_moreBtn];
    [self addSubview:_moreBtn];
    
    _line = [[UIView alloc]init];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line];
}

- (void)setButtonImageInsets:(UIButton *)button{
    button.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
}

- (void)configureContraints{
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.size.bottom.equalTo(_backBtn);
    }];
    
    [_categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.equalTo(_backBtn);
        make.right.equalTo(_moreBtn.mas_left).offset(2);
        
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backBtn.mas_right).offset(5);
        make.right.equalTo(_categoryBtn.mas_left).offset(1);
        make.top.height.equalTo(_backBtn);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

@end
