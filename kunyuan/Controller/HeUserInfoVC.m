//
//  HeUserInfoVC.m
//  iGangGan
//
//  Created by Tony on 15/12/11.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import "HeUserInfoVC.h"
#import "AsynImageView.h"
#import "HeModifyPasswordVC.h"
#import "HeModifyInfoView.h"
#import "IQActionSheetPickerView.h"
#import "HeForgetPSWView.h"
#import "HeSysbsModel.h"

@interface HeUserInfoVC ()<AddressSelectProtocol>
@property(strong,nonatomic)NSArray *dataSource;
@property(strong,nonatomic)IBOutlet UITableView *userTable;
@property(strong,nonatomic)AsynImageView *headImage;
@property(strong,nonatomic)UIView *bgview;
@property(strong,nonatomic)NSMutableDictionary *imgeData;
@property(strong,nonatomic)NSString *tmpDateString;

@end

@implementation HeUserInfoVC
@synthesize userTable;
@synthesize dataSource;
@synthesize headImage;
@synthesize bgview;
@synthesize imgeData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人资料";
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
    imgeData = [[NSMutableDictionary alloc] initWithCapacity:0];
    dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    [Tool setExtraCellLineHidden:userTable];
    
    dataSource = @[@"头像",@"姓名",@"昵称",@"服务号",@"二维码名片",@"手机号",@"性别",@"生日",@"职业",@"身份证",@"地区",@"最近动态"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo:) name:@"updateUser" object:nil];
}

- (void)initView
{
    [super initView];
    
    headImage = [[AsynImageView alloc] init];
    headImage.placeholderImage = [UIImage imageNamed:@"user"];
    
    NSString *iconAddress = @"";
    NSString *imageURL = [NSString stringWithFormat:@"%@",iconAddress];
    [headImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:headImage.placeholderImage];
    headImage.layer.borderWidth = 0;
    headImage.layer.borderColor = [UIColor clearColor].CGColor;
    
    bgview = [[UIView alloc] init];
    bgview.frame = self.view.frame;
    bgview.backgroundColor = [UIColor colorWithWhite:135.0/255.0 alpha:0.5];
    
}

- (void)updateUserInfo:(NSNotification *)notification
{
    [userTable reloadData];
}

//图片的点击手势
-(void)modifyPicture:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"来自相册",@"来自拍照", nil];
    [sheet showInView:self.headImage];
}





-(void)dateButtonClick:(id)sender withString:(NSString *)datestring
{
    [self.view addSubview:bgview];
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"请选择日期" date:datestring delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    picker.tag = 11;
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker showInView:self.view];
    
    
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    NSString *datestring = [titles componentsJoinedByString:@"-"];
    HeSysbsModel *sysmodel = [HeSysbsModel getSysModel];
    //    sysmodel.user.birthday = datestring;
    //    [birthdayLabel setText:datestring];
    //    self.user.birthday = datestring;
    //    requestID = 4;
    //
    //    NSString *keyword = @"birthday";
    //    NSString *uidstr = [NSString stringWithFormat:@"%d",sysmodel.user.uid];
    //    Dao *shareDao = [Dao sharedDao];
    //    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:datestring,keyword,uidstr,@"uid",nil];
    //    shareDao.daoDelegate = self;
    //    [shareDao editInfoWith:dict];
    
   
    
}


- (void)showLocateView:(id)sender
{
    
    [self.view addSubview:bgview];
    
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"常出没地" delegate:self];
    locateView.selectDelegate = self;
    locateView.tag = 10;
    [locateView showInView:self.view];
}

-(void)selectWithlocation:(TSLocation *)location
{
    NSString *state = location.state;
    NSString *city = location.city;
    //    HeSysbsModel *sysmodel = [HeSysbsModel getSysbsModel];
    //    self.user.address = [NSString stringWithFormat:@"%@ %@",state,city];
    //    requestID = 5;
    //
    //    NSString *keyword = @"address";
    //    NSString *uidstr = [NSString stringWithFormat:@"%d",sysmodel.user.uid];
    //    Dao *shareDao = [Dao sharedDao];
    //    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.user.address,keyword,uidstr,@"uid",nil];
    //    shareDao.daoDelegate = self;
    //    [shareDao editInfoWith:dict];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 10) {
        [self.bgview removeFromSuperview];
        TSLocateView *locateView = (TSLocateView *)actionSheet;
        TSLocation *location = locateView.locate;
        NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
        //You can uses location to your application.
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            NSLog(@"Select");
        }
        
        return;
    }
    if (actionSheet.tag == 11) {
        [self.bgview removeFromSuperview];
        return;
    }
    
    switch (buttonIndex) {
        case 0:
        {
            [self pickerPhotoLibrary];
            break;
        }
        case 1:{
            //查看大图
            [self pickerCamer];
            break;
        }
        case 2:
            //取消
            break;
        default:
            break;
    }
}


#pragma mark -
#pragma mark ImagePicker method
//从相册中打开照片选择画面(图片库)：UIImagePickerControllerSourceTypePhotoLibrary
//启动摄像头打开照片摄影画面(照相机)：UIImagePickerControllerSourceTypeCamera

//按下相机触发事件
-(void)pickerCamer
{
    //照相机类型
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断属性值是否可用
    if([UIImagePickerController isSourceTypeAvailable:sourceType]){
        //UIImagePickerController是UINavigationController的子类
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
        //设置可以编辑
        imagePicker.allowsEditing = YES;
        //设置类型为照相机
        imagePicker.sourceType = sourceType;
        //进入照相机画面
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)uploadProfile
{
    [self uploadOneFileData:[imgeData valueForKey:@"dataKey"] imgType:[imgeData valueForKey:@"imageTypeKey"] imgName:[NSString stringWithFormat:@"%@",[imgeData valueForKey:@"fileNameKey" ]]];
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}




//当按下相册按钮时触发事件
-(void)pickerPhotoLibrary
{
    //图片库类型
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *photoAlbumPicker = [[UIImagePickerController alloc]init];
    photoAlbumPicker.delegate = self;
    photoAlbumPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //设置可以编辑
    photoAlbumPicker.allowsEditing = YES;
    //设置类型
    photoAlbumPicker.sourceType = sourceType;
    //进入图片库画面
    [self presentViewController:photoAlbumPicker animated:YES completion:nil];
}


#pragma mark -
#pragma mark imagePickerController method
//当拍完照或者选取好照片之后所要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    CGSize sizeImage = image.size;
    float a = [self getSize:sizeImage];
    if (a>0) {
        CGSize size = CGSizeMake(sizeImage.width/a, sizeImage.height/a);
        image = [self scaleToSize:image size:size];
    }
    
    CGSize imagesize = image.size;
    CGFloat width = imagesize.width;
    CGFloat hight = imagesize.height;
    CGFloat sizewidth = width;
    if (hight < width) {
        sizewidth = hight;
    }
    CGRect newframe = CGRectMake(0, 0, sizewidth, sizewidth);
    UIImage *scaleImage = [self imageFromImage:image inRect:newframe];
    headImage.image = scaleImage;
    
    NSData *data;
    NSString *imgTypeStr;
    
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString *timeStr   = [dateformatter stringFromDate:senddate];
    NSString * imageStr = nil;
    data = UIImagePNGRepresentation(scaleImage);
    imgTypeStr = @"image/png";//jpeg和安卓保持一致
    imageStr = [NSString stringWithFormat:@"%@sell_headImage.png",timeStr];
    NSArray *array = [imageStr componentsSeparatedByString:@":"];
    NSMutableString *mutableString = [[NSMutableString alloc] initWithCapacity:0];
    for (NSString *str in array) {
        [mutableString appendString:str];
    }
    //把需要的图片信息保存到imgeData中
    [imgeData setObject:data forKey:@"dataKey"];
    [imgeData setObject:imgTypeStr forKey:@"imageTypeKey"];
    [imgeData setObject:mutableString forKey:@"fileNameKey"];
    
    /*
     image就是所需要的头像
     */
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self showHudInView:self.view hint:@"图片上传中"];
        [self performSelector:@selector(uploadProfile) withObject:nil afterDelay:0.2];
    }];
}


//相应取消动作
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(float)getSize:(CGSize)size
{
    float a = size.width/480;
    if (a > 1) {
        return a;
    }
    else
        return -1;
    
    
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *cellIndentifier = @"HeUserInfoCell";
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    UITableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *string = nil;
    @try {
        string = dataSource[row];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",string];
    cell.textLabel.textColor = [UIColor grayColor];
    
    CGFloat labelW = 200;
    CGFloat labelH = cellSize.height;
    CGFloat labelY = 0;
    CGFloat labelX = SCREENWIDTH - 10 - labelW;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX , labelY, labelW, labelH)];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont systemFontOfSize:17.0];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.textAlignment = NSTextAlignmentRight;
    [cell addSubview:contentLabel];
    
    User *user = [HeSysbsModel getSysModel].user;
    
    NSString *startDateString = user.birthday;
    self.tmpDateString = startDateString;
    
    NSString *content = nil;
    switch (section) {
        case 0:
            switch (row) {
                case 0:
                {
                    
                    CGFloat imageY = 10;
                    CGFloat imageH = cellSize.height - 2 * imageY;
                    CGFloat imageW = imageH;
                    CGFloat imageX = SCREENWIDTH - imageW - 20;
                    
                    CGRect imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
                    headImage.frame = imageFrame;
                    [cell.contentView addSubview:headImage];
                    break;
                }
                case 1:
                {
                    //姓名
                    content = user.name;
                    if (content == nil || [content isEqualToString:@""]) {
                        content = @"暂时没有填写";
                    }
                    break;
                }
                case 2:
                {
                    //昵称
                    content = user.nickname;
                    if (content == nil || [content isEqualToString:@""]) {
                        content = @"暂时没有填写";
                    }
                    break;
                }
                case 3:
                {
                    //服务号
                    content = user.username;
                    if (content == nil || [content isEqualToString:@""]) {
                        content = @"暂时没有填写";
                    }
                    break;
                }
                case 4:
                {
                    //二维码
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
                case 5:
                {
                    //手机号
                    content = user.phonenum;
                    if (content == nil || [content isEqualToString:@""]) {
                        content = @"暂时没有填写";
                    }
                    break;
                }
                case 6:
                {
                    //性别
                    if (user.sex == 1) {
                        content = @"女";
                    }
                    else{
                        content = @"男";
                    }
                    break;
                }
                case 7:
                {
                    //生日
                    content = user.birthday;
                    if (content == nil || [content isEqualToString:@""]) {
                        content = @"暂时没有填写";
                    }
                    break;
                }
                case 8:
                {
                    //职业
                    content = user.profession;
                    if (content == nil || [content isEqualToString:@""]) {
                        content = @"暂时没有填写";
                    }
                    break;
                }
                case 9:
                {
                    //身份证
                    content = user.idcard;
                    if (content == nil || [content isEqualToString:@""]) {
                        content = @"暂时没有填写";
                    }
                    break;
                }
                case 10:
                {
                    //地区
                    content = user.currentaddress;
                    if (content == nil || [content isEqualToString:@""]) {
                        content = @"暂时没有填写";
                    }
                    break;
                }
                case 11:
                {
                    //最近动态
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
                case 12:
                {
                    //修改密码
                    //                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    contentLabel.text = content;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            return 80;
            break;
            
        default:
            break;
    }
    return 44.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary *dict = nil;
    NSString *defaultInfo = nil;
    switch (row) {
        case 0:
        {
            //头像
            [self modifyPicture:nil];
            break;
        }
        case 1:
        {
            //姓名
            User *user = [HeSysbsModel getSysModel].user;
            NSString *originalContent = user.name;
            dict = @{@"modifyKey":@"name",@"defaultInfo":@"姓名",@"originalContent":originalContent};
            HeModifyInfoView *modifyInfoVC = [[HeModifyInfoView alloc] initWithDict:dict];
            modifyInfoVC.title = @"修改姓名";
            modifyInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyInfoVC animated:YES];
            break;
        }
        case 2:
        {
            //昵称
            User *user = [HeSysbsModel getSysModel].user;
            NSString *originalContent = user.nickname;
            dict = @{@"modifyKey":@"nickname",@"defaultInfo":@"昵称",@"originalContent":originalContent};
            HeModifyInfoView *modifyInfoVC = [[HeModifyInfoView alloc] initWithDict:dict];
            modifyInfoVC.title = @"修改昵称";
            modifyInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyInfoVC animated:YES];
            break;
        }
        case 3:
        {
            //服务号，不可修改
            return;
            break;
        }
        case 4:
        {
            
            break;
        }
        case 5:
        {
            //手机号
            User *user = [HeSysbsModel getSysModel].user;
            NSString *originalContent = user.phonenum;
            dict = @{@"modifyKey":@"phonenum",@"defaultInfo":@"手机号",@"originalContent":originalContent};
            HeModifyInfoView *modifyInfoVC = [[HeModifyInfoView alloc] initWithDict:dict];
            modifyInfoVC.title = @"修改手机号";
            modifyInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyInfoVC animated:YES];
            break;
        }
        case 6:
        {
            //修改性别
            
            UIActionSheet *sexsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            sexsheet.tag = 2;
            [sexsheet showInView:userTable];
            break;
        }
        case 7:
        {
            //生日
            
            
            if ([self.tmpDateString isMemberOfClass:[NSNull class]] || self.tmpDateString == nil || [self.tmpDateString isEqualToString:@""]) {
                NSDate * startDate = [[NSDate alloc] init];
                NSCalendar * chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit |
                NSSecondCalendarUnit | NSDayCalendarUnit  | NSMonthCalendarUnit | NSYearCalendarUnit;
                NSDateComponents * cps = [chineseCalendar components:unitFlags fromDate:startDate];
                NSUInteger day = [cps day];
                NSUInteger month = [cps month];
                NSUInteger year = [cps year];
                self.tmpDateString = [NSString stringWithFormat:@"%d-%d-%d",(int)year,(int)month,(int)day];
            }
            
            [self dateButtonClick:nil withString:self.tmpDateString];
            
            break;
        }
        case 8:
        {
            //职业
            User *user = [HeSysbsModel getSysModel].user;
            NSString *originalContent = user.profession;
            dict = @{@"modifyKey":@"profession",@"defaultInfo":@"职业",@"originalContent":originalContent};
            HeModifyInfoView *modifyInfoVC = [[HeModifyInfoView alloc] initWithDict:dict];
            modifyInfoVC.title = @"修改职业";
            modifyInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyInfoVC animated:YES];
            break;
        }
        case 9:
        {
            //身份证
            User *user = [HeSysbsModel getSysModel].user;
            NSString *originalContent = user.idcard;
            dict = @{@"modifyKey":@"idcard",@"defaultInfo":@"身份证",@"originalContent":originalContent};
            HeModifyInfoView *modifyInfoVC = [[HeModifyInfoView alloc] initWithDict:dict];
            modifyInfoVC.title = @"修改身份证";
            modifyInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyInfoVC animated:YES];
            break;
        }
        case 10:
        {
            //地区
            //            [self showLocateView:nil];
            User *user = [HeSysbsModel getSysModel].user;
            NSString *originalContent = user.currentaddress;
            dict = @{@"modifyKey":@"currentaddress",@"defaultInfo":@"地区",@"originalContent":originalContent};
            HeModifyInfoView *modifyInfoVC = [[HeModifyInfoView alloc] initWithDict:dict];
            modifyInfoVC.title = @"修改地区";
            modifyInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyInfoVC animated:YES];
            
            break;
        }
        case 11:
        {
            
            break;
        }
        case 12:
        {
            //修改密码
            [self showHint:@"此功能暂未开通"];
            //            HeForgetPSWView *forgetVC = [[HeForgetPSWView alloc] init];
            //            forgetVC.getcodeKey = MODIFYPASSWORDKEY;
            //            forgetVC.hidesBottomBarWhenPushed = YES;
            //            [self.navigationController pushViewController:forgetVC animated:YES];
            break;
        }
        default:
            break;
    }
}

//提交上传
-(void)uploadOneFileData:(NSData *)woodImgData imgType:(NSString*)typeStr imgName:(NSString *)fileName{
    if (woodImgData) {
        
    }
}

- (void)modifyUserWithParam:(NSDictionary *)param
{
    NSString *modifyPath = [NSString stringWithFormat:@"%@%@",BASEURL,UPDATEUSERINFO];
    
    NSDictionary *paramsDict = @{@"jsonDate":[param JSONString]};
    
}

//获取用户的个人信息
- (void)getUserInfo
{
    NSString *getUserInfoPath = [NSString stringWithFormat:@"%@%@",BASEURL,GETUSERINFO];
    NSString *username = [[Tool getUserDict] objectForKey:USERACCOUNTKEY];
    NSDictionary *params = @{@"username":username};
    
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
