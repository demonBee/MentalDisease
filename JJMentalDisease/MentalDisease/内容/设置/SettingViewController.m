//
//  SettingViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/26.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "SettingViewController.h"
#import "AdviceGetViewController.h"
#import "AboutOurAndSayViewController.h"
#import "LoginViewController.h"
#import "RitrieveCodeViewController.h"   //修改密码


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    [self.view addSubview:self.tableView];
    
    
    UIBarButtonItem*item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NaviBack"] style:UIBarButtonItemStylePlain target:self action:@selector(postNoti)];
    self.navigationItem.leftBarButtonItem=item;
    
}

-(void)postNoti{
    [self.navigationController popViewControllerAnimated:YES];
    //通知主控制器  打开侧边栏
    [[NSNotificationCenter defaultCenter]postNotificationName:@"openRightView" object:nil];

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
     cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row==100) {
        cell.textLabel.text=@"意见反馈";
    }else if (indexPath.row==0){
        cell.textLabel.text=@"关于我们";
    }else if (indexPath.row==1){
        cell.textLabel.text=@"声明";
    }else if (indexPath.row==2){
        cell.textLabel.text=@"修改密码";

    }else if (indexPath.row==3){
        cell.textLabel.text=@"退出登录";
    }
    
    
       return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==100) {
        //意见反馈
        AdviceGetViewController*vc=[[AdviceGetViewController alloc]initWithNibName:@"AdviceGetViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row==0){
        //关于我们
       AboutOurAndSayViewController*vc= [AboutOurAndSayViewController creatVCWitchCate:0];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row==1){
        //声明
        AboutOurAndSayViewController*vc= [AboutOurAndSayViewController creatVCWitchCate:1];
         [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row==2){
        //修改密码
        RitrieveCodeViewController*vc=[[RitrieveCodeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row==3){
        //退出登录
        [self ESCLogin];
    }
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}

-(void)ESCLogin{
    //退出登录
   UserSession*user= [UserSession instance];
    [user cleanUser];
    
    NSUserDefaults*UserDe=[NSUserDefaults standardUserDefaults];
    [UserDe removeObjectForKey:AUTOLOGINACCOUNT];
    [UserDe removeObjectForKey:AUTOLOGINCODE];
    
    UIWindow*window=[UIApplication sharedApplication].keyWindow;
    LoginViewController*vc=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    
    XXNavigationController*navi=[[XXNavigationController alloc]initWithRootViewController:vc];

    window.rootViewController=navi;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    
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
@end
