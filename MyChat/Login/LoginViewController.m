//
//  LoginViewController.m
//  IOSBmobDemo
//
//  Created by 刘恒 on 15/10/2.
//  Copyright (c) 2015年 cn.com.hibor. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"

#import "ChatViewController.h"



@interface LoginViewController (){
    
}

@end

@implementation LoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    //开始动画，记得有一定时间的延迟
    //动画网址: http: //blog.sina.com.cn/s/blog_8d1bc23f0102vqs1.html
    //UIViewAnimationOptionCurveEaseInOut 此枚举值为时间曲线函数，由慢到快
    [UIView animateWithDuration:1.0f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //更改约束
        self.imageViewMaginTopConstraint.priority = UILayoutPriorityDefaultLow;
        self.imageViewCenterScrollConstraint.priority = UILayoutPriorityDefaultHigh;
        
        self.loginButtonMaginFiedConstraint.constant = 50;
        
        //更改透明度
        [self setAllViewAlpha:1.0];
        
        //记得要一定使用此方法，否则会直接更新约束
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [self.loginTextField setPlaceholder:@"请输入用户名"];
        
        [self.passWordTextField setPlaceholder:@"请输入密码"];
        
    }];
    
}

/**

 设置所有组件透明度的方法
 
 */
-(void) setAllViewAlpha:(CGFloat) alpha{
    
    
    [self.imageView setAlpha:alpha];
    [self.loginTextField setAlpha:alpha];
    [self.passWordTextField setAlpha:alpha];
    [self.loginButton setAlpha:alpha];
    [self.registerButton setAlpha:alpha];
    
    
    
}


/**
 
 登陆按钮的点击事件
 
 */
- (IBAction)loginClickEvent:(id)sender {
    
    
    [self.view endEditing:YES];
    
    //跳转到聊天界面
    ChatViewController * chatViewController = [[ChatViewController alloc] init];
    
    [self.navigationController pushViewController:chatViewController animated:YES];
    
    
}


/**
 
 注册按钮的点击事件
 
 */
- (IBAction)registerClickEvent:(id)sender {
    
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerViewController animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
