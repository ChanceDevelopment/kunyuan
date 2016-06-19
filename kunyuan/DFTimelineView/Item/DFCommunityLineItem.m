//
//  DFCommunityLineItem.m
//  kunyuan
//
//  Created by HeDongMing on 16/6/19.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "DFCommunityLineItem.h"

@implementation DFCommunityLineItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.itemType = LineItemTypeTextImage;
        
        _text = @"";
        _thumbImages = [NSMutableArray array];
        _srcImages = [NSMutableArray array];
    }
    return self;
}

@end
