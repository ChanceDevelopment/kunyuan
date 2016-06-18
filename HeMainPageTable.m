//
//  HeMainPageTable.m
//  fuyang
//
//  Created by HeDongMing on 16/1/6.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeMainPageTable.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "HeMainPageFirstCell.h"
#import "HeMainPageSecondCell.h"
#import "HeMainPageThirdCell.h"

#define HEADVIEWHEIGH 280
#define SCROLLTAG 300

@implementation HeMainPageTable
@synthesize mydataSource;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)initView
{
    self.dataSource = self;
    self.delegate = self;
    self.showsVerticalScrollIndicator = NO;
    [Tool setExtraCellLineHidden:self];
    self.backgroundView = nil;
    self.backgroundColor = RGB(238.0, 238.0, 238.0, 1);
}

- (void)initHeaderViewWithArray:(NSArray *)array
{
    if ([array count] == 0) {
        return;
    }
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *urlArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dict = array[i];
        NSString *img = dict[@"img"];
        NSString *url = dict[@"url"];
        if ([img isMemberOfClass:[NSNull class]] || img == nil) {
            img = @"";
        }
        if ([url isMemberOfClass:[NSNull class]] || url == nil) {
            url = @"";
        }
        [imageArray addObject:img];
        [urlArray addObject:url];
    }
    UIView *headView = self.tableHeaderView;
    
    UIView *scroll = [headView viewWithTag:SCROLLTAG];
    [scroll removeFromSuperview];
    
    NSArray *UrlStringArray = imageArray;
    
    
    NSArray *titleArray = nil;
    
    
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置
    
    CGFloat picViewHeight = 120;
    DCPicScrollView  *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, picViewHeight) WithImageUrls:UrlStringArray];
    
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    picView.titleData = titleArray;
    
    //占位图片,你可以在下载图片失败处修改占位图片
    
    picView.placeImage = [UIImage imageNamed:@"comonDefaultImage"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    
    [picView setImageViewDidTapAtIndex:^(NSInteger index) {
        NSString *url = nil;
        @try {
            url = urlArray[index];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        [self.serviceDelegate gotoWebWithUrl:url];
        
    }];
    
    //default is 2.0f,如果小于0.5不自动播放
    picView.AutoScrollDelay = 2.0f;
    //    picView.textColor = [UIColor redColor];
    
    [headView addSubview:picView];
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];
}

- (void)initHeaderView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, HEADVIEWHEIGH)];
    headView.backgroundColor = RGB(238.0, 238.0, 238.0, 1);
    headView.userInteractionEnabled = YES;
    self.tableHeaderView = headView;
    
    NSArray *UrlStringArray = @[@"title_logo1.jpg",
                                @"title_logo2.jpg"];
    
    
    NSArray *titleArray = @[@"title_logo1.jpg",
                            @"title_logo2.jpg"];;
    
    
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置
    
    CGFloat picViewHeight = 120;
    DCPicScrollView  *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, picViewHeight) WithImageUrls:UrlStringArray];
    picView.tag = SCROLLTAG;
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    picView.titleData = titleArray;
    
    //占位图片,你可以在下载图片失败处修改占位图片
    
    picView.placeImage = [UIImage imageNamed:@"comonDefaultImage"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    
    [picView setImageViewDidTapAtIndex:^(NSInteger index) {
        switch (index) {
            case 0:
            {
//                [self.serviceDelegate gotoWebWithUrl:@"http://218.108.140.246:8086/test/gzgz.html"];
                break;
            }
            case 1:{
                [self.serviceDelegate gotoWebWithUrl:@"http://218.108.140.246:8086/test/gzgz.html"];
                break;
            }
            default:
                break;
        }
        
    }];
    
    //default is 2.0f,如果小于0.5不自动播放
    picView.AutoScrollDelay = 2.0f;
    //    picView.textColor = [UIColor redColor];
    
    [headView addSubview:picView];
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];
    
    CGFloat viewY = picViewHeight;
    CGFloat viewH = HEADVIEWHEIGH - picViewHeight;
    UIView *buttonBGView = [[UIView alloc] initWithFrame:CGRectMake(0, viewY, SCREENWIDTH, viewH)];
    buttonBGView.userInteractionEnabled = YES;
    buttonBGView.backgroundColor = [UIColor whiteColor];
    [self addSubview:buttonBGView];
    
    NSArray *icon_titleArray = @[@[@"美食",@"超市",@"鲜疏购",@"甜品饮品"],@[@"酒店",@"专送",@"夜宵",@"药材"]];
    NSArray *icon_ImageArray = @[@[@"icon_home_food",@"icon_home_market",@"icon_home_fruits",@"icon_home_drink"],@[@"icon_home_hotel",@"icon_home_takeaway",@"icon_home_supper",@"icon_home_drug"]];
    [self addButtonToView:buttonBGView withImage:icon_ImageArray andTitle:icon_titleArray];
    
    CGFloat headH = buttonBGView.frame.size.height + picViewHeight;
    CGRect headframe = headView.frame;
    headframe.size.height = headH;
    headView.frame = headframe;
    headView.userInteractionEnabled = YES;
    self.tableHeaderView = headView;
}

//添加按钮
- (void)addButtonToView:(UIView *)buttonBG withImage:(NSArray *)imagearray andTitle:(NSArray *)nameArray
{
    CGFloat viewW = buttonBG.frame.size.width;
    CGFloat viewH = buttonBG.frame.size.height;
    NSInteger buttonCountRow = [(NSArray *)[imagearray objectAtIndex:0] count];
    NSInteger buttonCountColumn = [imagearray count];
    CGFloat buttonX = 20;
    CGFloat buttonHDistance = 30;
    CGFloat buttonVDistance = 5;
    CGFloat buttonY = 10;
    CGFloat buttonW = (viewW - (buttonCountRow - 1) * buttonHDistance - 2 * buttonX) / ((CGFloat)buttonCountRow);
    CGFloat buttonH = buttonW * 3 / 2.0;
    
    CGFloat bgY = 0;
    for (int i = 0; i < [imagearray count]; i++) {
        for (int j = 0; j < [(NSArray *)[imagearray objectAtIndex:i] count]; j++) {
            UIImage *image = [UIImage imageNamed:[[imagearray objectAtIndex:i] objectAtIndex:j]];
            UIImageView *subImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonW, buttonW)];
            subImage.image = image;
            UIImageView *iconImage = [[UIImageView alloc] init];
            [iconImage addSubview:subImage];
            iconImage.backgroundColor = [UIColor whiteColor];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(buttonX + j * buttonHDistance + j * buttonW, buttonY + i * buttonVDistance + i * buttonH, buttonW, buttonH);
            button.tag = i * [(NSArray *)[imagearray objectAtIndex:i] count] + j;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [buttonBG addSubview:button];
            
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont fontWithName:@"Helvetica" size:11];
            label.frame = CGRectMake(0, buttonH - 20, buttonW, 20);
            label.text = [[nameArray objectAtIndex:i] objectAtIndex:j];
            label.textAlignment = NSTextAlignmentCenter;
            [button addSubview:label];
            
            iconImage.frame = button.frame;
            [buttonBG addSubview:iconImage];
            [buttonBG addSubview:button];
            bgY = button.frame.origin.y + button.frame.size.height + buttonY;
            
        }
        
    }
    CGRect frame = buttonBG.frame;
    frame.size.height = bgY;
    buttonBG.frame = frame;
}

- (void)buttonClick:(UIButton *)sender
{
    NSLog(@"%@",sender);
    if ([self.serviceDelegate respondsToSelector:@selector(functionButtonClick:)]) {
        [self.serviceDelegate functionButtonClick:sender];
    }
}

- (void)setHeaderViewWithDataSource:(id)userInfo
{

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
        {
            CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
            static NSString *cellIndentifier = @"HeMainPageFirstCell";
            HeMainPageFirstCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[HeMainPageFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier withTitle:@"特别报道" color:[UIColor redColor] cellSize:cellsize];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            return cell;
            break;
        }
        default:
        {
            CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
            static NSString *cellIndentifier = @"HeMainPageSecondCell";
            HeMainPageSecondCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[HeMainPageSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellsize];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            return cell;
            break;
        }
            break;
    }
    
    
    return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    switch (section) {
        case 0:
        {
            return 150.0;
            break;
        }
        
        default:
            break;
    }
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20)];
    headerview.backgroundColor = RGB(238, 238, 238, 1);
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
