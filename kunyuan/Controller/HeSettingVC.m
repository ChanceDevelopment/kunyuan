//
//  HeSettingVC.m
//  fuyang
//
//  Created by Tony on 16/1/26.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeSettingVC.h"
#import "HeMySettingView.h"
#import "HeInstructionView.h"
#import "BrowserView.h"

@interface HeSettingVC ()
@property(strong,nonatomic)NSArray *dataSource;
@property(strong,nonatomic)NSArray *icon_dataSource;
@property(strong,nonatomic)IBOutlet UITableView *settingTable;

@end

@implementation HeSettingVC
@synthesize dataSource;
@synthesize settingTable;
@synthesize icon_dataSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"设置";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
}

- (void)initializaiton
{
    [super initializaiton];
    dataSource = @[@[@"消息设置"],@[@"新手引导",@"关于我们"],@[@"版本信息",@"意见反馈",@"二维码分享"]];
    icon_dataSource = @[@[@"setting_comm"],@[@"setting_guide",@"setting_about_us"],@[@"setting_version",@"setting_excetion",@"setting_share"]];
    [Tool setExtraCellLineHidden:settingTable];
}

- (void)initView
{
    [super initView];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    CGFloat buttonX = 20;
    CGFloat buttonY = 10;
    CGFloat buttonW = SCREENWIDTH - 2 * buttonX;
    CGFloat buttonH = 45;
    UIButton *loginOffButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    [loginOffButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOffButton dangerStyle];
    [footerView addSubview:loginOffButton];
    [loginOffButton addTarget:self action:@selector(loginOffButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    settingTable.tableFooterView = footerView;
}

- (void)loginOffButtonClick:(UIButton *)button
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定注销本账号？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注销", nil];
    alertview.tag = 10;
    [alertview show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *cellIndentifier = @"HeUserCell";
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    UITableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *string = nil;
    @try {
        string = dataSource[section][row];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.text = [NSString stringWithFormat:@"          %@",string];
    
    CGFloat imageX = 10;
    CGFloat imageY = 8;
    CGFloat imageH = cellSize.height - 2 * imageY;
    CGFloat imageW = imageH;
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    icon.image = [UIImage imageNamed:icon_dataSource[section][row]];
    [cell addSubview:icon];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                {
                    HeMySettingView *mySetingVC = [[HeMySettingView alloc] init];
                    mySetingVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:mySetingVC animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            switch (row) {
                case 0:
                {
                    HeInstructionView *insrtrduceVC = [[HeInstructionView alloc] init];
                    insrtrduceVC.hideEnterButton = YES;
                    insrtrduceVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:insrtrduceVC animated:YES];
                    break;
                }
                case 1:{
                    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"aboutUs"
                                                                         ofType:@"html"];
                    
                    NSString *htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                                      encoding:NSUTF8StringEncoding
                                                                         error:nil];
                    BrowserView *userProtocolVC = [[BrowserView alloc] init];
                    userProtocolVC.htmlContent = [NSString stringWithFormat:@"%@",htmlContent];
                    userProtocolVC.navigationItem.backBarButtonItem.title = @"返回";
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                    label.backgroundColor = [UIColor clearColor];
                    label.font = [UIFont boldSystemFontOfSize:20.0];
                    label.textColor = [UIColor whiteColor];
                    label.textAlignment = NSTextAlignmentCenter;
                    userProtocolVC.navigationItem.titleView = label;
                    label.text = @"关于我们";
                    [label sizeToFit];
                    
                    userProtocolVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:userProtocolVC animated:YES];
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            switch (row) {
                case 0:
                {
                    
                    break;
                }
                case 1:
                {
                    
                    break;
                }
                case 2:
                {
                    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
