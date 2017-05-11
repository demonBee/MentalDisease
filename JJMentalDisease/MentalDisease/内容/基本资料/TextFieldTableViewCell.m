//
//  TextFieldTableViewCell.m
//  MentalDisease
//
//  Created by 黄佳峰 on 16/5/27.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.TextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.TextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    _TextField.backgroundColor = [UIColor clearColor];
    _TextField.borderStyle = UITextBorderStyleNone;
    _TextField.font = [UIFont systemFontOfSize:16];
}

-(void)changeValue:(id)sender{
    if (self.textFieldTextBlock) {
        self.textFieldTextBlock(self.TextField.text);
    }
    
}

-(void)getValue:(NSString*)str{
    [self.TextField becomeFirstResponder];
    if ([str isEqualToString:@""]||str==nil) {
        self.TextField.placeholder=@"未填写";
    }else{
        self.TextField.text=str;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
