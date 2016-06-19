//
//  HeUserVC.m
//  kunyuan
//
//  Created by HeDongMing on 16/6/16.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeUserVC.h"
#import "HeBaseTableViewCell.h"

#define COMMENTBUTTONTAG 100
#define COLLECTBUTTONTAG 200

@interface HeUserVC ()
@property(strong,nonatomic)IBOutlet UITableView *userTable;
@property(strong,nonatomic)NSArray *dataArray;
@property(strong,nonatomic)NSArray *iconArray;
@property(strong,nonatomic)UIImageView *userImage;
@property(strong,nonatomic)UILabel *userLabel;

@end

@implementation HeUserVC
@synthesize userTable;
@synthesize dataArray;
@synthesize iconArray;
@synthesize userImage;
@synthesize userLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        label.text = @"我";
        [label sizeToFit];
        self.title = @"我";
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
    dataArray = @[@"我的订单",@"待付款",@"待使用",@"待评价",@"退款/售后"];
    iconArray = @[@"user_order_icon",@"user_order_waitPay",@"user_order_waitUse",@"user_order_waitComment",@"user_order_drawback"];
}

- (void)initView
{
    [super initView];
    userTable.backgroundView = nil;
    userTable.backgroundColor = [UIColor colorWithWhite:240.0 / 255.0 alpha:1.0];
    [Tool setExtraCellLineHidden:userTable];
    
    CGFloat headerH = 200;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headerH)];
    headerView.backgroundColor = APPDEFAULTORANGE;
    headerView.userInteractionEnabled = YES;
    userTable.tableHeaderView = headerView;
    
    CGFloat imageW = 90;
    CGFloat imageH = 90;
    CGFloat imageX = (SCREENWIDTH - imageW) / 2.0;
    CGFloat imageY = (headerH - imageH) / 2.0 - 30;
    userImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_placeholder_icon"]];
    userImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
    userImage.layer.cornerRadius = imageW / 2.0;
    userImage.layer.masksToBounds = YES;
    userImage.layer.borderWidth = 2.0;
    userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    [headerView addSubview:userImage];
    
    userLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageY + imageH + 5, SCREENWIDTH, 30)];
    userLabel.text = @"test";
    userLabel.backgroundColor = [UIColor clearColor];
    userLabel.textColor = [UIColor whiteColor];
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.font = [UIFont systemFontOfSize:17.0];
    [headerView addSubview:userLabel];
    
    CGFloat buttonX = 0;
    CGFloat buttonW = SCREENWIDTH / 2.0;
    CGFloat buttonH = 40;
    CGFloat buttonY = headerH - buttonH;
    UIButton *commentBtn = [self getButton:CGRectMake(buttonX, buttonY, buttonW, buttonH) title:@"评价" image:@"user_comment_icon"];
    [headerView addSubview:commentBtn];
    
    commentBtn.tag = COMMENTBUTTONTAG;
    
    UIButton *collectBtn = [self getButton:CGRectMake(buttonX + buttonW, buttonY, buttonW, buttonH) title:@"收藏" image:@"user_collect_icon"];
    [headerView addSubview:collectBtn];
    collectBtn.tag = COLLECTBUTTONTAG;
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH / 2.0 - 0.5, buttonY + 5, 1, buttonH - 10)];
    sepLine.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:sepLine];
    
    [commentBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [collectBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClick:(UIButton *)button
{

}

-(UIButton *)getButton:(CGRect) frame title:(NSString *) title image:(NSString *) image
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[Tool buttonImageFromColor:[UIColor colorWithRed:5.0 /255.0 green:182.0 /255.0 blue:164.0 /255.0 alpha:1.0] withImageSize:frame.size] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    return btn;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserTableViewCell";
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    HeBaseTableViewCell *cell = (HeBaseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[HeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor blackColor];
    
    NSString *imageName = iconArray[row];
    NSString *title = dataArray[row];
    
    CGFloat iconX = 5;
    CGFloat iconY = 10;
    CGFloat iconH = cellsize.height - 2 * iconY;
    CGFloat iconW = iconH;
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.layer.masksToBounds = YES;
    icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [cell.contentView addSubview:icon];
    
    CGFloat titleLabelX = iconX + iconW + 10;
    CGFloat titleLabelY = 0;
    CGFloat titleLabelH = cellsize.height;
    CGFloat titleLabelW = cellsize.width - titleLabelX - 5;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.text = [NSString stringWithFormat:@"%@",title];
    [cell addSubview:titleLabel];
    
    return cell;
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
