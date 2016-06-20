//
//  HeNotifyCell.m
//  kunyuan
//
//  Created by Tony on 16/6/20.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeNotifyCell.h"

@implementation HeNotifyCell
@synthesize headImage;
@synthesize titleLabel;
@synthesize timeLabel;
@synthesize subLabel;
@synthesize sellerLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat imageX = 5;
        CGFloat imageY = 5;
        CGFloat imageW = 30;
        CGFloat imageH = 30;
        headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_placeholder_icon"]];
        headImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
        headImage.layer.cornerRadius = 2.0;
        headImage.layer.borderWidth = 0;
        headImage.layer.masksToBounds = YES;
        [self addSubview:headImage];
        
        CGFloat titleLabelX = imageX + imageW + 5;
        CGFloat titleLabelY = imageY;
        CGFloat titleLabelW = (cellSize.width - titleLabelX) / 2.0;
        CGFloat titleLabelH = imageH;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:18.0];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = @"商家已经接单啦";
        [self addSubview:titleLabel];
        
        
        CGFloat timeLabelX = titleLabelX + titleLabelW;
        CGFloat timeLabelY = imageY;
        CGFloat timeLabelW = (cellSize.width - titleLabelX) / 2.0 - 10;
        CGFloat timeLabelH = imageH;
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont systemFontOfSize:13.0];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.text = @"6-13 18:24";
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:timeLabel];
        
        CGFloat subLabelX = titleLabelX;
        CGFloat subLabelH = 40;
        CGFloat subLabelY = cellSize.height - subLabelH - 5;
        CGFloat subLabelW = cellSize.width - titleLabelX - 20;
        
        subLabel = [[UILabel alloc] initWithFrame:CGRectMake(subLabelX, subLabelY, subLabelW, subLabelH)];
        subLabel.numberOfLines = 2;
        subLabel.backgroundColor = [UIColor clearColor];
        subLabel.font = [UIFont systemFontOfSize:15.0];
        subLabel.textColor = [UIColor grayColor];
        subLabel.text = @"您在【汉堡王】下的单1060135130，商家已经接单";
        [self addSubview:subLabel];
        
        
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
