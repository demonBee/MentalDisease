//
//  AboutOurAndSayViewController.h
//  MentalDisease
//
//  Created by 黄佳峰 on 16/6/7.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,whichCategory) {
     categoryAboutOur=0,
    categorySay,
   
    
    
};

@interface AboutOurAndSayViewController : UIViewController

@property(nonatomic,assign)whichCategory witchOne;

+(instancetype)creatVCWitchCate:(whichCategory)aaa;

@property (strong, nonatomic) UITextView *TextViewShow;

@end
