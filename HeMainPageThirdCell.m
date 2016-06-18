//
//  HeMainPageThirdCell.m
//  fuyang
//
//  Created by Tony on 16/1/7.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeMainPageThirdCell.h"

@implementation HeMainPageThirdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellsize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellH = cellsize.height;
        
        CGFloat imageX = 15;
        CGFloat imageY = 10;
        CGFloat imageW = 120;
        CGFloat imageH = cellH - 2 * imageY;
        AsynImageView *image = [[AsynImageView alloc] init];
        image.frame = CGRectMake(imageX, imageY, imageW, imageH);
        image.placeholderImage = [UIImage imageNamed:@"4071719464.jpg"];
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.layer.borderWidth = 0;
        image.layer.borderColor = [UIColor clearColor].CGColor;
        image.layer.masksToBounds = YES;
        image.imageURL = @"http://img2.imgtn.bdimg.com/it/u=3802858230,3430577598&fm=11&gp=0.jpg";
        [self addSubview:image];
        
        CGFloat labelH = imageH;
        CGFloat labelX = imageX + imageW + 10;
        CGFloat labelY = imageY;
        CGFloat labelW = SCREENWIDTH - labelX - imageX;
        
        UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        titlelabel.numberOfLines = 3;
        titlelabel.backgroundColor = [UIColor clearColor];
        titlelabel.text = @"开启新征程 高水平全面建成小康社会";
        titlelabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        titlelabel.textColor = [UIColor blackColor];
        [self addSubview:titlelabel];
        
        
        
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
