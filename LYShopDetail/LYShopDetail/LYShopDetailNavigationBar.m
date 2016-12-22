//
//  LYShopDetailNavigationBar.m
//  LYShopDetail
//
//  Created by lly on 2016/12/22.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailNavigationBar.h"

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
    self.backgroundColor = [UIColor lightTextColor];
    _backBtn = [[UIButton alloc]init];
    [_backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"nav_backGrayH"] forState:UIControlStateHighlighted];
    [self setButtonImageInsets:_backBtn];
    [self addSubview:_backBtn];
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBtn setBackgroundImage:[UIImage imageNamed:@"side_sort_searchBack"] forState:UIControlStateNormal];
    [_searchBtn setBackgroundImage:[UIImage imageNamed:@"side_sort_searchBack"] forState:UIControlStateHighlighted];
    [_searchBtn setImage:[UIImage imageNamed:@"gomeplus_search_scale"] forState:UIControlStateNormal];
    _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_searchBtn setTitle:@"搜索店铺内商品" forState:UIControlStateNormal];
    [_searchBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_searchBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
    [_searchBtn setTitleColor:[UIColor colorWithRGB:0x666666 alpha:1.0] forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_searchBtn];
    
    _categoryBtn = [[UIButton alloc]init];
    [_categoryBtn setImage:[UIImage imageNamed:@"button_bg_categoryNormal"] forState:UIControlStateNormal];
    [_categoryBtn setImage:[UIImage imageNamed:@"life_sortGrayH"] forState:UIControlStateHighlighted];
    _categoryBtn.enabled = NO;
    [self setButtonImageInsets:_categoryBtn];
    [self addSubview:_categoryBtn];
    
    _moreBtn = [[UIButton alloc]init];
    [_moreBtn setImage:[UIImage imageNamed:@"button_bg_more"] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"im_message_grayH"] forState:UIControlStateHighlighted];
    [self setButtonImageInsets:_moreBtn];
    [self addSubview:_moreBtn];
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
}

@end
