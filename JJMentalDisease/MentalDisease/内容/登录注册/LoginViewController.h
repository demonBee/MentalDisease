//
//  LoginViewController.h
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/30.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoY;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomY;


@property (weak, nonatomic) IBOutlet UITextField *accountNum;
@property (weak, nonatomic) IBOutlet UITextField *codeNum;

@end
