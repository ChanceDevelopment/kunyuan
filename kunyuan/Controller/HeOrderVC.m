//
//  HeOrderVC.m
//  kunyuan
//
//  Created by HeDongMing on 16/6/16.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeOrderVC.h"
#import "HeOrderCell.h"

@interface HeOrderVC ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)IBOutlet UITableView *orderTable;
@property(strong,nonatomic)NSMutableArray *dataArray;

@end

@implementation HeOrderVC
@synthesize orderTable;
@synthesize dataArray;

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
        label.text = @"当前订单";
        [label sizeToFit];
        self.title = @"订单";
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
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)initView
{
    [super initView];
    orderTable.backgroundView = nil;
    orderTable.backgroundColor = [UIColor colorWithWhite:240.0 / 255.0 alpha:1.0];
    [Tool setExtraCellLineHidden:orderTable];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OrderTableViewCell";
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    HeOrderCell *cell = (HeOrderCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[HeOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellSize:cellsize];
    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0;
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
