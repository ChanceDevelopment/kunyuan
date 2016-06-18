//
//  HeMainPageFirstCell.m
//  fuyang
//
//  Created by Tony on 16/1/7.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeMainPageFirstCell.h"

@implementation HeMainPageFirstCell
@synthesize cellTitle;
@synthesize tagColor;
@synthesize tagView;
@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTitle:(NSString *)title color:(UIColor *)color cellSize:(CGSize)cellsize;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *titleArray = @[@[@"热卖美食",@"新用户特权"],@[@"新品推荐",@"今日特价菜"]];
        NSArray *subTitleArray = @[@[@"劲爆折扣专区",@"劲爆折扣专区"],@[@"劲爆折扣专区",@"劲爆折扣专区"]];
        NSArray *imageArray = @[@[@"bg_home_a",@"bg_home_b"],@[@"bg_home_c",@"bg_home_d"]];
        NSArray *colorArray = @[@[[UIColor redColor],[UIColor blueColor]],@[[UIColor orangeColor],APPDEFAULTORANGE]];
        CGFloat buttonX = 0;
        CGFloat buttonY = 0;
        CGFloat buttonW = cellsize.width / 2.0;
        CGFloat buttonH = cellsize.height / 2.0;
        for (NSInteger row = 0; row < [titleArray count]; row++) {
            NSArray *array = titleArray[row];
            for (NSInteger column = 0; column < [array count]; column++) {
                buttonX = column * buttonW;
                buttonY = row * buttonH;
                NSString *title = titleArray[row][column];
                NSString *subtitle = subTitleArray[row][column];
                NSString *imagename = imageArray[row][column];
                CGRect frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
                UIColor *color = colorArray[row][column];
                UIButton *button = [self buttonWithTitle:title subTitle:subtitle image:imagename frame:frame titlColor:color];
                button.tag = column + row * [titleArray count];
                [self addSubview:button];
            }
        }
        
        UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, buttonH, cellsize.width, 1)];
        separateLine.backgroundColor = [UIColor colorWithWhite:240.0/255.0 alpha:1.0];
        [self addSubview:separateLine];
        
        UIView *v_separateLine = [[UIView alloc] initWithFrame:CGRectMake(buttonW, 0, 1, cellsize.height)];
        v_separateLine.backgroundColor = [UIColor colorWithWhite:240.0/255.0 alpha:1.0];
        [self addSubview:v_separateLine];
//        CGFloat cellH = cellsize.height;
//        CGFloat cellW = cellsize.width;
//        
//        CGFloat tagViewX = 15;
//        CGFloat tagViewY = 10;
//        CGFloat tagViewH = cellH - 2 * tagViewY;
//        CGFloat tagViewW = 3;
//        tagView = [[UIView alloc] initWithFrame:CGRectMake(tagViewX, tagViewY, tagViewW, tagViewH)];
//        tagView.backgroundColor = color;
//        [self addSubview:tagView];
//        
//        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(tagViewX + tagViewW + 10, 0, SCREENWIDTH - (tagViewX + tagViewW + 10), cellH)];
//        titleLabel.backgroundColor = [UIColor clearColor];
//        titleLabel.textColor = [UIColor blackColor];
//        titleLabel.font = [UIFont systemFontOfSize:20.0];
//        titleLabel.text = title;
//        [self addSubview:titleLabel];
//        
//        cellTitle = [[NSString alloc] initWithFormat:@"%@",title];
//        tagColor = color;
    }
    return self;
}

- (UIButton *)buttonWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(NSString *)imageName frame:(CGRect)frame titlColor:(UIColor *)color
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    CGFloat buttonW = button.frame.size.width;
    
    CGFloat imageViewX = buttonW / 2.0;
    CGFloat imageViewY = 0;
    CGFloat imageViewW = buttonW / 2.0;
    CGFloat imageViewH = button.frame.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [button addSubview:imageView];
    
    CGFloat labelH = 20;
    CGFloat labelY = (button.frame.size.height - 2 * labelH) / 2.0;
    CGFloat labelW = buttonW / 2.0;
    CGFloat labelX = 0;
    UILabel *maintitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    maintitleLabel.backgroundColor = [UIColor clearColor];
    maintitleLabel.text = title;
    maintitleLabel.textColor = color;
    maintitleLabel.textAlignment = NSTextAlignmentCenter;
    maintitleLabel.font = [UIFont systemFontOfSize:13.0];
    [button addSubview:maintitleLabel];
    
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY + labelH, labelW, labelH)];
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.text = subTitle;
    subtitleLabel.textColor = [UIColor grayColor];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.font = [UIFont systemFontOfSize:12.0];
    [button addSubview:subtitleLabel];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClick:(UIButton *)button
{

}

- (void)setTagColor:(UIColor *)_tagColor
{
    self.tagColor = _tagColor;
    self.tagView.backgroundColor = tagColor;
}

- (void)setCellTitle:(NSString *)_cellTitle
{
    self.cellTitle = [[NSString alloc] initWithFormat:@"%@",_cellTitle];
    self.titleLabel.text = _cellTitle;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
