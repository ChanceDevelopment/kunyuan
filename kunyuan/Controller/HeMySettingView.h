//
//  HeMySettingView.h
//  huobao
//
//  Created by HeDongMing on 14-7-10.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBaseViewController.h"

@interface HeMySettingView : HeBaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
}

@property(strong,nonatomic)IBOutlet UITableView *settingtable;
@property(strong,nonatomic)NSArray *dataSource;
@property(assign,nonatomic)int loadSucceedFlag;
@property(strong,nonatomic)NSString *appupdateUrl;

@end
