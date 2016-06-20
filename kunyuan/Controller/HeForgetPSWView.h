//
//  HeForgetPSWView.h
//  huobao
//
//  Created by Tony He on 14-5-14.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Bootstrap.h"
#import "MBProgressHUD.h"
#import "HeBaseViewController.h"

@interface HeForgetPSWView : HeBaseViewController<UITextFieldDelegate,MBProgressHUDDelegate>

@property(strong,nonatomic)NSString *getcodeKey;  //获取验证码的标记，默认是忘记密码
@property(strong,nonatomic)IBOutlet UIButton *nextButton;
@property(strong,nonatomic)IBOutlet UITextField *accountTF;

-(IBAction)nextButtonClick:(id)sender;

@property(assign,nonatomic)int loadSucceedFlag;

@end
