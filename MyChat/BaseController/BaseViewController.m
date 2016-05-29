//
//  BaseViewController.m
//  IOSBmobDemo
//
//  Created by 刘恒 on 15/10/2.
//  Copyright (c) 2015年 cn.com.hibor. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //去除ScrollView顶部预留位置
    self.automaticallyAdjustsScrollViewInsets=NO;

}


/**
 
 显示弹出框的方法
 
 message  : 　弹出框中需要显示的信息
 
 */
-(void) showAlertDialogWithMessage:(NSString *) message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
    
    
    
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
