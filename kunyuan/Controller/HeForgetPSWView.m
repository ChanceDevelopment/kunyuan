//
//  HeForgetPSWView.m
//  huobao
//
//  Created by Tony He on 14-5-14.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import "HeForgetPSWView.h"
#import "HeReSetPSWVC.h"

#define PasswordMAXLength    20

@interface HeForgetPSWView ()

@end

@implementation HeForgetPSWView
@synthesize nextButton;
@synthesize accountTF;
@synthesize loadSucceedFlag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"找回密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initializaiton];
    [self initView];
   
}

-(void)initializaiton
{
    self.navigationController.navigationBarHidden = NO;
    
    [nextButton infoStyle];
    nextButton.layer.borderColor = [UIColor clearColor].CGColor;
    nextButton.layer.borderWidth = 0;
    
    UIView *spaceView = [[UIView alloc]init];
    spaceView.frame = CGRectMake(20, 0, 60, 40);
    
    UIImageView *accountSpaceView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phoneIcon.png"]];
    accountSpaceView.frame = CGRectMake(20, 5, 30, 30);
    [spaceView addSubview:accountSpaceView];
    
    [accountTF setLeftView:spaceView];
    [accountTF setLeftViewMode:UITextFieldViewModeAlways];
    
    accountTF.delegate = self;
    accountTF.textColor = [UIColor grayColor];
    
    accountTF.tag = 1;
    UIBarButtonItem *finishButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finish:)];
    finishButton.title = @"完成";
    NSArray *bArray = [NSArray arrayWithObjects:finishButton, nil];
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 33)];//创建工具条对象
    tb.items = bArray;
    accountTF.inputAccessoryView = tb;//将工具条添加到UITextView的响应键盘
}

-(void)initView
{
    if ([self.getcodeKey isEqualToString:MODIFYPASSWORDKEY]) {
        self.title = @"修改密码";
    }
}


-(void)finish:(id)sender
{
    if ([accountTF isFirstResponder]) {
        [accountTF resignFirstResponder];
    }
}

/****取出首尾的空格****/
-(NSString *)trim:(NSString*)string
{
    NSString *trimString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimString;
}

//判断账号是否合法
-(BOOL)isAccountVaild:(NSString *)accountStr
{
    NSString *trimString = [self trim:accountStr];
    const char *account = [trimString UTF8String];
    NSUInteger length = [trimString length];
    if ([accountStr isEqualToString:@""] || accountStr == nil) {
        [self showHint:@"手机号不能为空"];
        return NO;
    }
    if (length != 11) {
        [self showHint:@"手机号格式有误"];
        return NO;
    }
    for (int i = 0; i<length; i++) {
        if (*(account+i)<48 || *(account+i) >57) {
            [self showHint:@"手机号格式有误"];
            return NO;
        }
    }
    return YES;
}

-(IBAction)nextButtonClick:(id)sender
{
    [accountTF resignFirstResponder];
    if ([accountTF.text isEqualToString:@""] || accountTF.text == nil) {
        [self showHint:@"手机号不能为空"];
        return;
    }
    if (![self isAccountVaild:accountTF.text]) {
        return;
    }
    if ([self.getcodeKey isEqualToString:MODIFYPASSWORDKEY]) {
        NSString *error = [Tool checkRegisterPassword:accountTF.text];
        if (error) {
            [self showHint:error];
            return;
        }
    }
    
    [self isAccountRegister:accountTF.text];
    
    
}

- (void)isAccountRegister:(NSString *)username
{
    NSString *getUserInfoPath = [NSString stringWithFormat:@"%@%@",BASEURL,GETUSERINFO];
    NSDictionary *params = @{@"username":username};
    
}

-(void)getcheckCode:(id)sender
{
    //获取手机验证码
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1) {
        if (range.location >= 11) {
            return NO;
        }
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSString *textString = textField.text;
    if ([textString isEqualToString:@"请输入手机号码"])
    {
        textField.text = @"";
        textField.textColor = [UIColor blackColor];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *textString = textField.text;
    if ([textString isEqualToString:@"请输入手机号码"] || [textString isEqualToString:@""] || textString == nil)
    {
        textField.text = @"请输入手机号码";
        textField.textColor = [UIColor grayColor];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
