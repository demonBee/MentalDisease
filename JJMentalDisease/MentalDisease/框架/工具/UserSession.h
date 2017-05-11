//
//  UserSession.h
//  GKAPP
//
//  Created by 黄佳峰 on 15/11/6.
//  Copyright © 2015年 黄佳峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject

//BMI = 0;
//birthday = "1999-06-19";
//city = "\U95f5\U884c\U533a";
//info = 1;
//"is_heredity" = "\U6709";
//logo = "image/default/avatar.png";
//marital = "\U5df2\U5a5a";
//mobile = 18870838746;
//password = e10adc3949ba59abbe56e057f20f883e;
//province = "\U4e0a\U6d77\U5e02";
//sex = "\U5973";
//token = 8e0435d700ee07ad33c4352abf7c00f9;
//user = "\U5c0f\U5c0f\U86cb\U86cb";
//userid = 1;



//BMI =         (
//);
//Doctor =         (
//);
//birthday = "1998-06-28";
//city = "\U4e0a\U6d77\U5e02";
//info = 1;
//"is_heredity" = "\U6709";
//logo = "image/default/avatar.png";
//marital = "\U4e27\U5076";
//mobile = 18870838746;
//password = e10adc3949ba59abbe56e057f20f883e;
//province = "\U4e0a\U6d77\U5e02";
//sex = "\U5973";
//token = f411225e5a2f1da7580044bc912a12d1;
//user = "\U5c0f\U5c0f";
//userid = 1;



@property(nonatomic,strong)NSString*BMI;        //BMI指数
@property(nonatomic,strong)NSString*is_heredity;    //有     遗传病
@property(nonatomic,strong)NSString*Doctor;   //就诊记录


@property(nonatomic,strong)NSString*birthday;    //生日

@property(nonatomic,strong)NSString*info;      // 消息这里1 为有小红点     0为没小红点

@property(nonatomic,strong)NSString*logo;           //头像
@property(nonatomic,strong)NSString*marital;      //结婚状态
@property(nonatomic,strong)NSString*mobile;
@property(nonatomic,strong)NSString*password;
@property(nonatomic,strong)NSString*province;    //省
@property(nonatomic,strong)NSString*city;       //市 区
@property(nonatomic,strong)NSString*sex;     //性别
@property(nonatomic,strong)NSString*token;    //唯一标示
@property(nonatomic,strong)NSString*user;      //昵称
@property(nonatomic,strong)NSString*userid;






+ (UserSession *) instance;   //单例
-(void)cleanUser;     //清空

@end
