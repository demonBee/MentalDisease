//
//  RightViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/26.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "RightViewController.h"
#import "RightViewTableViewCell.h"

#define RightViewCell   @"RightViewTableViewCell"


@interface RightViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)UIImageView*headerImageView;
@property(nonatomic,strong)UILabel*userLabel;

@property(nonatomic,strong)UIImageView*redPoint;

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changePhoto) name:@"changePhoto" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshRight) name:@"refreshRight" object:nil];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:RightViewCell bundle:nil] forCellReuseIdentifier:RightViewCell];
    
}

-(void)refreshRight{
    [self.tableView reloadData];
}

-(void)changePhoto{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[UserSession instance].logo] placeholderImage:nil];
    self.userLabel.text=[UserSession instance].user;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightViewTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:RightViewCell];
    cell.selectionStyle=NO;
    UIImageView*imageView=[cell viewWithTag:11];
    UILabel*nameLabel=[cell viewWithTag:2];
    nameLabel.textColor=RGBCOLOR(82, 83, 84, 1);
  
    
    if (indexPath.row==0) {
        imageView.image=[UIImage imageNamed:@"icon_right_home_n"];
      
        nameLabel.text=@"首页";
    }else if (indexPath.row==1){
        imageView.image=[UIImage imageNamed:@"icon_right_infro_n"];
        nameLabel.text=@"基本资料";
    }else if (indexPath.row==2){
        imageView.image=[UIImage imageNamed:@"icon_right_history_n"];
        nameLabel.text=@"答题纪录";
    }else if (indexPath.row==3){
        imageView.image=[UIImage imageNamed:@"icon_right_hospital_n"];
        nameLabel.text=@"就诊医院查询";
    }else if (indexPath.row==4){
        imageView.image=[UIImage imageNamed:@"icon_right_message_n"];
        nameLabel.text=@"消息";
        //加个小红点    0没有标点    1为有标点
       NSString*info= [UserSession instance].info;
        UIImageView*imageViewaa=[cell viewWithTag:121];
        if (!imageViewaa) {
            imageViewaa=[[UIImageView alloc]initWithFrame:CGRectMake(100, nameLabel.centerY-5, 8, 8)];
            imageViewaa.backgroundColor=[UIColor redColor];
            imageViewaa.layer.cornerRadius=4;
            imageViewaa.layer.masksToBounds=YES;
            imageViewaa.tag=121;
            [cell.contentView addSubview:imageViewaa];
            imageViewaa.hidden=YES;
            self.redPoint=imageViewaa;
        }

        if (![info isEqualToString:@"0"]) {
            imageViewaa.hidden=NO;
        }else{
            imageViewaa.hidden=YES;
        }
        
        
    }else if (indexPath.row==5){
        imageView.image=[UIImage imageNamed:@"icon_right_share_n"];
        nameLabel.text=@"分享";
    }else if (indexPath.row==6){
        imageView.image=[UIImage imageNamed:@"icon_right_setting_n"];
        nameLabel.text=@"设置";
    }else if (indexPath.row==7){
        imageView.image=[UIImage imageNamed:@"icon_right_feedback_n"];
        nameLabel.text=@"咨询与反馈";
        
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView reloadData];
    
    RightViewTableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    UIImageView*imageView=[cell  viewWithTag:11];
    if (indexPath.row==0) {
        imageView.image=[UIImage imageNamed:@"icon_right_home_h"];
    }else if (indexPath.row==1){
        imageView.image=[UIImage imageNamed:@"icon_right_infro_h"];
          }else if (indexPath.row==2){
        imageView.image=[UIImage imageNamed:@"icon_right_history_h"];
           }else if (indexPath.row==3){
        imageView.image=[UIImage imageNamed:@"icon_right_hospital_h"];
          }else if (indexPath.row==4){
        imageView.image=[UIImage imageNamed:@"icon_right_message_h"];
              //加个小红点   只改内存中的  另一个 后台会改
              [UserSession instance].info=@"0";
//              [self.tableView reloadData];
              self.redPoint.hidden=YES;
              
        
    }else if (indexPath.row==5){
        imageView.image=[UIImage imageNamed:@"icon_right_share_h"];
     
        
    }else if (indexPath.row==6){
        imageView.image=[UIImage imageNamed:@"icon_right_setting_h"];
    }else if (indexPath.row==7){
        imageView.image=[UIImage imageNamed:@"icon_right_feedback_h"];
    }

    
    UILabel*nameLabel=[cell viewWithTag:2];
    nameLabel.textColor=BaseColor;

    if ([self.delegate respondsToSelector:@selector(DelegateWithTouchWhichCell:)]) {
        [self.delegate DelegateWithTouchWhichCell:indexPath];
    }
    
    
}




-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 135)];
    headView.backgroundColor=[UIColor whiteColor];
    
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 60, 50, 50)];
    imageView.layer.cornerRadius=25;
    imageView.layer.masksToBounds=YES;
    imageView.layer.borderWidth=1;
    imageView.layer.borderColor=RGBCOLOR(21, 156, 88, 1).CGColor;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[UserSession instance].logo] placeholderImage:nil];
    [headView addSubview:imageView];
    _headerImageView=imageView;
    
    
    UILabel*nameLabel=[[UILabel alloc]init];
    [headView addSubview:nameLabel];
    nameLabel.text=[UserSession instance].user;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(15);
        make.centerY.mas_equalTo(imageView);
        make.width.equalTo(@(160));
    }];
    _userLabel=nameLabel;
    
    
    return headView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 135;
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor whiteColor];
    }
    return _tableView;
}

@end
