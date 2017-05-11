//
//  LoginViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/30.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MainViewController.h"
#import "RitrieveCodeViewController.h"


@interface LoginViewController ()

@property(nonatomic,assign)BOOL canSave;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自动登录
    [self autoLogin];
    
    [self makeUI];
    if (IS_IPHONE_5s_OR_LESS) {
        self.photoY.constant=80.0;
        self.bottomY.constant=self.photoImage.bottom+10;
    }
    self.title=@"登录";
    
    self.accountNum.keyboardType=UIKeyboardTypeNumberPad;
    self.codeNum.secureTextEntry=YES;
}

-(void)makeUI{
    UIImageView*headImageView=[self.view viewWithTag:1];
    headImageView.layer.cornerRadius=44;
    headImageView.layer.masksToBounds=YES;
    headImageView.layer.borderColor=RGBCOLOR(21, 156, 90, 1).CGColor;
    headImageView.layer.borderWidth=1;
    
    UIButton*forgetBtn=[self.view viewWithTag:4];
    [forgetBtn addTarget:self action:@selector(forgetCode:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton*loginBtn=[self.view viewWithTag:5];
    loginBtn.layer.cornerRadius=6;
    loginBtn.layer.masksToBounds=YES;
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton*registerBtn=[self.view viewWithTag:6];
    [registerBtn addTarget:self action:@selector(ToRegister:) forControlEvents:UIControlEventTouchUpInside];
    
}
//forget
-(void)forgetCode:(UIButton*)sender{
    RitrieveCodeViewController*vc=[[RitrieveCodeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//自动登录
-(void)autoLogin{
    NSUserDefaults*userDe=[NSUserDefaults standardUserDefaults];
    NSString*count=[userDe objectForKey:AUTOLOGINACCOUNT];
    NSString*code=[userDe objectForKey:AUTOLOGINCODE];

    
    if (!count||!code) {
        return;
        
    }else{
        //自动登录
        
        NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
        NSDictionary*params=@{@"m":@"appapi",@"s":@"login",@"act":@"login",@"tel":count,@"pwd":code};
        HttpManager*manager= [[HttpManager alloc]init];
        [manager getDataFromNetworkWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
            NSLog(@"%@",data);
            if ([data[@"errorCode"] isEqualToString:@"0"]) {
                
                UserSession*user= [UserSession instance];
                [user setValuesForKeysWithDictionary:data[@"data"]];
                
                
                
                MainViewController*vc=[[MainViewController alloc]init];
                XXNavigationController*navi=[[XXNavigationController alloc]initWithRootViewController:vc];
                [UIApplication sharedApplication].keyWindow.rootViewController=navi;
                
                
            }else{
                [JRToast showWithText:@"自动登录失败"];
                //取消自动登录
                NSUserDefaults*userDe=[NSUserDefaults standardUserDefaults];
                [userDe removeObjectForKey:AUTOLOGINACCOUNT];
                [userDe removeObjectForKey:AUTOLOGINCODE];
                
            }
            
            
        }];

        
        
    }
    
    
}

//登录
-(void)login:(UIButton*)sender{
    //
    NSString*str=[self judgeSave];
    if (self.canSave==NO) {
        [JRToast showWithText:str];
        return;
    }else{
//          http://115.29.34.238/mentalpre /?m=appapi&s=login&act=login&tel=&pwd= 
        NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
        NSDictionary*params=@{@"m":@"appapi",@"s":@"login",@"act":@"login",@"tel":self.accountNum.text,@"pwd":self.codeNum.text};
       HttpManager*manager= [[HttpManager alloc]init];
        [manager getDataFromNetworkWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
            NSLog(@"%@",data);
            if ([data[@"errorCode"] isEqualToString:@"0"]) {
                
               UserSession*user= [UserSession instance];
                [user setValuesForKeysWithDictionary:data[@"data"]];
                
                //  自动登录
                NSUserDefaults*userDe=[NSUserDefaults standardUserDefaults];
                [userDe setObject:self.accountNum.text forKey:AUTOLOGINACCOUNT];
                [userDe setObject:self.codeNum.text forKey:AUTOLOGINCODE];
                
                
                MainViewController*vc=[[MainViewController alloc]init];
                XXNavigationController*navi=[[XXNavigationController alloc]initWithRootViewController:vc];
                [UIApplication sharedApplication].keyWindow.rootViewController=navi;

                
            }else{
                [JRToast showWithText:data[@"errorMessage"]];
                //取消自动登录
                NSUserDefaults*userDe=[NSUserDefaults standardUserDefaults];
                [userDe removeObjectForKey:AUTOLOGINACCOUNT];
                [userDe removeObjectForKey:AUTOLOGINCODE];

            }
            
            
        }];
        
        
    }
    
    
    
    
}

//register
-(void)ToRegister:(UIButton*)sender{
    RegisterViewController*vc=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSString*)judgeSave{
    self.canSave=YES;
    if (self.accountNum.text.length!=11) {
        self.canSave=NO;
        return @"手机号是11位数字";
    }else if (self.codeNum.text.length<6){
        self.canSave=NO;
        return @"密码不能小于6位";
    }
    
    
    return @"666";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[self findFirstResponderBeneathView:self.view] resignFirstResponder];
}

//touch began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self findFirstResponderBeneathView:self.view] resignFirstResponder];
}


- (UIView*)findFirstResponderBeneathView:(UIView*)view
{
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] )
            return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result )
            return result;
    }
    return nil;
}

@end
