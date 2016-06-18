//
//  HeMainPageSecondCell.h
//  fuyang
//
//  Created by Tony on 16/1/7.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeMainPageSecondCell : UITableViewCell
@property(strong,nonatomic)AsynImageView *bannerImage;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *contentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellsize;

@end
