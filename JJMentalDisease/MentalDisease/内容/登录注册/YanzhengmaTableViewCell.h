//
//  YanzhengmaTableViewCell.h
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/31.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCountDownButton.h"   //验证码
@interface YanzhengmaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textFieldYanzhengCode;
@property (weak, nonatomic) IBOutlet STCountDownButton *PostYanzhengma;
@end
