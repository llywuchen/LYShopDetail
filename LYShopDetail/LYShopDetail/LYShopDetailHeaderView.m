//
//  LYShopDetailHeaderView.m
//  LYShopDetail
//
//  Created by lly on 2016/12/20.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopDetailHeaderView.h"
#pragma mark -
#pragma mark - LYShopDetailHeaderIcon
@interface LYShopDetailHeaderIcon : UIImageView

@property (nonatomic,strong) UIImageView *statusImageView;

@end

@implementation LYShopDetailHeaderIcon

- (instancetype)init{
    self = [super init];
    if(self){
        _statusImageView = [[UIImageView alloc]init];
        _statusImageView.image = [UIImage imageNamed:@""];
        [self addSubview:_statusImageView];
        
        [_statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self).offset(-3);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        self.backgroundColor = [UIColor lightTextColor];
    }
    return self;
}

@end

#pragma mark -
#pragma mark - LYShopDetailLevel
#define levelImageWidth 12
#define levelImageMargin 2.5
@interface LYShopDetailLevel : UIView

- (void)setLevel:(NSInteger)level;
@property (nonatomic,strong) NSMutableArray *imageViewArray;

@end

@implementation LYShopDetailLevel

- (NSMutableArray *)imageViewArray{
    if(!_imageViewArray){
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (void)setLevel:(NSInteger)level{
    NSInteger levelStatus = (level-1)/4;
    NSInteger levelCount =(level<=0)?0:(level-levelStatus*4);
    NSString *imageString = nil;
    if(levelStatus ==0){
        imageString = @"bronzeMedalIcon";
    }else if (levelStatus ==1){
        imageString = @"silverMedalIcon";
    }else{
        imageString = @"level";
    }
    for(UIImageView *imageView in self.imageViewArray){
        [imageView removeFromSuperview];
    }
    [self.imageViewArray removeAllObjects];
    
    for(int i=0;i<levelCount;i++){
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageString]];
        [self.imageViewArray addObject:imageView];
        [self addSubview:imageView];
    }
    
    [self configureContraints];
    [self setNeedsLayout];
}

- (void)configureContraints{
    for(int i=0;i<self.imageViewArray.count;i++){
        UIImageView *imageView = self.imageViewArray[i];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(levelImageWidth);
            make.width.mas_equalTo(levelImageWidth);
            make.top.equalTo(self);
            make.left.equalTo(self).offset(i*(levelImageMargin+levelImageWidth));
        }];
    }
}

@end

#pragma mark -
#pragma mark - LYShopDetailHeaderView
@interface LYShopDetailHeaderView ()

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) LYShopDetailHeaderIcon *headerIcon;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) LYShopDetailLevel *levelView;
@property (nonatomic,strong) UILabel *fansLabel;
@property (nonatomic,strong) UIButton *concernBtn;


@end

@implementation LYShopDetailHeaderView

- (instancetype)init{
    self = [super init];
    if(self){
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"head-bg"];
        [self addSubview:_bgImageView];
        
        _headerIcon = [[LYShopDetailHeaderIcon alloc]init];
        _headerIcon.backgroundColor = [UIColor clearColor];
        _headerIcon.image = [UIImage imageNamed:@""];
        [self addSubview:_headerIcon];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:_nameLabel];
        
        _levelView = [[LYShopDetailLevel alloc]init];
        [self addSubview:_levelView];
        
        _fansLabel = [[UILabel alloc]init];
        _fansLabel.font = [UIFont systemFontOfSize:13];
        _fansLabel.textColor = [UIColor whiteColor];
        
        _fansLabel.attributedText = [self fansLabelAttributeText:0];
        _fansLabel.textAlignment = NSTextAlignmentCenter;
        _fansLabel.numberOfLines = 0;
        [self addSubview:_fansLabel];
        
        _concernBtn = [[UIButton alloc]init];
        [_concernBtn setImage:[UIImage imageNamed:@"concern-bg"] forState:UIControlStateNormal];
        [_concernBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_concernBtn setTitle:@"已关注" forState:UIControlStateSelected];
        _concernBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _concernBtn.titleLabel.textColor = [UIColor whiteColor];
        _concernBtn.backgroundColor = [UIColor colorWithRGB:0xff5001];
        _concernBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 6, 5, 33);
        _concernBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        _concernBtn.layer.cornerRadius = 3;
        [self addSubview:_concernBtn];
        
        [self configureContraints];
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    return self;
}

- (void)configureContraints{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50,50));
    }];
    
    [self.concernBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(55, 25));
    }];
    
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.concernBtn);
        make.right.equalTo(self.concernBtn.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(60, 50));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerIcon.mas_right).offset(12);
        make.right.equalTo(self.fansLabel.mas_left).offset(5);
        make.top.equalTo(self.headerIcon);
        make.height.equalTo(self.headerIcon).dividedBy(2);
    }];
    
    [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(3);
        make.height.equalTo(@20);
    }];
}

- (NSAttributedString *)fansLabelAttributeText:(NSInteger)fansCount{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld\n粉丝数",fansCount]];
    [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0] range:NSMakeRange(attriString.length-3, 3)];
    return attriString;
}

- (void)bindData:(NSString *)bg icon:(NSString *)icon name:(NSString *)name level:(NSInteger)level fansCount:(NSInteger)fansCount isConcern:(BOOL)isConcern{
    _bgImageView.image = [UIImage imageNamed:bg];
    _headerIcon.image = [UIImage imageNamed:icon];
    _nameLabel.text = name;
    [self.levelView setLevel:level];
    _fansLabel.attributedText = [self fansLabelAttributeText:fansCount];
    [_concernBtn setSelected:isConcern];
}
@end
