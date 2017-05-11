//
//  AboutOurAndSayViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/6/7.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "AboutOurAndSayViewController.h"

@interface AboutOurAndSayViewController ()

@end

@implementation AboutOurAndSayViewController

+(instancetype)creatVCWitchCate:(whichCategory)aaa{
    AboutOurAndSayViewController*vc=[[AboutOurAndSayViewController alloc]initWithNibName:@"AboutOurAndSayViewController" bundle:nil];
    vc.witchOne=aaa;
    return vc;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor=RGBCOLOR(245, 245, 245, 1);
    
    
    self.TextViewShow=[[UITextView alloc]init];
    self.TextViewShow.font=[UIFont systemFontOfSize:14];
    self.TextViewShow.backgroundColor=RGBCOLOR(245, 245, 245, 1);
    

    [self.view addSubview:self.TextViewShow];
    [self.TextViewShow setEditable:NO];
//    self.TextViewShow.layer.borderWidth=1;
//    self.TextViewShow.layer.borderColor=BaseColor.CGColor;
    
    [self.TextViewShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(84, 20, 20, 20));
    }];
    [self  whichCateCon];
    
}

-(void)whichCateCon{
    if (self.witchOne==0) {
        //关于我们
        self.title=@"关于我们";
        [self getDataWithZero];
        
    }else{
        //声明
        self.title=@"声明";
         [self getDataWithOne];
    }
    
    
}

//关于我们
-(void)getDataWithZero{
    
    
    UIImageView*SQCode=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"erweima"]];
    [self.view addSubview:SQCode];
    [SQCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(KScreenHeight/5, KScreenHeight/5));
        make.top.mas_equalTo(self.view).offset(110);
    }];
    
    
    UILabel*nameLabel=[[UILabel alloc]init];
    nameLabel.text=@"普瑞心理";
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SQCode.mas_bottom).offset(20);
   
        
    }];
    
    
    [self.TextViewShow mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(KScreenHeight-210, 20, 50, 20));
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(80);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.bottom.mas_equalTo(self.view).offset(50);
        
    }];
    self.TextViewShow.font=[UIFont systemFontOfSize:14];
    self.TextViewShow.textColor=RGBCOLOR(154, 154, 154, 1);

    
    UILabel*bottomLabel=[[UILabel alloc]init];
    bottomLabel.text=@"普瑞心理 版权所有";
    bottomLabel.textColor=RGBCOLOR(154, 154, 154, 1);
    bottomLabel.font=[UIFont systemFontOfSize:14];
    bottomLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:bottomLabel];
    bottomLabel.frame=CGRectMake(20, KScreenHeight-40, KScreenWidth-40, 20);
    
    
//    http://115.29.34.238/mentalpre/?  m=appapi&s=system&act=about_us
    NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
    NSDictionary*params=@{@"m":@"appapi",@"s":@"system",@"act":@"about_us"};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
        NSLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0"]) {
            self.TextViewShow.text=data[@"data"];
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
        
    }];
    
    
}

//声明
-(void)getDataWithOne{
    self.TextViewShow.textColor=RGBCOLOR(154, 154, 154, 1);
    
    
//    http://115.29.34.238/mentalpre/?  m=appapi&s=system&act=statement 
    
    NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
    NSDictionary*params=@{@"m":@"appapi",@"s":@"system",@"act":@"statement"};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
        NSLog(@"%@",data);
        if ([data[@"errorCode"] isEqualToString:@"0"]) {
            self.TextViewShow.text=data[@"data"];
         
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }

    }];

    
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

@end
