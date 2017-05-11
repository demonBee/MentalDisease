//
//  HttpManager.m
//  AliShake
//
//  Created by 李鹏博 on 15/10/16.
//  Copyright © 2015年 李鹏博. All rights reserved.
//

#import "HttpManager.h"
#import "AMTumblrHud.h"
#import "LBProgressHUD.h"
#import "HUProgressView.h"

@implementation HttpManager
//封装的get请求
-(void)getDataFromNetworkWithUrl:(NSString*)urlString parameters:(id)parameters compliation:(resultBlock)newBlock{
    self.block =newBlock;
#pragma mark -----1
//    HUD =[[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window];
//    [[UIApplication sharedApplication].delegate.window addSubview:HUD];
//    HUD.delegate =self;
//    HUD.dimBackground = YES;
//    [HUD show:YES];

#pragma  mark  -----2
//    AMTumblrHud*tumb=[[AMTumblrHud alloc]initWithFrame:CGRectMake((KScreenWidth-55)/2, (KScreenHeight-20)/2, 55, 20)];
//    tumb.hudColor=[UIColor grayColor];
//    [[UIApplication sharedApplication].delegate.window addSubview:tumb];
//    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
//    view.backgroundColor=[UIColor clearColor];
//     [[UIApplication sharedApplication].delegate.window addSubview:view];
//  [tumb showAnimated:YES];
    
    
#pragma  mark  ------3
    UIWindow*window=[[UIApplication sharedApplication].delegate window];
    [LBProgressHUD showHUDto:window animated:YES];

    
#pragma mark  --------4
//    UIWindow*window=[[UIApplication sharedApplication].delegate window];
//    HUProgressView *progress = [[HUProgressView alloc] initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
//    progress.center = window.center;
//    progress.strokeColor = [UIColor blackColor];
//    [window addSubview:progress];
//    [progress startProgressAnimating];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        
        self.block(responseObject,nil);
//        [HUD hide:YES];
//        [HUD removeFromSuperview];
        
        
//        [tumb removeFromSuperview];
//        [view removeFromSuperview];
        
        
      [LBProgressHUD hideAllHUDsForView:window animated:YES];
        
        
//        [progress stopProgressAnimating];
//        [progress removeFromSuperview];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.block(nil,error);
//        [HUD hide:YES];
//        [HUD removeFromSuperview];
        
        
//        [tumb removeFromSuperview];
//        [view removeFromSuperview];
        
      [LBProgressHUD hideAllHUDsForView:window animated:YES];

        
//        [progress stopProgressAnimating];
//        [progress removeFromSuperview];

        
        [JRToast showWithText:@"连接超时,请检查网络" bottomOffset:70*KScreenWidth/320 duration:3.0f];
    }];
}

//封装的get请求   不带移除菊花的 只单单适用于首页登录后 在调接口
-(void)getDataFromNetworkWithUrlNoRemove:(NSString*)urlString parameters:(id)parameters compliation:(resultBlock)newBlock{
    self.block =newBlock;
#pragma mark -----1
    //    HUD =[[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window];
    //    [[UIApplication sharedApplication].delegate.window addSubview:HUD];
    //    HUD.delegate =self;
    //    HUD.dimBackground = YES;
    //    [HUD show:YES];
    
#pragma  mark  -----2
    //    AMTumblrHud*tumb=[[AMTumblrHud alloc]initWithFrame:CGRectMake((KScreenWidth-55)/2, (KScreenHeight-20)/2, 55, 20)];
    //    tumb.hudColor=[UIColor grayColor];
    //    [[UIApplication sharedApplication].delegate.window addSubview:tumb];
    //    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    //    view.backgroundColor=[UIColor clearColor];
    //     [[UIApplication sharedApplication].delegate.window addSubview:view];
    //  [tumb showAnimated:YES];
    
    
#pragma  mark  ------3
    UIWindow*window=[[UIApplication sharedApplication].delegate window];
    [LBProgressHUD showHUDto:window animated:YES];
    
    
#pragma mark  --------4
    //    UIWindow*window=[[UIApplication sharedApplication].delegate window];
    //    HUProgressView *progress = [[HUProgressView alloc] initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
    //    progress.center = window.center;
    //    progress.strokeColor = [UIColor blackColor];
    //    [window addSubview:progress];
    //    [progress startProgressAnimating];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",responseObject);
        
        self.block(responseObject,nil);
        //        [HUD hide:YES];
        //        [HUD removeFromSuperview];
        
        
        //        [tumb removeFromSuperview];
        //        [view removeFromSuperview];
        
        
//        [LBProgressHUD hideAllHUDsForView:window animated:YES];
        
        
        //        [progress stopProgressAnimating];
        //        [progress removeFromSuperview];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.block(nil,error);
        //        [HUD hide:YES];
        //        [HUD removeFromSuperview];
        
        
        //        [tumb removeFromSuperview];
        //        [view removeFromSuperview];
        
        [LBProgressHUD hideAllHUDsForView:window animated:YES];
        
        
        //        [progress stopProgressAnimating];
        //        [progress removeFromSuperview];
        
        
        [JRToast showWithText:@"连接超时,请检查网络" bottomOffset:70*KScreenWidth/320 duration:3.0f];
    }];
}


//gei 请求 没有HUD
-(void)getDataFromNetworkNOHUDWithUrl:(NSString*)urlString parameters:(id)parameters compliation:(resultBlock)newBlock{
       self.block =newBlock;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",responseObject);
        
        self.block(responseObject,nil);
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.block(nil,error);
        
//        [JRToast showWithText:@"连接超时,请检查网络" bottomOffset:70*KScreenWidth/320 duration:3.0f];
    }];

    
    
}


//post 上传图片
-(void)postDataUpDataPhotoWithUrl:(NSString*)urlString parameters:(id)parameters photo:(NSData*)data compliation:(resultBlock)newBlock{
    self.block =newBlock;
    HUD =[[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window];
    [[UIApplication sharedApplication].delegate.window addSubview:HUD];
    HUD.delegate =self;
    HUD.dimBackground = YES;
    [HUD show:YES];
    [HUD removeFromSuperview];
    //    NSString * url = [urlString st:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    __weak typeof(data) upData=data;
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"%@",formData);
        [formData appendPartWithFileData:upData name:@"File" fileName:@"headimage.png" mimeType:@"png"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        self.block(responseObject,nil);
        [HUD hide:YES];
             [HUD removeFromSuperview];

      
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        self.block(nil,error);
        [HUD hide:YES];
             [HUD removeFromSuperview];
        [JRToast showWithText:@"连接超时,请检查网络" bottomOffset:70*KScreenWidth/320 duration:3.0f];

    }];
    
}


////get 请求 上传图片
//-(void)UpdateUserHeadPhoto:(NSString*)token HeadPhotoPath:(NSString *)headphotopath success:(void(^)(NSString *headurl))success fail:(void(^)())fail
//{
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@",AlyHTTP_ADDRESS,UPDATEPHOTO];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"token"] = token;
//    NSData *fileData = [NSData dataWithContentsOfFile:headphotopath];
//    __weak typeof(fileData) uploadData = fileData;
//    [manager POST:urlStr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
//        [formData appendPartWithFileData:uploadData name:@"File" fileName:@"headimage.png" mimeType:@"png"];
//        
//    }success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //        NsLog(@"UpdateUserHeadPhoto----%@",[responseObject objectForKey:@"msg"]);
//        success(responseObject[@"data"][@"headPhotoUrl"]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //        MyLog(@"%@",error);
//        fail();
//    }];
//}



-(void)postDataFromNetworkWithUrl:(NSString*)urlString parameters:(id)parameters compliation:(resultBlock)newBlock{
    self.block=newBlock;
    HUD =[[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window];
    [[UIApplication sharedApplication].delegate.window addSubview:HUD];
    HUD.delegate =self;
    HUD.dimBackground = YES;
    [HUD show:YES];
    //    NSString * url = [urlString st:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.block(responseObject,nil);
        [HUD hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.block(nil,error);
        [HUD hide:YES];
        [JRToast showWithText:@"连接超时,请检查网络" bottomOffset:70*KScreenWidth/320 duration:3.0f];
    }];
}


//hud隐藏删除的代理方法
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
}
@end
