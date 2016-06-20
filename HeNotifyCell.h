//
//  HeNotifyCell.h
//  kunyuan
//
//  Created by Tony on 16/6/20.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeBaseTableViewCell.h"

@interface HeNotifyCell : HeBaseTableViewCell
@property(strong,nonatomic)UIImageView *headImage;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UILabel *subLabel;
@property(strong,nonatomic)UILabel *sellerLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;

@end
