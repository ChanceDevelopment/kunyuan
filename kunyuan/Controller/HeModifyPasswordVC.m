//
//  HeModifyPasswordVC.m
//  huobao
//
//  Created by HeDongMing on 14-7-16.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import "HeModifyPasswordVC.h"
#import "UIButton+Bootstrap.h"
#import "HeLoginVC.h"
#import "CustomNavigationController.h"
#import "AppDelegate.h"

#define PasswordMAXLength    20

@interface HeModifyPasswordVC ()

@end

@implementation HeModifyPasswordVC
@synthesize loginButton;
@synthesize pswTF;
@synthesize cpswTF;
@synthesize commitpswTF;
@synthesize loadSucceedFlag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"重置密码";
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
    [loginButton infoStyleWhite];
    [loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    loginButton.layer.borderColor = [[UIColor colorWithRed:214.0/255.0 green:155.0/255.0 blue:157.0/255.0 alpha:1.0] CGColor];
    
    pswTF.delegate = self;
    cpswTF.delegate = self;
}

-(void)initView
{
    self.view.backgroundColor = [UIColor colorWithWhite:230.0f/255.0f alpha:1.0];
    UIView *spaceView = [[UIView alloc]init];
    spaceView.frame = CGRectMake(10, 0, 80, 40);
    
    UILabel *newlabel = [[UILabel alloc] init];
    newlabel.text = @"新密码";
    newlabel.textColor = [UIColor blackColor];
    newlabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    newlabel.backgroundColor = [UIColor clearColor];
    newlabel.textAlignment = NSTextAlignmentLeft;
    newlabel.frame = CGRectMake(15, 5, 80, 30);
    
    [spaceView addSubview:newlabel];
    
    [pswTF setLeftView:spaceView];
    [pswTF setLeftViewMode:UITextFieldViewModeAlways];
    
    
    UIView *spaceView1 = [[UIView alloc]init];
    spaceView1.frame = CGRectMake(10, 0, 80, 40);
    
    UILabel *oldlabel = [[UILabel alloc] init];
    oldlabel.text = @"旧密码";
    oldlabel.textColor = [UIColor blackColor];
    oldlabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    oldlabel.backgroundColor = [UIColor clearColor];
    oldlabel.textAlignment = NSTextAlignmentLeft;
    oldlabel.frame = CGRectMake(15, 5, 80, 30);
    [spaceView1 addSubview:oldlabel];
    
    [cpswTF setLeftView:spaceView1];
    [cpswTF setLeftViewMode:UITextFieldViewModeAlways];
    
    
    UIView *spaceView2 = [[UIView alloc]init];
    spaceView2.frame = CGRectMake(10, 0, 80, 40);
    
    UILabel *commitlabel = [[UILabel alloc] init];
    commitlabel.text = @"确认密码";
    commitlabel.textColor = [UIColor blackColor];
    commitlabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    commitlabel.backgroundColor = [UIColor clearColor];
    commitlabel.textAlignment = NSTextAlignmentLeft;
    commitlabel.frame = CGRectMake(15, 5, 80, 30);
    [spaceView2 addSubview:commitlabel];
    
    [commitpswTF setLeftView:spaceView2];
    [commitpswTF setLeftViewMode:UITextFieldViewModeAlways];
    
    [loginButton infoStyleWhite];
    [loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    loginButton.layer.borderColor = [[UIColor colorWithRed:214.0/255.0 green:155.0/255.0 blue:157.0/255.0 alpha:1.0] CGColor];
//    [cpswTF becomeFirstResponder];
 
    UIBarButtonItem *commitItem = [[UIBarButtonItem alloc] init];
    commitItem.title = @"确认";
    commitItem.target = self;
    commitItem.action = @selector(loginButtonClick:);
    commitItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = commitItem;
    
}


/****取出首尾的空格****/
-(NSString *)trim:(NSString*)string
{
    NSString *trimString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimString;
}

//判断密码是否合法
-(BOOL)isNewPasswordVaild:(NSString *)passwordstr
{
    NSString *trimString = [self trim:passwordstr];
    NSUInteger length = [trimString length];
    if (passwordstr == nil) {
        [self showHint:@"新密码不能为空"];
        return NO;
    }
    
    if ([passwordstr isEqualToString:@""]) {
        [self showHint:@"新密码不能为空"];
        return NO;
    }
    if (length < 6) {
        [self showHint:@"新密码不能小于6位"];
        return NO;
    }
    return YES;
}

-(BOOL)isOldPasswordVaild:(NSString *)passwordstr
{
//    NSString *trimString = [self trim:passwordstr];
//    NSUInteger length = [trimString length];
    if (passwordstr == nil) {
        [self showHint:@"旧密码不能为空"];
        return NO;
    }
    
    if ([passwordstr isEqualToString:@""]) {
        [self showHint:@"旧密码不能为空"];
        return NO;
    }
   
    return YES;
}

-(void)loginButtonClick:(id)sender
{
    if ([cpswTF isFirstResponder]) {
        [cpswTF resignFirstResponder];
        
    }
    if ([pswTF isFirstResponder]) {
        [pswTF resignFirstResponder];
        
    }
    if ([commitpswTF isFirstResponder]) {
        [commitpswTF resignFirstResponder];
        
    }
    NSString *oldPassword = cpswTF.text;
    NSString *newPassword = pswTF.text;
    NSString *commitPassword = commitpswTF.text;
    

    
}

- (void)modifyUserWithParam:(NSDictionary *)param
{
    [self showHudInView:self.view hint:@"修改中..."];
    NSString *modifyPath = [NSString stringWithFormat:@"%@%@",BASEURL,UPDATEUSERINFO];
    
    NSDictionary *paramsDict = @{@"jsonDate":[param JSONString]};
    
}

//-(void)modifyPassword
//{
//    [self showHudInView:self.view hint:@"修改中..."];
//    NSString *modifyPath = [NSString stringWithFormat:@"%@%@",BASEURL,UPDATEUSERINFO];
//    NSDictionary *dict = nil;
//    
//    
//    [[AFOSCClient sharedClient] postPath:modifyPath parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
//        [self hideHud];
//        NSString *respondString = operation.responseString;
//        NSDictionary *respondDict = [respondString objectFromJSONString];
//        NSInteger errorCode = [[respondDict objectForKey:@"errorCode"] integerValue];
//        if (errorCode != 200) {
//            NSString *state = [respondDict objectForKey:@"state"];
//            [self showHint:state];
//            return;
//        }
//        else{
//            //注销登录
//            [self loginOff];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        [self hideHud];
//        [self showHint:ERRORREQUESTTIP];
//    }];
//}

- (void)loginOff
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"修改密码成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"重新登录", nil];
    alertview.tag = 10;
    [alertview show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        //密码修改完成之后注销登录
        
    }
}
//- (void)didLoginFromOtherDevice
//{
//    
//    [self jumpToLoginController];
//}

- (void)jumpToLoginController
{
    HeLoginVC *loginVC = [[HeLoginVC alloc] init];
    CustomNavigationController *loginNav = [[CustomNavigationController alloc]
                                            initWithRootViewController:loginVC];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window setRootViewController:loginNav];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= PasswordMAXLength) {
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 1) {
        [pswTF becomeFirstResponder];
    }
    else if(textField.tag == 2) {
        [commitpswTF becomeFirstResponder];
    }
    else if(textField.tag == 3){
        [self loginButtonClick:nil];
    }
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
