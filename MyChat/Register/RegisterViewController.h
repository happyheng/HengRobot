//
//  RegisterViewController.h
//  IOSBmobDemo
//
//  Created by 刘恒 on 15/10/2.
//  Copyright (c) 2015年 cn.com.hibor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController{
    
}

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *userNameMaginTopConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *userNameCenterScrollConstraint;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *registerButtonMaginFiledConstraint;





@property (strong, nonatomic) IBOutlet UIView *titleView;


@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;


@property (strong, nonatomic) IBOutlet UITextField *firstPassWordTextField;


@property (strong, nonatomic) IBOutlet UITextField *secondPassWrodTextField;


@property (strong, nonatomic) IBOutlet UIButton *registerButton;









@property (strong, nonatomic) IBOutlet NSLayoutConstraint *baseScrollViewButtomConstraint;

@end
