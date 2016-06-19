//
//  HeOrderCell.m
//  kunyuan
//
//  Created by HeDongMing on 16/6/17.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeOrderCell.h"

@implementation HeOrderCell
@synthesize timeLabel;
@synthesize stateLabel;
@synthesize titleLabel;
@synthesize moneyLabel;
@synthesize bannerImage;
@synthesize buyButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:240.0 / 255.0 alpha:1.0];
        
        CGFloat viewX = 5;
        CGFloat viewY = 5;
        CGFloat viewH = cellSize.height - 2 * viewY;
        CGFloat viewW = cellSize.width - 2 * viewX;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        bgView.layer.borderWidth = 0;
        bgView.layer.cornerRadius = 5.0;
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        CGFloat timeLabelX = 5;
        CGFloat timeLabelY = 0;
        CGFloat timeLabelW = 100;
        CGFloat timeLabelH = 40;
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont systemFontOfSize:14.0];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.text = @"今天 14:30";
        [bgView addSubview:timeLabel];
        
        stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewW - timeLabelX - timeLabelW, timeLabelY, timeLabelW, timeLabelH)];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.font = [UIFont systemFontOfSize:14.0];
        stateLabel.textColor = APPDEFAULTORANGE;
        stateLabel.textAlignment = NSTextAlignmentRight;
        stateLabel.text = @"已完成";
        [bgView addSubview:stateLabel];
        
        UIView *upline = [[UIView alloc] initWithFrame:CGRectMake(0, timeLabelH, viewW, 1)];
        upline.backgroundColor = [UIColor colorWithWhite:240.0 / 255.0 alpha:1.0];
        [bgView addSubview:upline];
        
        CGFloat imageYOffset = 5;
        CGFloat imageH = viewH - 2 * timeLabelH - 2 * imageYOffset;
        CGFloat imageY = timeLabelY + timeLabelH + imageYOffset;
        CGFloat imageX = timeLabelX;
        CGFloat imageW = 100;
        bannerImage = [[UIImageView alloc] initWithFrame:CGRectMake(timeLabelX, imageY, imageW, imageH)];
        bannerImage.layer.cornerRadius = 3.0;
        bannerImage.layer.borderWidth = 0;
        bannerImage.layer.masksToBounds = YES;
        bannerImage.layer.masksToBounds = YES;
        bannerImage.contentMode = UIViewContentModeScaleAspectFill;
        bannerImage.image = [UIImage imageNamed:@"title_logo1.jpg"];
        [bgView addSubview:bannerImage];
        
        CGFloat titleLabelX = imageX + imageW + 5;
        CGFloat titleLabelY = imageY;
        CGFloat titleLabelW = viewW - titleLabelX - 5;
        CGFloat titleLabelH = imageH / 2.0;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = @"奶茶工坊";
        [bgView addSubview:titleLabel];
        
        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY + titleLabelH, titleLabelW, titleLabelH)];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.font = [UIFont systemFontOfSize:14.0];
        moneyLabel.textColor = [UIColor grayColor];
        moneyLabel.text = @"$ 10";
        [bgView addSubview:moneyLabel];
        
        UIView *downline = [[UIView alloc] initWithFrame:CGRectMake(0, viewH - timeLabelH, viewW, 1)];
        downline.backgroundColor = [UIColor colorWithWhite:240.0 / 255.0 alpha:1.0];
        [bgView addSubview:downline];
        
        CGFloat buttonW = 100;
        buyButton = [[UIButton alloc] initWithFrame:CGRectMake(viewW - buttonW - 5, viewH - timeLabelH, buttonW, timeLabelH)];
        [buyButton setTitle:@"再来一单" forState:UIControlStateNormal];
        [buyButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [buyButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        buyButton.backgroundColor = [UIColor clearColor];
        [bgView addSubview:buyButton];
        
        bgView.userInteractionEnabled = YES;
    }
    return self;
}

- (void)buyButtonClick:(UIButton *)button
{
    NSLog(@"buyButtonClick");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
