//
//  LYShopProductCollectionViewCell.m
//  LYShopDetail
//
//  Created by lly on 2016/12/21.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYShopProductCollectionViewCell.h"
#import "LYShopProductCollectionCellViewModel.h"

@interface LYShopProductCollectionViewCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *fanIcon;      //返利标识
@property (nonatomic,strong) UIImageView *iconImgView;  //商品主图
@property (nonatomic,strong) UILabel *descLabel;        //商品描述
@property (nonatomic,strong) UILabel *salePriceLabel;        //售价
@property (nonatomic,strong) UILabel *originalPriceLabel;    //原价

@end

@implementation LYShopProductCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        if(!_viewModel){
            _viewModel = [[LYShopProductCollectionCellViewModel alloc]init];
        }
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
        [self configureConstrains];
    }
    return self;
}

- (void)setupViews{
    _bgView = [[UIView alloc] init];
    [self addSubview:_bgView];
    
    _iconImgView = [[UIImageView alloc]init];
    [_iconImgView setContentMode:UIViewContentModeScaleAspectFill];
    _iconImgView.clipsToBounds = YES;
    [_bgView addSubview:_iconImgView];
    
    _fanIcon = [[UIImageView alloc]init];
    _fanIcon.image = [UIImage imageNamed:@"can_rebate"];
    _fanIcon.clipsToBounds = YES;
    [_bgView addSubview:_fanIcon];
    
    _descLabel = [[UILabel alloc]init];
    _descLabel.numberOfLines = 2;
    _descLabel.font = [UIFont systemFontOfSize:15];
    _descLabel.textColor = [UIColor colorWithARGB:0x333333];
    [_bgView addSubview:_descLabel];
    
    _salePriceLabel = [[UILabel alloc]init];
    _salePriceLabel.font = [UIFont systemFontOfSize:14];
    _salePriceLabel.textColor = [UIColor colorWithARGB:0xed5b5d];
    [_bgView addSubview:_salePriceLabel];
    
    _originalPriceLabel = [[UILabel alloc]init];
    _originalPriceLabel.font = [UIFont systemFontOfSize:12];
    _originalPriceLabel.textColor = [UIColor colorWithARGB:0x999999];
    [_bgView addSubview:_originalPriceLabel];
    
}

- (void)configureConstrains{
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(5, 5, 0, 5));
    }];
    CGFloat cellW = self.frame.size.width-10;
    [_iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView);
        make.top.equalTo(_bgView);
        make.size.mas_equalTo(CGSizeMake(cellW, cellW));
    }];
    [_fanIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(_iconImgView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [_descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView).offset(8);
        make.top.equalTo(_iconImgView.mas_bottom).offset(12);
        make.right.equalTo(_bgView).offset(-8);
    }];
    [_salePriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_descLabel.mas_left);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(_bgView).offset(-10);
    }];
    [_originalPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_salePriceLabel.mas_right).offset(10);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(_salePriceLabel.mas_bottom);
    }];
}


- (void)bindData:(id)data{
    [_viewModel bindViewData:data];
    self.iconImgView.image = [UIImage imageNamed:self.viewModel.viewData.mainImage];
    self.descLabel.text = self.viewModel.viewData.name;
    self.salePriceLabel.text = [NSString stringWithFormat:@"¥%.2f",(float)(self.viewModel.viewData.salePrice/100.00)];
    
    float tempPriuce = (float)(self.viewModel.viewData.originalPrice/100.00);
    NSString *originalPrice = [NSString stringWithFormat:@"¥%.2f",tempPriuce];
    NSAttributedString *originalPriceString = [[NSAttributedString alloc] initWithString:originalPrice attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle),NSStrokeColorAttributeName:[UIColor colorWithARGB:0x999999]}];
    self.originalPriceLabel.attributedText = originalPriceString;
}
@end
