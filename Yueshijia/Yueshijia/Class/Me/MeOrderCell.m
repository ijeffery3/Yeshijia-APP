//
//  MeOrderCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/2.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "MeOrderCell.h"
#import "AIButton.h"

@interface MeOrderCell()

@property (nonatomic, strong) NSArray *imagArr;
@property (nonatomic, strong) NSArray *textArr;

@end



@implementation MeOrderCell

- (NSArray *)imagArr
{
    if (!_imagArr) {
        _imagArr = [NSArray array];
    }
    return _imagArr;
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
    static NSString *ID = @"MeOrderCell";
    MeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MeOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imagArr = @[@"mine_payment",@"mine_delivery",@"mine_sendgoods",@"mine_evaluation",@"mine_refund"];
        _textArr = @[@"代付款",@"代发货",@"待收货",@"待评价",@"退货"];
        [self setupViews];
    }
    
    return self;
}


- (void)setupViews
{
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"我的订单";
    [self.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UIImageView *goin = [[UIImageView alloc] init];
    goin.image = [UIImage imageNamed:@"btn_in"];
    [self.contentView addSubview:goin];
    [goin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1).offset(3);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(6, 14));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"查看全部";
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = [UIColor lightGrayColor];
    label2.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1);
        make.right.mas_equalTo(goin.mas_left).offset(-10);
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
    
    CGFloat btnW = ScreenWidth / _imagArr.count;
    
    for (int i = 0; i < _imagArr.count; i++) {
        
        AIButton *btn = [AIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:_imagArr[i]] forState:UIControlStateNormal];
        [btn setTitle:_textArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.contentView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom).offset(10);
            make.left.mas_equalTo(self.contentView.mas_left).offset(i * btnW);
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(btnW);
        }];
        
    }
    
    
}



@end
