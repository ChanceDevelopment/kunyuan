//
//  DFCommunityLineItem.h
//  kunyuan
//
//  Created by HeDongMing on 16/6/19.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "DFBaseLineItem.h"

@interface DFCommunityLineItem : DFBaseLineItem

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *subtext;
@property (nonatomic, strong) NSString *nametext;

//图片连接或者图片数据
@property (nonatomic, strong) NSMutableArray *thumbImages;
//图片连接或者图片数据
@property (nonatomic, strong) NSMutableArray *srcImages;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSAttributedString *attrText;
@property (nonatomic, strong) NSAttributedString *subattrText;
@property (nonatomic, strong) NSAttributedString *nameattrText;

@end
