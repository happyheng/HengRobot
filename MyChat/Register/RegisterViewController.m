//
//  RegisterViewController.m
//  IOSBmobDemo
//
//  Created by 刘恒 on 15/10/2.
//  Copyright (c) 2015年 cn.com.hibor. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController (){
    
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //开始动画，记得有一定时间的延迟
    [UIView animateWithDuration:0.7f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //更改约束
        self.userNameMaginTopConstraint.priority = UILayoutPriorityDefaultLow;
        self.userNameCenterScrollConstraint.priority = UILayoutPriorityDefaultHigh;
        
        self.registerButtonMaginFiledConstraint.constant = 50;
        
        //更改透明度
        [self setViewAlpha:1.0];
        
        //记得要一定使用此方法，否则会直接更新约束
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [self.userNameTextField setPlaceholder:@"请输入6-14位英文账号"];
        
        [self.firstPassWordTextField setPlaceholder:@"请输入6位以上字符的密码"];
        
        [self.secondPassWrodTextField setPlaceholder:@"请再次输入上面的密码"];
        
        
        
        
    }];
    
}


/**
 
 设置所有View透明度的问题
 
 */
-(void) setViewAlpha:(CGFloat) alpha{
    
    [self.titleView setAlpha:alpha];
    [self.userNameTextField setAlpha:alpha];
    [self.firstPassWordTextField setAlpha:alpha];
    [self.secondPassWrodTextField setAlpha:alpha];
    [self.registerButton setAlpha:alpha];
    
}


/**
 
 注册按钮的点击事件
 
 */
- (IBAction)registerButtonClickEvent:(id)sender {
    
    
    NSString *userNameText = self.userNameTextField.text;
    
    long userNameTextLength = userNameText.length;
    
    NSString *firstPassWordText = self.firstPassWordTextField.text;
    
    NSString *secondPassWordText = self.secondPassWrodTextField.text;
    
    //用户名长度限制
    if (userNameTextLength>=6&&userNameTextLength<=14) {
        
        //用户名是否有空格
        if ([userNameText rangeOfString:@" "].location==NSNotFound) {
            
            //密码长度限制
            if(firstPassWordText.length>=6&&firstPassWordText.length<=22){
                
                //两次输入的密码是否正确
                if ([firstPassWordText isEqualToString:secondPassWordText]) {
                    
                    
                    NSLog(@"账号为%@\n密码为%@",userNameText,firstPassWordText);
                    
                    
                }
                else{
                    
                    [self showAlertDialogWithMessage:@"两次输入的密码不一致"];
                    
                }
                
            }
            else{
                
                [self showAlertDialogWithMessage:@"密码长度不正确"];
                
            }
            
        }else{
            
            [self showAlertDialogWithMessage:@"用户名不能含有空格"];
            
        }
        
    }else{
        
        
        [self showAlertDialogWithMessage:@"用户名长度不正确"];
        
    }
    
    
    
}



/**
 
 顶部返回按钮的点击事件
 
 */
- (IBAction)backButtonClickEvent:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
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

@end
