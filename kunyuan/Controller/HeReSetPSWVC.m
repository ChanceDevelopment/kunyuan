//
//  HeReSetPSWVC.m
//  huobao
//
//  Created by HeDongMing on 14-7-5.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import "HeReSetPSWVC.h"
#import "HeModifyPasswordVC.h"
#import "HeReSetPSWView.h"

@interface HeReSetPSWVC ()


@end

@implementation HeReSetPSWVC
@synthesize phoneLabel;
@synthesize checkCodeField;
@synthesize reSetButton;
@synthesize nextButton;
@synthesize resendButton;
@synthesize phoneStr;
@synthesize userDic;
@synthesize loadSucceedFlag;
@synthesize getcodeKey;
@synthesize msgDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"验证身份";
    }
    return self;
}

-(id)initWithDic:myDic
{
    if (self = [self init]) {
        msgDic = [[NSDictionary alloc] initWithDictionary:myDic];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.9) {
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    }
    else{
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    [self initControl];
    [self initView];
}

-(void)initView
{
    UIView *spaceView = [[UIView alloc]init];
    spaceView.frame = CGRectMake(20, 0, 60, 40);
    
    UIImageView *accountSpaceView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phoneIcon.png"]];
    accountSpaceView.frame = CGRectMake(20, 5, 30, 30);
    [spaceView addSubview:accountSpaceView];
    
    [checkCodeField setLeftView:spaceView];
    [checkCodeField setLeftViewMode:UITextFieldViewModeAlways];
    
    [resendButton infoStyleWhite];
    [resendButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    resendButton.layer.borderColor = [[UIColor colorWithRed:214.0/255.0 green:155.0/255.0 blue:157.0/255.0 alpha:1.0] CGColor];
    
}

-(void)initControl
{
    self.phoneLabel.text = phoneStr;
    [self.phoneLabel setTextColor:[UIColor redColor]];
    [reSetButton infoStyle];
    [nextButton infoStyle];
    
    
    nextButton.layer.borderColor = [[UIColor clearColor] CGColor];
    nextButton.layer.borderWidth = 0;
    
    UIBarButtonItem *finishButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finish:)];
    finishButton.title = @"完成";
    NSArray *bArray = [NSArray arrayWithObjects:finishButton, nil];
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];//创建工具条对象
    tb.items = bArray;
    tb.hidden = YES;
    checkCodeField.inputAccessoryView = tb;//将工具条添加到UITextView的响应键盘
    
    [self performSelector:@selector(myTimer) withObject:nil];
}

//我的倒计时
-(void)myTimer
{
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [resendButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                resendButton.layer.borderColor = [[UIColor colorWithRed:214.0/255.0 green:155.0/255.0 blue:157.0/255.0 alpha:1.0] CGColor];
                
                [resendButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
                resendButton.layer.borderColor = [[UIColor colorWithRed:214.0/255.0 green:155.0/255.0 blue:157.0/255.0 alpha:1.0] CGColor];
                
                [resendButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                resendButton.layer.borderColor = [[UIColor colorWithRed:214.0/255.0 green:155.0/255.0 blue:157.0/255.0 alpha:1.0] CGColor];
                
                self.resendButton.enabled = YES;
                [self.resendButton setTitle:@"重发" forState:UIControlStateNormal];
            });
        }else{
            self.resendButton.enabled = NO;
            
            int seconds = timeout % 60;
            if (seconds == 0) {
                seconds = 60;
            }
            NSString *strTime = [NSString stringWithFormat:@"%d秒",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.resendButton setTitle:strTime forState:UIControlStateNormal];
                [self.resendButton setTitle:strTime forState:UIControlStateHighlighted];
                [self.resendButton setTitle:strTime forState:UIControlStateSelected];
                [self.resendButton setTitle:strTime forState:UIControlStateDisabled];
                
                [resendButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
                resendButton.layer.borderColor = [[UIColor grayColor] CGColor];
                
                [resendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                resendButton.layer.borderColor = [[UIColor grayColor] CGColor];
                
                [resendButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                resendButton.layer.borderColor = [[UIColor grayColor] CGColor];
                
                [resendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
                resendButton.layer.borderColor = [[UIColor grayColor] CGColor];
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

-(void)finish:(id)sender
{
    [checkCodeField resignFirstResponder];
}

-(void)backTolastView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)reSendCheckCode:(id)sender
{
    if ([checkCodeField isFirstResponder]) {
        [checkCodeField resignFirstResponder];
    }
    [self performSelector:@selector(myTimer) withObject:nil];
    [self showHudInView:self.view hint:@"正在获取验证码"];
    [self performSelector:@selector(getcheckCode:) withObject:nil afterDelay:0.5];
}


-(void)getcheckCode:(id)sender
{
    
    //获取手机验证码
    
}


-(IBAction)nextButtonClick:(id)sender
{
    [self showHudInView:self.view hint:@"验证中..."];
    [self verify:nil];
}

-(void)verify:(id)sender
{
    NSString *inputCode = self.checkCodeField.text;
    NSString *correctCode = [msgDic objectForKey:@"code"];
    if ([correctCode isMemberOfClass:[NSNull class]]) {
        correctCode = nil;
    }
    if ([inputCode isEqualToString:correctCode]) {
        [self hideHud];
        if ([self.getcodeKey isEqualToString:MODIFYPASSWORDKEY]) {
            HeModifyPasswordVC *modifyPswVC = [[HeModifyPasswordVC alloc] init];
            modifyPswVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyPswVC animated:YES];
        }
        else{
            
            HeReSetPSWView *basicInfo = [[HeReSetPSWView alloc] init];
            basicInfo.hidesBottomBarWhenPushed = YES;
            basicInfo.phoneStr = self.phoneStr;
            [self.navigationController pushViewController:basicInfo animated:YES];
        }
    }
    else{
        [self hideHud];
        [self showHint:@"验证码错误"];
    }
   
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
