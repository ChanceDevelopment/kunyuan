//
//  HeReSetPSWView.m
//  huobao
//
//  Created by Tony He on 14-5-14.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import "HeReSetPSWView.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"

#define PasswordMAXLength    20

@interface HeReSetPSWView ()
@property(strong,nonatomic)IBOutlet UILabel *tipLabel;

@end

@implementation HeReSetPSWView
@synthesize loginButton;
@synthesize pswTF;
@synthesize cpswTF;
@synthesize phoneStr;
@synthesize userDic;
@synthesize loadSucceedFlag;
@synthesize tipLabel;
@synthesize passwordStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"重设密码";
    }
    return self;
}

-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        userDic = [[NSDictionary alloc] initWithDictionary:dic];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
    [self getUserInfo];
//    [self getPassword];
}

-(void)initializaiton
{
    [loginButton infoStyle];
    loginButton.layer.borderColor = [[UIColor clearColor] CGColor];
    loginButton.layer.borderWidth = 0;
    
    pswTF.delegate = self;
    cpswTF.delegate = self;
}

-(void)initView
{
    UIView *spaceView = [[UIView alloc]init];
    spaceView.frame = CGRectMake(20, 0, 60, 40);
    
    UIImageView *accountSpaceView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pwdIcon.png"]];
    accountSpaceView.frame = CGRectMake(20, 5, 30, 30);
    [spaceView addSubview:accountSpaceView];
    
    [pswTF setLeftView:spaceView];
    [pswTF setLeftViewMode:UITextFieldViewModeAlways];
    
    
    UIView *spaceView1 = [[UIView alloc]init];
    spaceView1.frame = CGRectMake(20, 0, 60, 40);
    
    UIImageView *accountSpaceView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pwdIcon.png"]];
    accountSpaceView1.frame = CGRectMake(20, 5, 30, 30);
    [spaceView1 addSubview:accountSpaceView1];
    
    [cpswTF setLeftView:spaceView1];
    [cpswTF setLeftViewMode:UITextFieldViewModeAlways];
    
}

- (NSString *) checkRegisterPassword:(NSString *)userPwdVal
{
    NSString * regex_userPwd = @"[a-zA-Z0-9]{6,15}";//密码
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userPwdVal];
    //----点击确定隐藏键盘
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex_userPwd];
    if(![pred evaluateWithObject:userPwdVal]){
        return @"请填写6-15位密码数字或字母";
    }else {
        return nil;
    }
}

//获取用户的个人信息
- (void)getUserInfo
{
    NSString *getUserInfoPath = [NSString stringWithFormat:@"%@%@",BASEURL,GETUSERINFO];
    NSString *username = self.phoneStr;
    NSDictionary *params = @{@"username":username};
    
}

- (IBAction)resetPassword
{
    if ([cpswTF isFirstResponder]) {
        [cpswTF resignFirstResponder];
        
    }
    if ([pswTF isFirstResponder]) {
        [pswTF resignFirstResponder];
        
    }
    NSString *password = pswTF.text;
    NSString *cpassword = cpswTF.text;
    
    if (password == nil || cpassword == nil) {
        [self showHint:@"密码不能为空"];
        return;
    }
    NSString *tip = [self checkRegisterPassword:password];
    if (tip) {
        [self showHint:tip];
        return;
    }
    tip = [self checkRegisterPassword:cpassword];
    if (tip) {
        [self showHint:tip];
        return;
    }
    
    if ([password isEqualToString:cpassword]) {
        [self showHudInView:self.view hint:@"正在为你重置密码..."];
        NSString *modifyPath = [NSString stringWithFormat:@"%@%@",BASEURL,UPDATEUSERINFO];
        if (self.userid == nil) {
            self.userid = @"";
        }
        NSDictionary *param = @{@"id":self.userid,@"password":password};
        NSDictionary *paramsDict = @{@"jsonDate":[param JSONString]};
        
    }
    else{
        [self showHint:@"两次输入密码不一致"];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)loginToServerWithPassword:(NSString *)passwordString
{
    NSString *loginPath = [NSString stringWithFormat:@"%@%@",BASEURL,LOGINURL];
    NSDictionary *dict = @{@"username":phoneStr,@"password":passwordString};
    
    [self showHudInView:self.view hint:@"登录中..."];
    
}

- (void)easeMobLoginWithPassword:(NSString *)password
{
    // @password  自己服务器的通信模块的登录密码
    
    [self jumpToMainController];
    
}

- (void)jumpToMainController
{
    HeTabBarVC *tabBarVC = [[HeTabBarVC alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.viewController = tabBarVC;
    [appDelegate.window setRootViewController:appDelegate.viewController];
    [appDelegate.window makeKeyAndVisible];
}



-(void)backTolastView:(id)sender
{
    NSArray *navArray = self.navigationController.childViewControllers;
    for (UIViewController *conView in navArray) {
        if ([conView isMemberOfClass:[HeLoginVC class]]) {
            [self.navigationController popToViewController:conView animated:YES];
            break;
        }
    }
}


-(IBAction)loginButtonClick:(id)sender
{
    [self loginToServerWithPassword:self.passwordStr];
}

//判断密码是否合法
-(BOOL)isPasswordVaild:(NSString *)passwordstr
{
    NSString *trimString = [self trim:passwordstr];
    NSUInteger length = [trimString length];
    if ([passwordstr isEqualToString:@""]) {
        [self showHint:@"密码不能为空"];
        return NO;
    }
    if (length < 6) {
        [self showHint:@"密码不能小于6位"];
        return NO;
    }
    return YES;
}

/****取出首尾的空格****/
-(NSString *)trim:(NSString*)string
{
    NSString *trimString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimString;
}

-(void)modifyPSW
{
    [self hideHud];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"修改密码成功" delegate:self cancelButtonTitle:@"重新登录" otherButtonTitles:nil, nil];
    alert.tag = 10;
    [alert show];
    
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == 10) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//}
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
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
