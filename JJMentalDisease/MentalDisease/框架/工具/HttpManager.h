//
//  HttpManager.h
//  AliShake
//
//  Created by 李鹏博 on 15/10/16.
//  Copyright © 2015年 李鹏博. All rights reserved.
//
typedef void(^resultBlock)(id data,NSError *error);
#import <Foundation/Foundation.h>

@interface HttpManager : NSObject<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}
@property(nonatomic,copy)resultBlock block;
//封装的get请求
-(void)getDataFromNetworkWithUrl:(NSString*)urlString parameters:(id)parameters compliation:(resultBlock)newBlock;

//封装的get请求 没有hud
-(void)getDataFromNetworkNOHUDWithUrl:(NSString*)urlString parameters:(id)parameters compliation:(resultBlock)newBlock;
//封装的 post 上传图片请求
-(void)postDataUpDataPhotoWithUrl:(NSString*)urlString parameters:(id)parameters photo:(NSData*)data compliation:(resultBlock)newBlock;

//封装的post请求
-(void)postDataFromNetworkWithUrl:(NSString*)urlString parameters:(id)parameters compliation:(resultBlock)newBlock;


//封装的get请求
-(void)getDataFromNetworkWithUrlNoRemove:(NSString*)urlString parameters:(id)parameters compliation:(resultBlock)newBlock;
@end
