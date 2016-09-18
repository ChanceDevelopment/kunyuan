//
//  HeHomepageVC.m
//  kunyuan
//
//  Created by HeDongMing on 16/6/16.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeHomepageVC.h"
#import "HeMainPageTable.h"
#import "HeSearchInfoVC.h"
#import "MJRefresh.h"

@interface HeHomepageVC ()<ServiceFunctionProtocol>
@property(strong,nonatomic)IBOutlet HeMainPageTable *tableview;

@end

@implementation HeHomepageVC
@synthesize tableview;

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
        label.text = @"首页";
        [label sizeToFit];
        self.title = @"首页";
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
}

- (void)initView
{
    [super initView];
    
    [tableview initView];
    [tableview initHeaderView];
    [tableview  setHeaderViewWithDataSource:nil];
    tableview.serviceDelegate = self;
    [Tool setExtraCellLineHidden:tableview];
    
    CGFloat itembuttonW = 25;
    CGFloat itembuttonH = 25;
    UIImage *searchIcon = [UIImage imageNamed:@"icon_query_search"];
    @try {
        itembuttonW = searchIcon.size.width / searchIcon.size.height * itembuttonH;
    } @catch (NSException *exception) {
        itembuttonW = 25;
    } @finally {
        
    }
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, itembuttonW, itembuttonH)];
    [searchButton setBackgroundImage:searchIcon forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(barButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.tag = 1;
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block,刷新
        [self.tableview.header performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.0];
    }];
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.tableview.footer.automaticallyHidden = YES;
        self.tableview.footer.hidden = NO;
        // 进入刷新状态后会自动调用这个block，加载更多
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.0];
    }];
}

- (void)endRefreshing
{
    [self.tableview.footer endRefreshing];
    self.tableview.footer.hidden = YES;
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.tableview.footer.automaticallyHidden = YES;
        self.tableview.footer.hidden = NO;
        // 进入刷新状态后会自动调用这个block，加载更多
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.0];
    }];
}

- (void)barButtonItemClick:(UIBarButtonItem *)item
{
    HeSearchInfoVC *searchInfoVC = [[HeSearchInfoVC alloc] init];
    searchInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchInfoVC animated:YES];
}

- (void)loadBanner
{
    NSMutableArray *bannerDataSource = nil;
}

- (void)loadFood
{

}

- (void)selectIndex:(NSInteger)selectIndex
{
    NSLog(@"selectIndex");
}

- (void)functionButtonClick:(UIButton *)sender
{
    NSLog(@"functionButtonClick");
}

- (void)gotoWebWithUrl:(NSString *)url
{
    NSLog(@"gotoWeb");
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
