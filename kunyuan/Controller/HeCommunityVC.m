//
//  HeCommunityVC.m
//  kunyuan
//
//  Created by HeDongMing on 16/6/16.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeCommunityVC.h"
#import "DFCommunityLineItem.h"

@interface HeCommunityVC ()
@property(strong,nonatomic)NSMutableArray *dataSource;
@property(strong,nonatomic)NSMutableDictionary *dataDict;

@end

@implementation HeCommunityVC
@synthesize dataSource;
@synthesize dataDict;

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
        label.text = @"社区";
        [label sizeToFit];
        self.title = @"社区";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
    [self translateToDFLineModel];
}

- (void)initializaiton
{
    [super initializaiton];
    dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    dataDict = [[NSMutableDictionary alloc] initWithCapacity:0];
}

- (void)initView
{
    [super initView];
    //设置头部
    [self setHeader];
}

-(void)setHeader
{
    self.tableView.tableHeaderView = nil;
}

//将自己的model转换成DFLineModel
- (void)translateToDFLineModel
{
    DFCommunityLineItem *communityItem = [[DFCommunityLineItem alloc] init];
    communityItem.itemId = @"1";
    communityItem.itemType = LineItemTypeCommunity;
    communityItem.userId = @"123";
    communityItem.userAvatar = @"http://ww2.sinaimg.cn/mw690/e286b988gw1f51jpk6y1mj20h609ejsq.jpg";
    communityItem.userNick = @"舌尖上的享受";
    communityItem.subtext = @"美食陪你开启五一宅家模式";
    communityItem.text = @"赛后在接受采访时，勇士前锋德雷蒙德-格林表示这支骑士配得上总冠军奖杯。“你必须要向他们致敬，在1-3落后的情况下，他们没有放弃，而是一直在战斗，他们配得上胜利。”格林说道。";
    communityItem.isLike = YES;
    
    NSMutableArray *scrImages = [[NSMutableArray alloc] initWithCapacity:0];
    [scrImages addObject:@"http://ww4.sinaimg.cn/mw690/9e5389bbjw1f51ms6wn2xj20m80i0myr.jpg"];
    [scrImages addObject:@"http://ww1.sinaimg.cn/bmiddle/7049c17bjw1f4wh51ukg4j20hs0cpq50.jpg"];
    communityItem.srcImages = scrImages;
    
    NSMutableArray *thumbImages = [[NSMutableArray alloc] initWithCapacity:0];
    [thumbImages addObject:@"http://ww4.sinaimg.cn/mw690/9e5389bbjw1f51ms6wn2xj20m80i0myr.jpg"];
    [thumbImages addObject:@"http://ww1.sinaimg.cn/bmiddle/7049c17bjw1f4wh51ukg4j20hs0cpq50.jpg"];
    communityItem.thumbImages =  thumbImages;
    
    communityItem.width = SCREENWIDTH;
    communityItem.height = 300;
    
    communityItem.location = @"中国珠海";
    communityItem.ts = 1235678 * 1000;
    //点赞部分
    
//    DFLineLikeItem *like = [[DFLineLikeItem alloc] init]
//    NSMutableArray *islikeListArray = [[NSMutableArray alloc] initWithCapacity:0];
//    [islikeListArray addObject:@"格林"];
//    communityItem.likes = [[NSMutableArray alloc] initWithArray:islikeListArray];
//    
//    //评论部分
//    NSMutableArray *commentListArray = [[NSMutableArray alloc] initWithCapacity:0];
//    [commentListArray addObject:@"哈哈"];
//    communityItem.comments = [[NSMutableArray alloc] initWithArray:commentListArray];
    
    [self addItem:communityItem];
    
    [self.tableView reloadData];
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
