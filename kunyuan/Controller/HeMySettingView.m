//
//  HeMySettingView.m
//  huobao
//
//  Created by HeDongMing on 14-7-10.
//  Copyright (c) 2014年 何 栋明. All rights reserved.
//

#import "HeMySettingView.h"
#import "HeLoginVC.h"
#import "ZJSwitch.h"

@interface HeMySettingView ()
@property(strong,nonatomic)NSDictionary *localDic;
@property(strong,nonatomic)NSMutableDictionary *settingDic;
@property(strong,nonatomic)NSMutableDictionary *switchDic;

@end

@implementation HeMySettingView
@synthesize settingtable;
@synthesize dataSource;
@synthesize loadSucceedFlag;
@synthesize localDic;
@synthesize settingDic;
@synthesize appupdateUrl;
@synthesize switchDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"系统设置";
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
    //应用的本地信息
    self.localDic =[[NSBundle mainBundle] infoDictionary];
    
    switchDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSString *libraryfolderPath = [NSHomeDirectory() stringByAppendingString:@"/Library"];
    NSString *myPath = [libraryfolderPath stringByAppendingPathComponent:@"FuYangDocument"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:myPath]) {
        [fm createDirectoryAtPath:myPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *documentString = [myPath stringByAppendingPathComponent:@"UserData"];
    
    if(![fm fileExistsAtPath:documentString])
    {
        [fm createDirectoryAtPath:documentString withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filename = [documentString stringByAppendingPathComponent:@"setting.plist"];
    settingDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    settingDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    if (settingDic == nil) {
        settingDic = [[NSMutableDictionary alloc] initWithCapacity:0];
         [settingDic setObject:[NSNumber numberWithBool:YES] forKey:NEWSNOTIFY];
        
        [settingDic setObject:[NSNumber numberWithBool:YES] forKey:PLAYSOUND];
        
        [settingDic setObject:[NSNumber numberWithBool:NO] forKey:VIBRATION];
        
        [settingDic setObject:[NSNumber numberWithBool:YES] forKey:LOUDSPEAKER];
        
        
        [settingDic setObject:[NSNumber numberWithBool:YES] forKey:FRIENDNEWSREMIND];
        
        [settingDic setObject:[NSNumber numberWithBool:YES] forKey:CIRCLEREPLY];
        
        [settingDic setObject:[NSNumber numberWithBool:YES] forKey:ACTIVITYRECOMMEND];
        
        [settingDic setObject:[NSNumber numberWithBool:YES] forKey:ACTIVITYREMIND];
        [settingDic setObject:[NSNumber numberWithBool:YES] forKey:SYSTEMNOTIFY];
        
        [settingDic setObject:[NSNumber numberWithBool:YES] forKey:SHAREACTIVITYAUTO];
        [settingDic writeToFile:filename atomically:YES];
        
    }
    [self initView];
    [self initControl];
}

-(void)initControl
{
    dataSource = [[NSArray alloc] initWithObjects:@[@"接收推送消息通知",@"声音",@"震动"], nil];
}

-(void)initView
{
    self.settingtable.delegate = self;
    self.settingtable.dataSource = self;
}

-(void)backTolastView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)switchChange:(UISwitch *)sender
{
    //活动信息自动分享
    
    NSString *libraryfolderPath = [NSHomeDirectory() stringByAppendingString:@"/Library"];
    NSString *myPath = [libraryfolderPath stringByAppendingPathComponent:@"FuYangDocument"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:myPath]) {
        [fm createDirectoryAtPath:myPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *documentString = [myPath stringByAppendingPathComponent:@"UserData"];
    
    if(![fm fileExistsAtPath:documentString])
    {
        [fm createDirectoryAtPath:documentString withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filename = [documentString stringByAppendingPathComponent:@"setting.plist"];
    NSInteger sendertag = sender.tag;

    BOOL isOn = sender.on;
    
    
}

- (void)showAlert
{
    
    [self savePushOptions];
    
}

#pragma mark - action

- (void)savePushOptions
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[dataSource objectAtIndex:section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"SettingTableViewCell";
    UITableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    cell.textLabel.text = [[dataSource objectAtIndex:section] objectAtIndex:row];
    CGFloat offset = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.9) {
        offset = 15;
    }
    CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    CGFloat cellH = [settingtable rectForRowAtIndexPath:indexPath].size.height;
    
    NSInteger tag = [[NSString stringWithFormat:@"%d%d",(int)section,(int)row] integerValue];
    NSString *switchKey = [NSString stringWithFormat:@"%ld",tag];
    ZJSwitch *switchControl = [switchDic objectForKey:switchKey];
    if (!switchControl) {
        switchControl = [[ZJSwitch alloc] init];
        switchControl.frame = CGRectMake(cellsize.width - 62 - offset, (cellH - 25.0)/2.0, 44, 25);
        
        switchControl.tag = tag;
        [switchDic setObject:switchControl forKey:switchKey];
    }
    
    
    
    [switchControl addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:switchControl];
    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                {
                    switchControl.on = [[settingDic objectForKey:NEWSNOTIFY] boolValue];
                    break;
                }
                case 1:
                {
                    switchControl.on = [[settingDic objectForKey:PLAYSOUND] boolValue];
                    break;
                }
                case 2:
                {
                    switchControl.on = [[settingDic objectForKey:VIBRATION]boolValue];
                    break;
                }
                
               
                default:
                    break;
            }
            break;
        }
        case 1:{
            switch (row) {
                case 0:
                {
                    switchControl.on = [[settingDic objectForKey:LOUDSPEAKER] boolValue];
                    break;
                }
                case 1:
                {
                    switchControl.on = [[settingDic objectForKey:CIRCLEREPLY] boolValue];
                    break;
                }
                case 2:
                {
                    switchControl.on = [[settingDic objectForKey:ACTIVITYRECOMMEND] boolValue];
                    break;
                }
                case 3:
                {
                    switchControl.on = [[settingDic objectForKey:ACTIVITYREMIND] boolValue];
                    break;
                }
                case 4:
                {
                    switchControl.on = [[settingDic objectForKey:SYSTEMNOTIFY] boolValue];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    return cell;

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"消息设置";
            break;
        case 1:
            return @"聊天设置";
            break;
        default:
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}



-(void)clearPicture
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *folderPath = [NSHomeDirectory() stringByAppendingString:@"/tmp"];
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    
    NSString *libraryfolderPath = [NSHomeDirectory() stringByAppendingString:@"/Library"];
    NSString* LibraryfileName = [libraryfolderPath stringByAppendingPathComponent:@"EaseMobLog"];
    childFilesEnumerator = [[manager subpathsAtPath:LibraryfileName] objectEnumerator];
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [LibraryfileName stringByAppendingPathComponent:fileName];
        BOOL result = [manager removeItemAtPath:fileAbsolutePath error:nil];
        if (result) {
            NSLog(@"remove EaseMobLog succeed");
        }
        else{
            NSLog(@"remove EaseMobLog faild");
        }
        
    }
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [path objectAtIndex:0];
    childFilesEnumerator = [[manager subpathsAtPath:cachesPath] objectEnumerator];
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [cachesPath stringByAppendingPathComponent:fileName];
        NSRange range = [fileAbsolutePath rangeOfString:@"umeng"];
        if (range.length == 0) {
            BOOL result = [manager removeItemAtPath:fileAbsolutePath error:nil];
            if (result) {
                NSLog(@"remove caches succeed");
            }
            else{
                NSLog(@"remove caches faild");
            }
        }
        
    }
    
    NSString *myPath=[libraryfolderPath stringByAppendingPathComponent:@"HuoBaoDocument"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:myPath]) {
        [fm createDirectoryAtPath:myPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    
    NSString *asynImagePath=[myPath stringByAppendingPathComponent:@"AsynImage"];
    if(![fm fileExistsAtPath:asynImagePath])
    {
        [fm createDirectoryAtPath:asynImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    childFilesEnumerator = [[manager subpathsAtPath:asynImagePath] objectEnumerator];
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [asynImagePath stringByAppendingPathComponent:fileName];
        BOOL result = [manager removeItemAtPath:fileAbsolutePath error:nil];
        if (result) {
            NSLog(@"remove asynimage succeed");
        }
        else{
            NSLog(@"remove asynimage faild");
        }
    }
}

-(void)userWantLoginout
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"注销登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 10;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        switch (buttonIndex) {
            case 0:
            {
                break;
            }
            case 1:
            {
//                [self didLoginFromOtherDevice];
                break;
            }
            default:
                break;
        }
    }
    else{
        switch (buttonIndex) {
            case 0:
                
                break;
            case 1:{
                NSURL *updateurl = [[NSURL alloc] initWithString:self.appupdateUrl];
                [[UIApplication sharedApplication] openURL:updateurl];
                break;
            }
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
