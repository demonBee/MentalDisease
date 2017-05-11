//
//  XXNavigationController.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXNavigationController.h"

// 获取RGB颜色
#define XXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface XXNavigationController ()

@end

@implementation XXNavigationController

+ (void)initialize
{
    // 设置BarButtonItem
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    
//    NSMutableDictionary *normal = [NSMutableDictionary dictionary];
//    normal[NSForegroundColorAttributeName] = XXColor(239, 116, 8);
//    normal[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
//    [item setTitleTextAttributes:normal forState:UIControlStateNormal];
//    
//    NSMutableDictionary *disabled = [NSMutableDictionary dictionary];
//    disabled[NSForegroundColorAttributeName] = XXColor(111, 111, 111);
//    disabled[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
//    [item setTitleTextAttributes:disabled forState:UIControlStateDisabled];
    
    
}

//-(instancetype)init{
//   self= [super init];
//    if (self) {
//           [self.navigationController.navigationBar setBarTintColor:[UIColor greenColor]];
//    }
//    return self;
//}

-(void)viewDidLoad{
    [super viewDidLoad];
      //选择自己喜欢的颜色
//    UIColor * color = [UIColor whiteColor];
//    
//    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
//    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
//    
//
//    self.navigationBar.titleTextAttributes = dict;
    

    
//    [self.navigationBar setBarTintColor:BaseColor];
//    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setTintColor:BaseColor];
    
    
    NSDictionary*attrubiteDic=@{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationBar.titleTextAttributes=attrubiteDic;


    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航栏按钮
        UIButton*button=[[UIButton alloc]init];
        [button setBackgroundImage:[UIImage imageNamed:@"NaviBack"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"NaviBack"] forState:UIControlStateNormal];
           button.size=button.currentBackgroundImage.size;
[button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*item=[[UIBarButtonItem alloc]initWithCustomView:button];
        
       
        viewController.navigationItem.leftBarButtonItem=item;

        
        


    }
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
#warning 这里用的是self, 因为self就是当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
}


@end
