//
//  HeReSetPSWVC.h
//  huobao
//
//  Created by HeDongMing on 14-7-5.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Bootstrap.h"
#import "HeBaseViewController.h"


@interface HeReSetPSWVC : HeBaseViewController<UITextFieldDelegate>

@property(strong,nonatomic)NSString *getcodeKey;  //获取验证码的标记，默认是忘记密码

@property(strong,nonatomic)IBOutlet UILabel *phoneLabel;
@property(strong,nonatomic)IBOutlet UITextField *checkCodeField;
@property(strong,nonatomic)IBOutlet UIButton *reSetButton;
@property(strong,nonatomic)IBOutlet UIButton *nextButton;
@property(strong,nonatomic)IBOutlet UIButton *resendButton;
@property(strong,nonatomic)NSString *phoneStr;
@property(strong,nonatomic)NSDictionary *userDic;
@property(strong,nonatomic)NSDictionary *msgDic;
@property(assign,nonatomic)int loadSucceedFlag;

-(id)initWithDic:myDic;

@end
