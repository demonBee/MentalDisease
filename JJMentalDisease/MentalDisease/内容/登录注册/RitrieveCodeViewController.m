//
//  RitrieveCodeViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/31.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "RitrieveCodeViewController.h"
#import "GetCodeTextFieldTableViewCell.h"
#import "YanzhengmaTableViewCell.h"
#import "STCountDownButton.h"   //验证码

#define TEXTFIELDCELL   @"GetCodeTextFieldTableViewCell"
#define YANZHENGMA    @"YanzhengmaTableViewCell"

@interface RitrieveCodeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,assign)BOOL canSave;

@property(nonatomic,strong)UITextField*textFieldPhone;
@property(nonatomic,strong)UITextField*textFieldfirstCode;
@property(nonatomic,strong)UITextField*textFieldSecondCode;
@property(nonatomic,strong)UITextField*textFieldYanzhengCode;

@end

@implementation RitrieveCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"找回密码";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:TEXTFIELDCELL bundle:nil] forCellReuseIdentifier:TEXTFIELDCELL];
    [self.tableView registerNib:[UINib nibWithNibName:YANZHENGMA bundle:nil] forCellReuseIdentifier:YANZHENGMA];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GetCodeTextFieldTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:TEXTFIELDCELL];
    cell.selectionStyle=NO;
    UITextField*textField=[cell viewWithTag:11];
    if (indexPath.row==0) {
        textField.placeholder=@"手机号";
        self.textFieldPhone=textField;
        self.textFieldPhone.keyboardType=UIKeyboardTypeNumberPad;
        return cell;
    }else if (indexPath.row==1){
        textField.placeholder=@"设置密码";
        self.textFieldfirstCode=textField;
        self.textFieldfirstCode.secureTextEntry=YES;
        return cell;
    }else if (indexPath.row==2){
        textField.placeholder=@"重复密码";
        self.textFieldSecondCode=textField;
        self.textFieldSecondCode.secureTextEntry=YES;

        return cell;
    }else if (indexPath.row==3){
        YanzhengmaTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:YANZHENGMA];
            cell.selectionStyle=NO;
        UITextField*textField=[cell viewWithTag:11];
        textField.placeholder=@"手机验证码";
        self.textFieldYanzhengCode=textField;
        self.textFieldYanzhengCode.keyboardType=UIKeyboardTypeNumberPad;

        
        [cell.PostYanzhengma setSecond:60];
        [cell.PostYanzhengma addTarget:self action:@selector(PostYanzhengCode:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    
    
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
    bottomView.backgroundColor=[UIColor clearColor];
    
    UIButton*bottmBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 20, KScreenWidth-40, 44)];
    bottmBtn.backgroundColor=BaseColor;
    bottmBtn.layer.cornerRadius=12;
    bottmBtn.layer.masksToBounds=YES;
    [bottmBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    [bottmBtn addTarget:self action:@selector(touchChongzhi) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottmBtn];
    
    return bottomView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 64;
}

-(void)touchChongzhi{
    //重置密码
    NSString*str=[self judgeForChongzhiCode];
    if (self.canSave==NO) {
        [JRToast showWithText:str];
    }else{
//         http://115.29.34.238/mentalpre /?   m=appapi&s=system&act=up_fwd&tel=&pwd=&code=
        NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
        NSDictionary*params=@{@"m":@"appapi",@"s":@"system",@"act":@"up_fwd",@"tel":self.textFieldPhone.text,@"pwd":self.textFieldfirstCode.text,@"code":self.textFieldYanzhengCode.text};
        HttpManager*manager=[[HttpManager alloc]init];
        [manager getDataFromNetworkWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
            NSLog(@"%@",data);
            if ([data[@"errorCode"] isEqualToString:@"0"]) {
                [JRToast showWithText:data[@"errorMessage"]];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [JRToast showWithText:data[@"errorMessage"]];

            }
            
            
        }];
        
    }
    
}

-(void)PostYanzhengCode:(STCountDownButton*)sender{
    NSString*str=[self judgeForYanzhengCode];
    if (self.canSave==NO) {
        [JRToast showWithText:str];
    }else{
        //获取重置验证码
// http://115.29.34.238/mentalpre /?  m=appapi&s=system&act=forget_yz&tel=
        NSString*urlStr=[NSString stringWithFormat:@"%@",HTTP_ADDRESS];
        NSDictionary*params=@{@"m":@"appapi",@"s":@"system",@"act":@"forget_yz",@"tel":self.textFieldPhone.text};
        HttpManager*manager=[[HttpManager alloc]init];
        [manager getDataFromNetworkNOHUDWithUrl:urlStr parameters:params compliation:^(id data, NSError *error) {
            if ([data[@"errorCode"] isEqualToString:@"0"]) {
                [JRToast showWithText:data[@"errorMessage"]];
                [sender start];

            }else{
                [JRToast showWithText:data[@"errorMessage"]];

            }
            
            
        }];
        
        
        
    }
    
   
    
    
}

-(NSString*)judgeForYanzhengCode{
    self.canSave=YES;
    if (self.textFieldPhone.text.length!=11) {
        self.canSave=NO;
        return @"请正确输入手机号";
    }
    
    
    return @"MB";
}

-(NSString*)judgeForChongzhiCode{
    self.canSave=YES;
    if (self.textFieldPhone.text.length!=11) {
        self.canSave=NO;
        return @"请正确输入手机号";
    }else if (self.textFieldfirstCode.text.length<6){
        self.canSave=NO;
        return @"密码不能小于6位";
    }else if (![self.textFieldfirstCode.text isEqualToString:self.textFieldSecondCode.text]){
        self.canSave=NO;
        return @"两次密码输入不一致";
    }else if (self.textFieldYanzhengCode.text.length<4){
        self.canSave=NO;
        return @"验证码不能小于4位";
    }
    
    return @"gun";
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
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


@end
