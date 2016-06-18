//
//  HeTabBarVC.h
//  huayoutong
//
//  Created by HeDongMing on 16/3/2.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeBaseViewController.h"
#import "RDVTabBarController.h"
#import "HeUserVC.h"
#import "HeOrderVC.h"
#import "HeCommunityVC.h"
#import "HeHomepageVC.h"

@interface HeTabBarVC : RDVTabBarController<UIAlertViewDelegate>

@property(strong,nonatomic)HeUserVC *userVC;
@property(strong,nonatomic)HeOrderVC *orderVC;
@property(strong,nonatomic)HeCommunityVC *communityVC;
@property(strong,nonatomic)HeHomepageVC *homepageVC;

@end
