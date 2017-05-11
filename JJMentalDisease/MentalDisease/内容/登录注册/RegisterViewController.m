//
//  RegisterViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/30.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "RegisterViewController.h"
#import "MainViewController.h"

@interface RegisterViewController ()
@property(nonatomic,assign)BOOL canSave;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"注册";
    [self.YanzhengmaCodeBtn setSecond:60];
    [self.YanzhengmaCodeBtn addTarget:self action:@selector(PostYanzhengCode:) forControlEvents:UIControlEventTouchUpInside];
    
    self.textFieldphone.keyboardType=UIKeyboardTypeNumberPad;
    self.textFieldYanzhengCode.keyboardType=UIKeyboardTypeNumberPad;
    
    self.registerButton.layer.cornerRadius=6;
    self.registerButton.layer.masksToBounds=YES;
    
    self.textFieldSecurCode.secureTextEntry=YES;
    
    
}

-(void)PostYanzhengCode:(id)sender{
    NSString*str=[self judgeForYanzhengCode];
    if (self.canSave==NO) {
        [JRToast showWithText:str];
    }else{
    
  
    
//http://115.29.34.238/mentalpre/?  m=appapi&s=register&act=yanzhen&tel=
    
    NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
    NSDictionary*params=@{@"m":@"appapi",@"s":@"register",@"act":@"yanzhen",@"tel":self.textFieldphone.text};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
        if ([data[@"errorCode"] isEqualToString:@"0"]) {
            [JRToast showWithText:data[@"errorMessage"]];
              [self.YanzhengmaCodeBtn start];
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
        
    }];
    }
    
}
- (IBAction)touchRegister:(UIButton *)sender {
    NSString*str=[self judgeForRegister];
    if (self.canSave==NO) {
        [JRToast showWithText:str];
    }else{
//        http://115.29.34.238/mentalpre/?  m=appapi&s=register&act=register&tel=&pwd=&code=  
        NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
        NSDictionary*params=@{@"m":@"appapi",@"s":@"register",@"act":@"register",@"tel":self.textFieldphone.text,@"pwd":self.textFieldSecurCode.text,@"code":self.textFieldYanzhengCode.text};
        HttpManager*manager=[[HttpManager alloc]init];
[manager getDataFromNetworkWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
    if ([data[@"errorCode"] isEqualToString:@"0"]) {
        
        [JRToast showWithText:data[@"errorMessage"]];
        //注册成功了   直接登录
        UserSession*user=[UserSession instance];
        [user setValuesForKeysWithDictionary:data[@"data"]];
        
        //  自动登录
        NSUserDefaults*userDe=[NSUserDefaults standardUserDefaults];
        [userDe setObject:self.textFieldphone.text forKey:AUTOLOGINACCOUNT];
        [userDe setObject:self.textFieldSecurCode.text forKey:AUTOLOGINCODE];
        
        
        MainViewController*vc=[[MainViewController alloc]init];
        XXNavigationController*navi=[[XXNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].keyWindow.rootViewController=navi;


        

    }else{
        
        [JRToast showWithText:data[@"errorMessage"]];
    }
    
    
}];
        
        
    }
    
    
}

-(NSString*)judgeForRegister{
    self.canSave=YES;
    if (self.textFieldphone.text.length!=11) {
        self.canSave=NO;
        return @"请输入正确的手机号";
    }else if (self.textFieldYanzhengCode.text.length<4){
        self.canSave=NO;
        return @"请输入正确的验证码";
    }else if (self.textFieldSecurCode.text.length<6){
        self.canSave=NO;
        return @"密码长度不能小于6位";
    }
    
    return @"滚";
}


-(NSString*)judgeForYanzhengCode{
    self.canSave=YES;
    if (self.textFieldphone.text.length!=11) {
        self.canSave=NO;
        return @"请输入正确的手机号";
    }
    return @"MB";
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
