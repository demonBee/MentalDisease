//
//  SettingTitleViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/27.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "SettingTitleViewController.h"
#import "TextFieldTableViewCell.h"

#define TEXTFIELDCELL   @"TextFieldTableViewCell"

@interface SettingTitleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSString*firstTextFieldValue;  //默认的值
@end

@implementation SettingTitleViewController

+(instancetype)CreatsetTitle:(NSString*)title andTextField:(NSString*)text doneBlock:(void(^)(NSString*textValue))block{
    SettingTitleViewController*vc=[[SettingTitleViewController alloc]init];
    vc.title=title;
    vc.firstTextFieldValue=text;
    vc.myBlock=block;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:TEXTFIELDCELL bundle:nil] forCellReuseIdentifier:TEXTFIELDCELL];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(compBack)];
    self.navigationItem.rightBarButtonItem=right;
    
}

-(void)compBack{
    if (_myBlock) {
        _myBlock(self.firstTextFieldValue);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextFieldTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:TEXTFIELDCELL];
    cell.selectionStyle=NO;
    [cell getValue:self.firstTextFieldValue];
 
  [cell setTextFieldTextBlock:^(NSString *str) {
      NSLog(@"111  %@",str);
      
      self.firstTextFieldValue=str;
  }];
    return cell;
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

//需要遵循 UITextFieldDelegate 协议  并且   textField.delegate=self;

//点击return收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[self findFirstResponderBeneathView:self.view] resignFirstResponder];
    return YES;
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
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
