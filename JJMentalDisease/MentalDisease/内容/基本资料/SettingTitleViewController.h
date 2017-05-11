//
//  SettingTitleViewController.h
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/27.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTitleViewController : UIViewController

@property(nonatomic,strong)void(^myBlock)(NSString*str);  //返回给信息控制器的
+(instancetype)CreatsetTitle:(NSString*)title andTextField:(NSString*)text doneBlock:(void(^)(NSString*textValue))block;
@end
