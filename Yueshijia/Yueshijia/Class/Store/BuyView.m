//
//  BuyView.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/4.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "BuyView.h"
#import "UIImageView+WebCache.h"

@interface BuyView()

@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UIView *goodsView;
@property (nonatomic, weak) UILabel *goodsNameLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *origLabel;
@property (nonatomic, weak) UILabel *aLabel;
@property (nonatomic, weak) UILabel *numLabel;
@property (nonatomic, weak) UIButton *minusBtn;
@property (nonatomic, weak) UIButton *plusBtn;
@property (nonatomic, weak) UIButton *doneBtn;

@property (nonatomic, assign) NSInteger num;

@end

@implementation BuyView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.num = 1;
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    UIView *coverView = [[UIView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverView)];
    [coverView addGestureRecognizer:tap];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.3;
    self.coverView = coverView;
    [self addSubview:coverView];
    
    UIView *goodsView = [[UIView alloc] init];
    goodsView.backgroundColor = [UIColor whiteColor];
    self.goodsView = goodsView;
    [self addSubview:goodsView];
    
    UIImageView *picImageView = [[UIImageView alloc] init];
   
    self.picImageView = picImageView;
    [goodsView addSubview:picImageView];
    
    UILabel *goodsNameLabel = [[UILabel alloc] init];
    self.goodsNameLabel = goodsNameLabel;
    [goodsView addSubview:goodsNameLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor redColor];
    self.priceLabel = priceLabel;
    [goodsView addSubview:priceLabel];
    
    UILabel *origLabel = [[UILabel alloc] init];
    origLabel.textColor = [UIColor lightGrayColor];
    origLabel.font = [UIFont systemFontOfSize:13.0];
    self.origLabel = origLabel;
    [goodsView addSubview:origLabel];
    
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.text = @"数量:";
    self.aLabel = aLabel;
    [goodsView addSubview:aLabel];
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.text = @"1";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = [UIColor lightGrayColor];
    numLabel.layer.borderColor = ThemeColor.CGColor;
    numLabel.layer.borderWidth = 0.5;
    self.numLabel = numLabel;
    [goodsView addSubview:numLabel];
    
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [minusBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [minusBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    minusBtn.layer.borderColor = ThemeColor.CGColor;
    minusBtn.layer.borderWidth = 0.5;
    [minusBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [goodsView addSubview:minusBtn];
    
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn setTitle:@"+" forState:UIControlStateNormal];
    [plusBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [plusBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    plusBtn.layer.borderColor = ThemeColor.CGColor;
    plusBtn.layer.borderWidth = 0.5;
    [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [goodsView addSubview:plusBtn];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.backgroundColor = ThemeColor;
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [goodsView addSubview:doneBtn];
    
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        
    }];
    
    [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(coverView.mas_bottom);
        make.left.mas_equalTo(coverView.mas_left);
        make.right.mas_equalTo(coverView.mas_right);
        make.height.mas_equalTo(self.height * 0.4);
    }];
    
    [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(goodsView.mas_top).offset(-20);
        make.left.mas_equalTo(goodsView.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth*0.3, ScreenWidth*0.3));
    }];
    
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(goodsView.mas_top).offset(20);
        make.left.mas_equalTo(picImageView.mas_right).offset(20);
        make.right.mas_equalTo(goodsView.mas_right).offset(-20);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(picImageView.mas_bottom).offset(-10);
        make.left.mas_equalTo(goodsNameLabel);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    [origLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(priceLabel.mas_bottom);
        make.left.mas_equalTo(priceLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    [aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(picImageView.mas_bottom).offset(30);
        make.left.mas_equalTo(picImageView.mas_left);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(aLabel.mas_left);
        make.top.mas_equalTo(aLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(minusBtn.mas_top);
        make.left.mas_equalTo(minusBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(minusBtn.mas_top);
        make.left.mas_equalTo(numLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(goodsView.mas_bottom);
        make.left.mas_equalTo(goodsView.mas_left);
        make.right.mas_equalTo(goodsView.mas_right);
        make.height.mas_equalTo(@44);
    }];
    
}

- (void)minusBtnClick
{
    NSLog(@"----minusBtnClick");
    if (self.num <= 1) {
        self.numLabel.text = @"1";
        self.minusBtn.selected = NO;
    } else {
        
        self.numLabel.text = [NSString stringWithFormat:@"%ld",--self.num];
    }
}

- (void)plusBtnClick
{
    NSLog(@"----plusBtnClick");
    self.numLabel.text = [NSString stringWithFormat:@"%ld",++self.num];
}

- (void)doneBtnClick
{
    
    NSLog(@"----doneBtnClick");
    if ([self.delegate respondsToSelector:@selector(doneButtonClick:)]) {
        [self.delegate doneButtonClick:self.num];
    }
}

- (void)tapCoverView
{
    if ([self.delegate respondsToSelector:@selector(closeView)]) {
        [self.delegate closeView];
    }
}

- (void)setGoodsPicName:(NSString *)goodsPicName
{
    _goodsPicName = goodsPicName;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:goodsPicName]];
}

- (void)setGoodsName:(NSString *)goodsName{
    _goodsName = goodsName;
    self.goodsNameLabel.text = goodsName;
}

- (void)setGoodsPrice:(NSString *)goodsPrice
{
    _goodsPrice = goodsPrice;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",goodsPrice];
}

- (void)setGoodsOrigPrice:(NSString *)goodsOrigPrice
{
    _goodsOrigPrice = goodsOrigPrice;
    NSString *origPricetext = [NSString stringWithFormat:@"￥%@",self.goodsOrigPrice];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc] initWithString:origPricetext
                                    attributes:
     @{
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    
     self.origLabel.attributedText =  attrStr;
   
}



@end
