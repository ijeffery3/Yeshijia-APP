//
//  MeAccountCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/2.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "MeAccountCell.h"

@interface MeAccountCell()

@property (nonatomic, strong) NSArray *numArr;

@property (nonatomic, strong) NSArray *textArr;

@end

@implementation MeAccountCell

- (NSArray *)numArr
{
    if (!_numArr) {
        _numArr = [NSArray array];
    }
    return _numArr;
}

- (NSArray *)textArr
{
    if (!_textArr) {
        _textArr = [NSArray array];
    }
    return _textArr;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MeAccountCell";
    MeAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MeAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _numArr = @[@"0.00",@"0",@"20"];
        _textArr = @[@"余额",@"代金券",@"积分"];
        [self setupViews];
    }
    
    return self;
}


- (void)setupViews
{
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"我的账户";
    [self.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(10);
        make.left.mas_equalTo(label1.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(0.5);
    }];
    
    
    CGFloat btnW = ScreenWidth / _textArr.count;
    
    for (int i = 0; i < _textArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_numArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
        [self.contentView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom).offset(10);
            make.left.mas_equalTo(self.contentView.mas_left).offset(i * btnW);
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(44);
        }];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = _textArr[i];
        textLabel.font = [UIFont systemFontOfSize:14.0];
        textLabel.textColor = [UIColor lightGrayColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:textLabel];
        
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(btn.mas_bottom).offset(5);
            make.left.mas_equalTo(btn.mas_left);
            make.width.mas_equalTo(btn.mas_width);
            make.height.mas_equalTo(20);
        }];
        
    }
    
    
}


@end
