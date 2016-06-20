//
//  HeModifyInfoView.m
//  huobao
//
//  Created by Tony He on 14-5-15.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import "HeModifyInfoView.h"
#import "CPTextViewPlaceholder.h"
#import "UIButton+Bootstrap.h"

@interface HeModifyInfoView ()
@property(strong,nonatomic)NSDictionary *settingDict;
@property(strong,nonatomic)CPTextViewPlaceholder *contentField;

@end

@implementation HeModifyInfoView
@synthesize modifyTF;
@synthesize settingDict;
@synthesize contentField;
@synthesize popToRoot;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        popToRoot = NO;
    }
    return self;
}

-(id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.settingDict = [[NSDictionary alloc] initWithDictionary:dict copyItems:NO];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont boldSystemFontOfSize:20.0];
//        label.textColor = [UIColor whiteColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        self.navigationItem.titleView = label;
        NSString *titleStirng = [dict objectForKey:@"defaultInfo"];
        self.title = [NSString stringWithFormat:@"修改%@",titleStirng];
//        [label sizeToFit];
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
//    [self setOffset];
}


-(void)initControl
{

    self.view.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1];
    self.modifyTF.delegate = self;
    NSString *infoString = [settingDict objectForKey:@"originalContent"];
    if ([infoString isMemberOfClass:[NSNull class]] || [infoString isEqualToString:@""]) {
        infoString = nil;
    }
    NSString *defaultString = [settingDict objectForKey:@"defaultInfo"];
    modifyTF.text = infoString;
    modifyTF.placeholder = defaultString;
    UIView *accountSpaceView = [[UIView alloc]init];
    accountSpaceView.backgroundColor = [UIColor clearColor];
    accountSpaceView.frame = CGRectMake(0, 0, 10, 10);
    [modifyTF setLeftView:accountSpaceView];
    [modifyTF setLeftViewMode:UITextFieldViewModeAlways];
    
    NSIndexPath *indexPath = [self.settingDict objectForKey:@"indexPath"];
    
    if (indexPath.section == 1) {
        UILabel *tiplabel = [[UILabel alloc] init];
        tiplabel.backgroundColor = [UIColor clearColor];
        tiplabel.textColor = [UIColor redColor];
        tiplabel.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        tiplabel.frame = CGRectMake(modifyTF.frame.origin.x, modifyTF.frame.origin.y + modifyTF.frame.size.height + 5, 300, 20);
        [self.view addSubview:tiplabel];
        tiplabel.text = @"改个欢乐的昵称，让小伙伴对你印象深刻";
    }
    
    if (indexPath.section == 4) {
        modifyTF.hidden = YES;
        self.lineImage.hidden = YES;
        
        CGFloat field_height = 50.0;
        NSString *signString = infoString;
        
        field_height = 100;
        self.contentField = [[CPTextViewPlaceholder alloc] init];
        contentField.layer.borderWidth = 1.0;
        contentField.layer.borderColor = [[UIColor clearColor] CGColor];
        contentField.layer.cornerRadius = 2.0f;
        contentField.layer.masksToBounds = YES;
        self.contentField.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        self.contentField.frame = CGRectMake(10, 20, [[UIScreen mainScreen] bounds].size.width - 20, field_height);
        self.contentField.editable = YES;
        self.contentField.backgroundColor = [UIColor whiteColor];
        self.contentField.returnKeyType = UIReturnKeyDefault;
        self.contentField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        UIBarButtonItem *finishButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finish:)];
        finishButton.title = @"完成";
        NSArray *bArray = [NSArray arrayWithObjects:finishButton, nil];
        UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 33)];//创建工具条对象
        tb.items = bArray;
        contentField.inputAccessoryView = tb;//将工具条添加到UITextView的响应键盘
        
        self.contentField.text = signString;
        self.contentField.placeholder = defaultString;
        [self.view addSubview:contentField];
        [contentField becomeFirstResponder];
        modifyTF.hidden = YES;
    }
    else{
//        [modifyTF becomeFirstResponder];
    }
    
    UIBarButtonItem *distributeItem = [[UIBarButtonItem alloc] init];
    distributeItem.title = @"保存";
    distributeItem.tintColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.9) {
        distributeItem.tintColor = [UIColor redColor];
    }
    distributeItem.target = self;
    distributeItem.action = @selector(saveInfo:);
    self.navigationItem.rightBarButtonItem = distributeItem;
}

-(void)saveInfo:(id)sender
{
    if ([modifyTF isFirstResponder]) {
        [modifyTF resignFirstResponder];
    }
    
    
}

- (void)modifyUserWithParam:(NSDictionary *)param
{
    NSString *modifyPath = [NSString stringWithFormat:@"%@%@",BASEURL,UPDATEUSERINFO];
    [self showHudInView:self.view hint:@"修改中..."];
    NSDictionary *paramsDict = @{@"jsonDate":[param JSONString]};
   
}

//获取用户的个人信息
- (void)getUserInfo
{
    NSString *getUserInfoPath = [NSString stringWithFormat:@"%@%@",BASEURL,GETUSERINFO];
    NSString *username = [[Tool getUserDict] objectForKey:USERACCOUNTKEY];
    NSDictionary *params = @{@"username":username};
    
}

-(void)finish:(id)sender
{
    if ([contentField isFirstResponder]) {
        [contentField resignFirstResponder];
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
