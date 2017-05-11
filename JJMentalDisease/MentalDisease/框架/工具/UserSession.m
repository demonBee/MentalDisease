//
//  UserSession.m
//  GKAPP
//
//  Created by 黄佳峰 on 15/11/6.
//  Copyright © 2015年 黄佳峰. All rights reserved.
//

#import "UserSession.h"

@implementation UserSession
static UserSession *user = nil;
//
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    if ([key isEqualToString:@"id"]) {
//        self.userId = value;
//    }
//}


+ (UserSession *) instance{

    if (!user) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            user=[[UserSession alloc]init];
        
            
         
//        });

        user=[[UserSession alloc]init];
        
      //没有 第一次 会创建  之后再也不会
        
            user.token=@"1";
           

    }
//创建一次之后一直都在
    
    return user;
}


-(void)cleanUser{
    
    user=nil;
  
     


}

//如果  没有一一对应    少这句话 就崩
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
