//
//  HeMainPageSecondCell.m
//  fuyang
//
//  Created by Tony on 16/1/7.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeMainPageSecondCell.h"
#import "AsynImageView.h"

@implementation HeMainPageSecondCell
@synthesize bannerImage;
@synthesize titleLabel;
@synthesize contentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellsize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellH = cellsize.height;
        
        CGFloat imageX = 5;
        CGFloat imageY = 10;
        CGFloat imageW = cellH - 2 * imageY;
        CGFloat imageH = cellH - 2 * imageY;
        bannerImage = [[AsynImageView alloc] init];
        bannerImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
        bannerImage.placeholderImage = [UIImage imageNamed:@"comonDefaultImage"];
        bannerImage.contentMode = UIViewContentModeScaleAspectFill;
        bannerImage.layer.borderWidth = 0;
        bannerImage.layer.borderColor = [UIColor clearColor].CGColor;
        bannerImage.layer.masksToBounds = YES;
        [self addSubview:bannerImage];
        
        CGFloat labelX = imageX + imageW + 5;
        CGFloat labelW = cellsize.width - labelX - 5;
        CGFloat labelH = (cellsize.height - imageY) / 2.0;
        CGFloat labelY = imageY;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        titleLabel.text = @"奶茶";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY + labelH, labelW, labelH)];
        contentLabel.text = @"内容简介";
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.font = [UIFont systemFontOfSize:13.0];
        contentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLabel];
        
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
