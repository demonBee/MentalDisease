//
//  MainViewController.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/26.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "MainViewController.h"
#import "RightViewController.h"
#import "SettingViewController.h"
#import "InformationViewController.h"   //个人资料
#import "AdviceGetViewController.h"    //意见反馈


@interface MainViewController ()<UIWebViewDelegate,RightViewControllerDelegate,UMSocialUIDelegate>
@property(nonatomic,strong)UIWebView*webView;

@property(nonatomic,strong)RightViewController*rightVC;
@property(nonatomic,strong)UIView*cover;   //蒙板
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"普瑞心理";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor=RGBCOLOR(255, 255, 255, 1);
    [self.view addSubview:self.webView];
    self.webView.backgroundColor=[UIColor whiteColor];
    //默认（0，0）  吊方法
   NSIndexPath*indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self DelegateWithTouchWhichCell:indexPath];
    
    [self addNaviItem];
    
    
    UIWindow*window=[UIApplication sharedApplication].keyWindow;
    [window addSubview:self.cover];
    [window addSubview:self.rightVC.view];
    
    //加观察者  用于打开 侧边栏
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openRightView) name:@"openRightView" object:nil];
    
    
}

//通知
-(void)openRightView{
//    UIWindow*window=[UIApplication sharedApplication].keyWindow;
//    [window addSubview:self.cover];
//    [window addSubview:self.rightVC.view];
//    
//    
//        self.rightVC.view.x=85;
//        self.cover.alpha=0.5;
    
    
    self.rightVC.view.x=85;
    self.cover.alpha=0.5;
    
}


-(void)dismissRightView{
    //dismiss rightView
    [UIView animateWithDuration:0.25 animations:^{
        self.rightVC.view.x=KScreenWidth;
        self.cover.alpha=0;
        
    }];

    
    
}


#pragma mark  ---right   delegate
-(void)DelegateWithTouchWhichCell:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    if (indexPath.row==0) {
        //首页   h5
        self.title=@"普瑞心理";
             [self dismissRightView];

//        http://115.29.34.238/mentalpre/?  m=appapi&s=membercenter&act=home&operation=home&uid=1 		     （首页）
    
        
        NSString*urlStr=[NSString stringWithFormat:@"http://115.29.34.238/mentalpre/?m=appapi&s=membercenter&act=home&operation=home&uid=%@",[UserSession instance].token];
        
        
        
        NSURL*url=[NSURL URLWithString:urlStr];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        
        
        
    }else if (indexPath.row==1){
        //基本资料
        
         // title  不要填
        InformationViewController*vc=[[InformationViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
           [self dismissRightView];
        
    }else if (indexPath.row==2){
        //答题记录    h5
        self.title=@"答题记录";
        NSString*urlStr=[NSString stringWithFormat:@"http://115.29.34.238/mentalpre/?m=appapi&s=membercenter&act=answer_record&operation=list&uid=%@",[UserSession instance].token];
        
        NSURL*url=[NSURL URLWithString:urlStr];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
       [self dismissRightView];

    }else if (indexPath.row==3){
        //就诊医院查询     h5
        self.title=@"就诊医院查询";
        NSString*urlStr=[NSString stringWithFormat:@"http://115.29.34.238/mentalpre/?m=appapi&s=membercenter&act=hospital&uid=%@",[UserSession instance].token];
        
        NSURL*url=[NSURL URLWithString:urlStr];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        [self dismissRightView];

        
    }else if (indexPath.row==4){
        self.title=@"消息";
        //消息              h5    前台只需要小红点
        NSString*urlStr=[NSString stringWithFormat:@"http://115.29.34.238/mentalpre/?m=appapi&s=membercenter&act=feedback&uid=%@",[UserSession instance].token];
        
        
        NSURL*url=[NSURL URLWithString:urlStr];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        [self dismissRightView];

    }else if (indexPath.row==5){
        
        //分享
        [self dismissRightView];

              //调用快速分享接口
        
        
        //分享   也是可以改当前链接地址的
        [UMSocialData defaultData].extConfig.title = @"普瑞心理";
        //这个， http：   在新浪微博上 就是网页链接 按钮
        NSString *shareText = @"普瑞心理－－随时随地想测就测，http://115.29.34.238/mentalpre/?m=appapi&s=system&act=analysis";
        UIImage *shareImage = [UIImage imageNamed:@"xiagao"];
        //分享内嵌图片
        //        UIImage *shareImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UMS_social_demo" ofType:@"png"]];
//        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.panda.tv"];
        
        
        //QQ空间和  QQ   title 设置
         [UMSocialData defaultData].extConfig.qqData.title = @"普瑞心理";
        [UMSocialData defaultData].extConfig.qzoneData.title = @"普瑞心理";
        //调用快速分享接口
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"57556210e0f55a5b81000d27"
                                          shareText:shareText
                                         shareImage:shareImage
                                    shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                           delegate:self];
        
        

        

        
        
    }else if (indexPath.row==6){
        //设置
        [self dismissRightView];
        SettingViewController*setVC=[[SettingViewController alloc]init];
        [self.navigationController pushViewController:setVC animated:YES];
        
        
    }else if (indexPath.row==7){
        //意见反馈
        [self dismissRightView];
        //意见反馈
        AdviceGetViewController*vc=[[AdviceGetViewController alloc]initWithNibName:@"AdviceGetViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];

        
    }





    
    
}

#pragma mark  ---- 代理
//下面得到分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
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

-(void)addNaviItem{
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showRightView)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
}

-(void)showRightView{

    
    [UIView animateWithDuration:0.25 animations:^{
        self.rightVC.view.x=85;
        self.cover.alpha=0.5;
        
    }];
    
}

-(RightViewController *)rightVC{
    if (!_rightVC) {
        _rightVC=[[RightViewController alloc]init];
        _rightVC.delegate=self;
        _rightVC.view.frame=CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight);
        
    }
    return _rightVC;
}

-(UIView *)cover{
    if (!_cover) {
        _cover=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _cover.backgroundColor=[UIColor blackColor];
        _cover.alpha=0;
        
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissRightView)];
        [_cover addGestureRecognizer:tap];
    }
    
    return _cover;
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _webView.delegate=self;
        
    }
    return _webView;
}

@end
