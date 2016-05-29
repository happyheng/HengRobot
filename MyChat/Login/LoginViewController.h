//
//  LoginViewController.h
//  IOSBmobDemo
//
//  Created by 刘恒 on 15/10/2.
//  Copyright (c) 2015年 cn.com.hibor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

/**
 
 登陆界面
 
 */
@interface LoginViewController : BaseViewController{
    
}


//imageView距离顶部的约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewMaginTopConstraint;

//imageView与ScrollView纵向中心的约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewCenterScrollConstraint;


//登录button距离密码输入框的约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *loginButtonMaginFiedConstraint;





//头像imageView
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

//登录的输入框
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;

//密码的输入框
@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;

//登录按钮
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

//注册按钮
@property (strong, nonatomic) IBOutlet UIButton *registerButton;






@property (strong, nonatomic) IBOutlet NSLayoutConstraint *baseScrollViewButtomConstraint;

@end
