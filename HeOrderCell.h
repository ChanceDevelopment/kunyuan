//
//  HeOrderCell.h
//  kunyuan
//
//  Created by HeDongMing on 16/6/17.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeBaseTableViewCell.h"

@interface HeOrderCell : HeBaseTableViewCell
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UILabel *stateLabel;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *moneyLabel;
@property(strong,nonatomic)UIImageView *bannerImage;
@property(strong,nonatomic)UIButton *buyButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;

@end
