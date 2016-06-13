//
//  DFLikeCommentToolbar.m
//  DFTimelineView
//
//  Created by Allen Zhong on 15/9/29.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFLikeCommentToolbar.h"

@interface DFLikeCommentToolbar()

@property (nonatomic, strong) UIButton *likeButton;

@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) UIButton *shareButton;


@end


@implementation DFLikeCommentToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}

-(void) initView
{
    
    self.userInteractionEnabled = YES;
    
//    UIImage *image = [UIImage imageNamed:@"AlbumOperateMoreViewBkg"];
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    self.backgroundColor = APPDEFAULTORANGE;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.0;
//    self.image = image;
    
    
    CGFloat x, y, width, height;
    
    x=0;
    y=0;
    width = self.frame.size.width / 3.0;
    height = self.frame.size.height;
    
    _shareButton = [self getButton:CGRectMake(x, y, width, height) title:@"分享" image:@"AlbumShare"];
    [_shareButton addTarget:self action:@selector(onShare:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shareButton];
    
    x = width;
    _likeButton = [self getButton:CGRectMake(x, y, width, height) title:@"点赞" image:@"AlbumLike"];
    [_likeButton addTarget:self action:@selector(onLike:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_likeButton];
    
    x = 2 * width;
    _commentButton = [self getButton:CGRectMake(x, y, width, height) title:@"评论" image:@"AlbumComment"];
    [_commentButton addTarget:self action:@selector(onComment:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commentButton];
    
    //分割线
    height = height - 16;
    y = (self.frame.size.height - height) / 2;
    CGFloat linewidth = 1;
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(x, y, linewidth, height)];
    divider.backgroundColor = [UIColor whiteColor];
    [self addSubview:divider];
    
    divider = [[UIView alloc] initWithFrame:CGRectMake(x - width, y, linewidth, height)];
    divider.backgroundColor = [UIColor whiteColor];
    [self addSubview:divider];
    
    
}

- (void)updateLikeWithTitle:(NSString *)title
{
    [_likeButton setTitle:title forState:UIControlStateNormal];
}


-(UIButton *) getButton:(CGRect) frame title:(NSString *) title image:(NSString *) image
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    //btn.backgroundColor = [UIColor redColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}



-(void) onLike:(id) sender
{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(onLike)]) {
        [_delegate onLike];
    }
    
}


-(void) onComment:(id) sender
{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(onComment)]) {
        [_delegate onComment];
    }
}

- (void)onShare:(id) sender
{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(onShare)]) {
        [_delegate onShare];
    }
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com