//
//  AdviceGetViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/6/7.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "AdviceGetViewController.h"

@interface AdviceGetViewController ()
@property(nonatomic,assign)BOOL canSave;
@end

@implementation AdviceGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title=@"意见反馈";
    self.samTextView.placeholder=@"您有任何问题可向我们咨询，我们会及时给以您专业的反馈";
    self.samTextView.layer.borderColor=BaseColor.CGColor;
    self.samTextView.layer.borderWidth=1;
    
    self.buttonSend.layer.cornerRadius=12;
    self.buttonSend.layer.masksToBounds=YES;
    [self.buttonSend addTarget:self action:@selector(sendInfo:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)sendInfo:(id)sender{
    NSString*str=[self judgeCanSave];
    if (self.canSave==NO) {
        [JRToast showWithText:str];
        return;
    }else{
    
    //接口
//    http://115.29.34.238/mentalpre/?  m=appapi&s=membercenter&act=user_feedback&uid=&con=                       
    
    NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
    NSDictionary*params=@{@"m":@"appapi",@"s":@"membercenter",@"act":@"user_feedback",@"uid":[UserSession instance].token,@"con":self.samTextView.text};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager getDataFromNetworkWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
        if ([data[@"errorCode"] isEqualToString:@"0"]) {
            [JRToast showWithText:data[@"errorMessage"]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
        
    }];
    
    }
    
}

-(NSString*)judgeCanSave{
    self.canSave=YES;
    if (self.samTextView.text.length<5) {
        self.canSave=NO;
        return @"不能小于5个字";
    }
    
    return @"MB";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
