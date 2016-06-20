//
//  HeReSetPSWView.h
//  huobao
//
//  Created by Tony He on 14-5-14.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Bootstrap.h"
#import "HeLoginVC.h"

@interface HeReSetPSWView : HeBaseViewController<UITextFieldDelegate,UIAlertViewDelegate,UIAlertViewDelegate>

@property(strong,nonatomic)IBOutlet UIButton *loginButton;
@property(strong,nonatomic)IBOutlet UITextField *pswTF;
@property(strong,nonatomic)IBOutlet UITextField *cpswTF;
@property(strong,nonatomic)NSString *phoneStr;
@property(strong,nonatomic)NSString *userid;
@property(strong,nonatomic)NSString *passwordStr;
@property(strong,nonatomic)NSDictionary *userDic;
@property(assign,nonatomic)int loadSucceedFlag;

-(IBAction)loginButtonClick:(id)sender;

-(id)initWithDic:(NSDictionary *)dic;

@end
