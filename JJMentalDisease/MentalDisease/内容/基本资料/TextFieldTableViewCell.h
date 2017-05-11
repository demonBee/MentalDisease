//
//  TextFieldTableViewCell.h
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/27.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell
//得到值  没有值  那么placehold 就是 未填写
-(void)getValue:(NSString*)str;

@property (weak, nonatomic) IBOutlet UITextField *TextField;

@property(nonatomic,strong)void(^textFieldTextBlock)(NSString*);
@end
