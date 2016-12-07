//
//  AITitleView.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "AITitleIconView.h"
#import "UIImageView+WebCache.h"



@interface AITitleIconView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *icon;
@end


@implementation AITitleIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
        
        _icon = [[UIImageView alloc]init];
//        _icon.contentMode = UIViewContentModeCenter;
        [self addSubview:_icon];
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_icon.mas_bottom).offset(8);
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(19);
        }];
    }
    
    return  self;
}

- (instancetype)initWithTitleLabel:(NSString *)titleLabel icon:(NSString *)icon boder:(BOOL)boder
{
    if (self = [super init]) {
        if (boder) {
//            self.layer.borderColor = GrayColor.CGColor;
//            self.layer.borderWidth = 0.5;
        }
        self.titleLabel.text = titleLabel;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:nil];
        
    }
    return self;

}

@end
