//
//  DFCommunityAdapter.m
//  kunyuan
//
//  Created by HeDongMing on 16/6/19.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "DFCommunityAdapter.h"
#import "DFCommunityLineCell.h"

#define CommunityLineCell @"timeline_cell_DFCommunity"

@implementation DFCommunityAdapter

-(CGFloat) getCellHeightByCount:(DFBaseLineItem *)item
{
    return [DFCommunityLineCell getCellHeight:item];
}

-(UITableViewCell *)getCell:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommunityLineCell];
    if (cell == nil ) {
        cell = [[DFCommunityLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommunityLineCell];
    }
    
    return cell;
}

-(void)updateCell:(DFBaseLineCell *)cell message:(DFBaseLineItem *)item
{
    [cell updateWithItem:item];
}

@end
