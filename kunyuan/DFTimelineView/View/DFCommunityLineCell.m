
//
//  DFActivityLineCell.m
//  huayoutong
//
//  Created by Tony on 16/3/8.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "DFCommunityLineCell.h"
#import "DFTextImageLineCell.h"
#import "DFTextImageLineItem.h"
#import "DFCommunityLineItem.h"

#import "MLLabel+Size.h"

#import "DFGridImageView.h"


#import "NSString+MLExpression.h"
#import "NSString+MLExpression.h"
#import "DFFaceManager.h"


#define TextFont [UIFont systemFontOfSize:14]
#define ActivityIconFont [UIFont fontWithName:@"Helvetica" size:13.0]
#define ContactFont [UIFont fontWithName:@"Helvetica" size:15.0]



#define TextLineHeight 1.2f

#define TextImageSpace 10

#define GridMaxWidth (BodyMaxWidth)*0.85

@interface DFCommunityLineCell()


@property (strong, nonatomic) MLLinkLabel *nameLabel;
@property (strong, nonatomic) MLLinkLabel *textContentLabel;
@property (strong, nonatomic) MLLinkLabel *subtextContentLabel;

@property (strong, nonatomic) DFGridImageView *gridImageView;

@end

@implementation DFCommunityLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCell];
    }
    return self;
}


-(void) initCell
{
//    if (_nameLabel == nil) {
//        
//        _nameLabel =[[MLLinkLabel alloc] initWithFrame:CGRectZero];
//        _nameLabel.font = ContactFont;
//        _nameLabel.numberOfLines = 1;
//        _nameLabel.adjustsFontSizeToFitWidth = NO;
//        _nameLabel.textInsets = UIEdgeInsetsZero;
//        
//        _nameLabel.dataDetectorTypes = MLDataDetectorTypePhoneNumber;
//        _nameLabel.dataDetectorTypesOfAttributedLinkValue = MLLinkTypeOther;
//        
//        _nameLabel.allowLineBreakInsideLinks = NO;
//        _nameLabel.linkTextAttributes = nil;
//        _nameLabel.activeLinkTextAttributes = nil;
//        _nameLabel.lineHeightMultiple = TextLineHeight;
//        _nameLabel.linkTextAttributes = @{NSForegroundColorAttributeName: HighLightTextColor};
//        
//        [self.bodyView addSubview:_subtextContentLabel];
//    }
    
    if (_subtextContentLabel == nil) {
        
        _subtextContentLabel =[[MLLinkLabel alloc] initWithFrame:CGRectZero];
        _subtextContentLabel.font = ContactFont;
        _subtextContentLabel.numberOfLines = 1;
        _subtextContentLabel.adjustsFontSizeToFitWidth = NO;
        _subtextContentLabel.textInsets = UIEdgeInsetsZero;
        
        _subtextContentLabel.dataDetectorTypes = MLDataDetectorTypePhoneNumber;
        _subtextContentLabel.dataDetectorTypesOfAttributedLinkValue = MLLinkTypeOther;
        
        _subtextContentLabel.allowLineBreakInsideLinks = NO;
        _subtextContentLabel.linkTextAttributes = nil;
        _subtextContentLabel.activeLinkTextAttributes = nil;
        _subtextContentLabel.lineHeightMultiple = TextLineHeight;
        _subtextContentLabel.linkTextAttributes = @{NSForegroundColorAttributeName: HighLightTextColor};
        
        [self.bodyView addSubview:_subtextContentLabel];
    }
    
    if (_textContentLabel == nil) {
        
        _textContentLabel =[[MLLinkLabel alloc] initWithFrame:CGRectZero];
        _textContentLabel.font = TextFont;
        _textContentLabel.numberOfLines = 0;
        _textContentLabel.adjustsFontSizeToFitWidth = NO;
        _textContentLabel.textInsets = UIEdgeInsetsZero;
        
        _textContentLabel.dataDetectorTypes = MLDataDetectorTypeAll;
        _textContentLabel.allowLineBreakInsideLinks = NO;
        _textContentLabel.linkTextAttributes = nil;
        _textContentLabel.activeLinkTextAttributes = nil;
        _textContentLabel.lineHeightMultiple = TextLineHeight;
        _textContentLabel.linkTextAttributes = @{NSForegroundColorAttributeName: HighLightTextColor};
        
        [self.bodyView addSubview:_textContentLabel];
    }
    
    
    
    
    
    if (_gridImageView == nil) {
        
        CGFloat x, y , width, height;
        
        x = 0;
        y = 0;
        width = GridMaxWidth;
        height = width;
        
        _gridImageView = [[DFGridImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.bodyView addSubview:_gridImageView];
    }
    
}


-(void)updateWithItem:(DFCommunityLineItem *)item
{
    [super updateWithItem:item];
    
    NSLog(@"%@",item.likesStr);
    
//    //naem的size
//    CGSize nameSize = [MLLinkLabel getViewSize:item.nameattrText maxWidth:BodyMaxWidth font:TextFont lineHeight:TextLineHeight lines:0];
//    
//    _nameLabel.attributedText = item.nameattrText;
//    [_nameLabel sizeToFit];
//    
//    _nameLabel.frame = CGRectMake(0, 0, BodyMaxWidth, nameSize.height);
    
    //活动副标题的size
    CGSize subtextSize = [MLLinkLabel getViewSize:item.subattrText maxWidth:BodyMaxWidth font:TextFont lineHeight:TextLineHeight lines:0];
    
    _subtextContentLabel.attributedText = item.subattrText;
    [_subtextContentLabel sizeToFit];
    
    _subtextContentLabel.frame = CGRectMake(0, 0, BodyMaxWidth, subtextSize.height);
    
    //活动标题的size
    CGSize textSize = [MLLinkLabel getViewSize:item.attrText maxWidth:BodyMaxWidth font:TextFont lineHeight:TextLineHeight lines:0];
    
    _textContentLabel.attributedText = item.attrText;
    [_textContentLabel sizeToFit];
    
    _textContentLabel.frame = CGRectMake(0, CGRectGetMaxY(_subtextContentLabel.frame), BodyMaxWidth, textSize.height);
    
   
    
    CGFloat imageW = 20;
    CGFloat imageH = 20;
    CGFloat imageX = 0;
    CGFloat imageY = (textSize.height - imageH) / 2.0 + 2;
    
    
    UIImageView *phoneIcon = [_textContentLabel viewWithTag:-1];
    phoneIcon.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat gridHeight = [DFGridImageView getHeight:item.thumbImages maxWidth:GridMaxWidth oneImageWidth:item.width oneImageHeight:item.height];
    
    CGFloat x, y, width, height;
    x = _gridImageView.frame.origin.x;
    y = CGRectGetMaxY(_textContentLabel.frame) + TextImageSpace;
    width = _gridImageView.frame.size.width;
    height = gridHeight;
    _gridImageView.frame = CGRectMake(x, y, width, height);
    
    [_gridImageView updateWithImages:item.thumbImages srcImages:item.srcImages oneImageWidth:item.width oneImageHeight:item.height];
    
    [self updateBodyView:(subtextSize.height + textSize.height + gridHeight + TextImageSpace)];
    
}


+(CGFloat)getCellHeight:(DFCommunityLineItem *)item
{
//    //活动名字的size
//    NSAttributedString *nameText = item.nameattrText;
//    if (item.nameattrText == nil) {
//        item.nameattrText  = [item.nametext expressionAttributedStringWithExpression:[[DFFaceManager sharedInstance] sharedMLExpression]];
//    }
//    
//    CGSize nameSize = [MLLinkLabel getViewSize:nameText maxWidth:BodyMaxWidth font:ActivityIconFont lineHeight:TextLineHeight lines:0];
    
    
    //副活动标题的size
    if (item.subattrText == nil) {
        item.subattrText  = [item.subtext expressionAttributedStringWithExpression:[[DFFaceManager sharedInstance] sharedMLExpression]];
    }
    
    CGSize subtextSize = [MLLinkLabel getViewSize:item.subattrText maxWidth:BodyMaxWidth font:TextFont lineHeight:TextLineHeight lines:0];
    
    //活动标题的size
    if (item.attrText == nil) {
        item.attrText  = [item.text expressionAttributedStringWithExpression:[[DFFaceManager sharedInstance] sharedMLExpression]];
    }
    
    CGSize textSize = [MLLinkLabel getViewSize:item.attrText maxWidth:BodyMaxWidth font:TextFont lineHeight:TextLineHeight lines:0];
    
    //基本资料的高度包括点赞评论
    CGFloat height = [DFBaseLineCell getCellHeight:item];
    
    //图片区域的高度
    CGFloat gridHeight = [DFGridImageView getHeight:item.thumbImages maxWidth:GridMaxWidth oneImageWidth:item.width oneImageHeight:item.height];
    
    return height  + textSize.height + subtextSize.height +  gridHeight + TextImageSpace;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
