//
//  HeMainPageTable.h
//  fuyang
//
//  Created by HeDongMing on 16/1/6.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ServiceFunctionProtocol <NSObject>

- (void)functionButtonClick:(UIButton *)sender;
- (void)gotoWebWithUrl:(NSString *)url;
- (void)selectIndex:(NSInteger)selectIndex;

@end

@interface HeMainPageTable : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSMutableArray *mydataSource;
@property(assign,nonatomic)id<ServiceFunctionProtocol> serviceDelegate;

- (void)initView;
- (void)initHeaderView;
- (void)initHeaderViewWithArray:(NSArray *)array;
- (void)setHeaderViewWithDataSource:(id)userInfo;

@end
