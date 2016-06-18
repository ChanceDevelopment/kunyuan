//
//  HeMainPageFirstCell.h
//  fuyang
//
//  Created by Tony on 16/1/7.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeMainPageFirstCell : UITableViewCell

@property(strong,nonatomic)NSString *cellTitle;
@property(strong,nonatomic)UIColor *tagColor;
@property(strong,nonatomic)UIView *tagView;
@property(strong,nonatomic)UILabel *titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTitle:(NSString *)title color:(UIColor *)color cellSize:(CGSize)cellsize;


@end
