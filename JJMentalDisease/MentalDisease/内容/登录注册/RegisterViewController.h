//
//  RegisterViewController.h
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/30.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCountDownButton.h"
@interface RegisterViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet STCountDownButton *YanzhengmaCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *textFieldphone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldYanzhengCode;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSecurCode;

@end
