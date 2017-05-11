//
//  AppDelegate.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/26.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "XXNavigationController.h"

#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //友盟
     [UMSocialData setAppKey:@"57556210e0f55a5b81000d27"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx6edefe48e9a7e54a" appSecret:@"728dbeda4f0c8b09d9f641f16725f9b4" url:@"http://115.29.34.238/mentalpre/?m=appapi&s=system&act=analysis"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105369133" appKey:@"MTTeNWWAVCZGRGhW" url:@"http://115.29.34.238/mentalpre/?m=appapi&s=system&act=analysis"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3618594909"
                                              secret:@"feba3b38fb9fe5f3b597e2afac660165"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //http://sns.whalecloud.com/sina2/callback
    
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
//    MainViewController*vc=[[MainViewController alloc]init];
    
    //注册
    LoginViewController*vc=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    
    XXNavigationController*navi=[[XXNavigationController alloc]initWithRootViewController:vc];
//    [navi.navigationBar setTintColor:BaseColor];
//    [[UINavigationBar appearance] setBarTintColor:BaseColor];

    self.window.rootViewController=navi;
    [self.window makeKeyAndVisible];
    return YES;
}

//回调   触发了他   才回调用  当前控制器里面的方法：
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    
   UserSession*session=[UserSession instance];
//    http://115.29.34.238/mentalpre/?  m=appapi&s=membercenter&act=info&uid=
    
    NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
    NSDictionary*params=@{@"m":@"appapi",@"s":@"membercenter",@"act":@"info",@"uid":session.token};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
        NSLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0"]) {
            
            
            //成功的话   发个通知   刷新 right侧边栏     2.把user 一个值 修改
            [UserSession instance].info=data[@"data"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshRight" object:nil];
            
            
        }else{
            
            
        }
        
        
        
        
        
    }];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
