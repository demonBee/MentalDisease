//
//  InformationViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/26.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "InformationViewController.h"
#import "InfoFirstTableViewCell.h"   //单行
#import "INfoOtherTableViewCell.h"   //多行
@import AVFoundation;
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "SettingTitleViewController.h"   //设置名字等
#import "ActionSheetStringPicker.h"   //选择性别  工具
#import "NSDate+Helper.h"
#import "ActionSheetDatePicker.h"

#import "ImageCache.h"

#define ORIGINAL_MAX_WIDTH 640.0f



#define INFOFIRST   @"InfoFirstTableViewCell"
#define INFOOTHER   @"INfoOtherTableViewCell"

@interface InformationViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,VPImageCropperDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人信息";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:INFOFIRST bundle:nil] forCellReuseIdentifier:INFOFIRST];
    [self.tableView registerNib:[UINib nibWithNibName:INFOOTHER bundle:nil] forCellReuseIdentifier:INFOOTHER];
    
    UIBarButtonItem*item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NaviBack"] style:UIBarButtonItemStylePlain target:self action:@selector(postNotificate)];
    
    self.navigationItem.leftBarButtonItem=item;
    
    

}

-(void)postNotificate{
     [self.navigationController popViewControllerAnimated:YES];
    
    //通知主控制器  打开侧边栏
    [[NSNotificationCenter defaultCenter]postNotificationName:@"openRightView" object:nil];

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 6;
    }else if (section==1){
        return 3;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row==0&&indexPath.section==0) {
        InfoFirstTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:INFOFIRST];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=NO;
        UILabel*nameLabel=[cell viewWithTag:1];
        UIImageView*imageView=[cell viewWithTag:2];
        imageView.layer.cornerRadius=45/2;
        imageView.layer.borderWidth=1;
        imageView.layer.masksToBounds=YES;

        nameLabel.text=@"头像";
        [imageView sd_setImageWithURL:[NSURL URLWithString:[UserSession instance].logo] placeholderImage:nil];
    
        return cell;
    }else{
        INfoOtherTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:INFOOTHER];
        cell.selectionStyle=NO;
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UILabel*nameLabel=[cell viewWithTag:1];
        UILabel*subLabel=[cell viewWithTag:2];
        
        if (indexPath.section==0) {
            if (indexPath.row==1) {
                nameLabel.text=@"昵称";
                subLabel.text=[UserSession instance].user;
                
                return cell;
            }else if (indexPath.row==2){
                nameLabel.text=@"性别";
                subLabel.text=[UserSession instance].sex;

                return cell;

            }else if (indexPath.row==3){
                nameLabel.text=@"生日";
                subLabel.text=[UserSession instance].birthday;

                return cell;

            }else if (indexPath.row==4){
                nameLabel.text=@"所在地";
                subLabel.text=[NSString stringWithFormat:@"%@ %@",[UserSession instance].province,[UserSession instance].city];
                return cell;

                
            }else if (indexPath.row==5){
                nameLabel.text=@"婚姻状况";
                subLabel.text=[UserSession instance].marital;
                return cell;

                
            }
            
            
#pragma mark  ----完善
        }
        else if (indexPath.section==1){
            cell.accessoryType=UITableViewCellAccessoryNone;
            
            if (indexPath.row==0) {
                nameLabel.text=@"BMI指数";
                subLabel.text=[UserSession instance].BMI;

                return cell;
            }else if (indexPath.row==1){
                nameLabel.text=@"家族遗传史";
                subLabel.text=[UserSession instance].is_heredity;
                return cell;

                
            }else if (indexPath.row==2){
                nameLabel.text=@"就诊信息";
                subLabel.text=[UserSession instance].Doctor;

                return cell;

            
           }
        
        }   
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    //头像
                    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
                    [sheet showInView:self.view];
                    
                    
                }
                    break;
                case 1:{
                    //昵称
                    SettingTitleViewController*setVC=[SettingTitleViewController CreatsetTitle:@"昵称" andTextField:[UserSession instance].user doneBlock:^(NSString *textValue) {
                        NSLog(@"xxxx  %@",textValue);
                        //接口
//                        http://115.29.34.238/mentalpre  /?m=appapi&s=membercenter&act=personal_center&zt=up&up=user&user=&uid=       		(修改昵称)
                        NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
                        NSDictionary*params=@{@"m":@"appapi",@"s":@"membercenter",@"act":@"personal_center",@"zt":@"up",@"up":@"user",@"user":textValue,@"uid":[UserSession instance].token};
                        
                        HttpManager*manager=[[HttpManager alloc]init];
                        [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
                            if ([data[@"errorCode"] isEqualToString:@"0"]) {
                                UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
                                UILabel*subLabel=[cell viewWithTag:2];
                                subLabel.text=textValue;

                                //
                                [UserSession instance].user=textValue;
                                //修改成功 之后通知侧边栏 修改图片
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"changePhoto" object:nil];

                                
                            }else{
                                [JRToast showWithText:data[@"errorMessage"]];
                            }
                            
                            }];
                        
                        
                }];
                                                      
                    [self.navigationController pushViewController:setVC animated:YES];
                    
                }
                    break;
                case 2:{
                    //性别

           
                    [ActionSheetStringPicker showPickerWithTitle:nil rows:@[@[@"男", @"女", @"未知"]] initialSelection:@[[UserSession instance].sex] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
//                        http://115.29.34.238/mentalpre  /?         m=appapi&s=membercenter&act=personal_center&zt=up&up=sex&sex=&uid=      		   （修改性别）
                        NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
                    NSDictionary*params=@{@"m":@"appapi",@"s":@"membercenter",@"act":@"personal_center",@"zt":@"up",@"up":@"sex",@"sex":selectedValue[0],@"uid":[UserSession instance].token};
                       HttpManager*manager= [[HttpManager alloc]init];
                        [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
                            NSLog(@"%@",data);
                            
                            if ([data[@"errorCode"] isEqualToString:@"0"]) {
                                //修改成功
//                                UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
//                                UILabel*subLabel=[cell viewWithTag:2];
//                                subLabel.text=selectedValue[0];
                                
                                //
                                [UserSession instance].sex=selectedValue[0];
                                [self.tableView reloadData];
                                
                                
                            }else{
                                [JRToast showWithText:data[@"errorMessage"]];
                                
                            }
                            
                        }];
                        
                  
                    } cancelBlock:nil origin:self.view];

                    
                    
                }
                    break;
                case 3:{
                    //生日
                   
                  
                    NSDate *currDate = [NSDate dateFromString:[UserSession instance].birthday withFormat:@"yyyy-MM-dd"];
                    if (!currDate) {
                        currDate = [NSDate dateFromString:@"1990-01-01" withFormat:@"yyyy-MM-dd"];
                    }

                    ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:currDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDatee, id origin) {
//                        NSString *preValue = weakSelf.curUser.birthday;
//                        weakSelf.curUser.birthday = [selectedDate string_yyyy_MM_dd];
//                        [weakSelf.myTableView reloadData];
                       
                        
                        
               
 //接口
//                        http://115.29.34.238/mentalpre  /?m=appapi&s=membercenter&act=personal_center&zt=up&up=birthday&birthday=&uid=
                        
                        NSString*strBirthday=[selectedDatee string_yyyy_MM_dd];
                        NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
                        NSDictionary*params=@{@"m":@"appapi",@"s":@"membercenter",@"act":@"personal_center",@"zt":@"up",@"up":@"birthday",@"birthday":strBirthday,@"uid":[UserSession instance].token};
                        HttpManager*manager=[[HttpManager alloc]init];
                        [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
                            if ([data[@"errorCode"] isEqualToString:@"0"]) {
                                [UserSession instance].birthday=[selectedDatee string_yyyy_MM_dd];
                                [self.tableView reloadData];
                                
                                
                            }else{
                                [JRToast showWithText:data[@"errorMessage"]];
                            }
                            
                            
                        }];
                        
                        
                    } cancelBlock:^(ActionSheetDatePicker *picker) {
                        DebugLog(@"%@", picker.description);
                    } origin:self.view];
                    [picker showActionSheetPicker];

                }
                    break;
                case 4:{
                    //
//                    http://115.29.34.238/mentalpre  /?m=appapi&s=membercenter&act=personal_center&zt=adress&uid=                           （省市显示）
                    NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
                    NSDictionary*params=@{@"m":@"appapi",@"s":@"membercenter",@"act":@"personal_center",@"zt":@"adress",@"uid":[UserSession instance].token};
                    HttpManager*manager=[[HttpManager alloc]init];
                    [manager getDataFromNetworkWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
                        NSDictionary*dict=data[@"city"];
                        NSArray*allProvince=[dict allKeys];
                        
                        
//                        NSArray*arr1=@[@"北京",@"上海",@"广州"];
//                        NSDictionary*arr2=@{@"北京":@[@"1",@"2",@"3"],@"上海":@[@"4",@"5",@"6"],@"广州":@[@"7",@"8",@"9"]};
                        [ActionSheetStringPicker showPickerWithTitle:nil rows:@[allProvince, dict] initialSelection:@[@(26),@(0)] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                            
                            
//                            http://115.29.34.238/mentalpre/?  m=appapi&s=membercenter&act=personal_center&zt=up&up=adress&province=&city=&uid=      (修改所在地)
                            
                            NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
                            NSDictionary*params=@{@"m":@"appapi",@"s":@"membercenter",@"act":@"personal_center",@"zt":@"up",@"up":@"adress",@"province":selectedValue[0],@"city":selectedValue[1],@"uid":[UserSession instance].token};
                            HttpManager*manager=[[HttpManager alloc]init];
                            [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
                                if ([data[@"errorCode"] isEqualToString:@"0"]) {
                                    
                                    [UserSession instance].province=selectedValue[0];
                                    [UserSession instance].city=selectedValue[1];
                                    [self.tableView reloadData];

                                    
                                }else{
                                    
                                    [JRToast showWithText:data[@"errorMessage"]];
                                }
                                
                            }];
                           
                            
                            
                            
                        } cancelBlock:nil origin:self.view];

                        
                    }];
                    
                    
                  
                    
                }
                    //所在地
                    break;
                case 5:{
                    [ActionSheetStringPicker showPickerWithTitle:nil rows:@[@[@"已婚", @"未婚", @"丧偶"]] initialSelection:@[[UserSession instance].marital] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                        
//                        http://115.29.34.238/mentalpre/?   m=appapi&s=membercenter&act=personal_center&zt=up&up=marital&marital=&uid=         (修改婚姻状况)
                        NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
                        NSString*marStr=selectedValue[0];
                        NSDictionary*params=@{@"m":@"appapi",@"s":@"membercenter",@"act":@"personal_center",@"zt":@"up",@"up":@"marital",@"marital":marStr,@"uid":[UserSession instance].token};
                        HttpManager*manager=[[HttpManager alloc]init];
                        [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
                            if ([data[@"errorCode"] isEqualToString:@"0"]) {
                                [UserSession instance].marital=selectedValue[0];
                                [self.tableView reloadData];

                                
                                
                            }else{
                                [JRToast showWithText:data[@"errorMessage"]];
                            }
                            
                            
                        }];
                        
                        
                        
                    } cancelBlock:nil origin:self.view];

                    
                }
                    //婚姻状况
                    break;
                default:
                    break;
            }
            
        }
            
            break;
        case 1:{
            switch (indexPath.row) {
                case 0:
                    //BMI
                    break;
                case 1:
                    //家族遗传史
                    break;
                case 2:
                    //就诊信息
                    break;
    
                default:
                    break;
            }
        }
            
            break;
        default:
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 66;
    }
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---   相册


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}


#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
//    self.portraitImageView.image = editedImage;
    UITableViewCell*cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImageView*imageView=[cell viewWithTag:2];
    imageView.image=editedImage;
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
        

        

        
        
//        http://115.29.34.238/mentalpre/?  m=appapi&s=membercenter&act=personal_center&zt=logo&uid=
        
          NSString *str = [ImageCache headImagePath:editedImage];
             NSData *fileData = [NSData dataWithContentsOfFile:str];
        NSString*urlStr=[NSString stringWithFormat:@"%@/?m=appapi&s=membercenter&act=personal_center&zt=logo",HTTP_ADDRESS];
        NSDictionary*params=@{@"uid":[UserSession instance].token};
        HttpManager*manager=[[HttpManager alloc]init];
        [manager postDataUpDataPhotoWithUrl:urlStr parameters:params photo:fileData compliation:^(id data, NSError *error) {
            //头像问题
            NSLog(@"%@",data);
            if ([data[@"errorCode"] isEqualToString:@"0"]) {
                [JRToast showWithText:data[@"errorMessage"]];
                [UserSession instance].logo=data[@"imgurl"];
              
                //修改成功 之后通知侧边栏 修改图片
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changePhoto" object:nil];
                
                
            }else{
                [JRToast showWithText:data[@"errorMessage"]];
            }
            
            
        }];
        
        
        
        
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];  //倍数缩放
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    
}




@end
