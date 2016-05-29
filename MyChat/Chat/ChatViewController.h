//
//  ChatViewController.h
//  小恒机器人
//
//  Created by 刘恒 on 15/10/2.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

#import "iflyMSC/iflyMSC.h"

#import "IATConfig.h"

#import "ISRDataHelper.h"

#import "VoiceButton.h"

@interface ChatViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,IFlySpeechRecognizerDelegate,VoiceButtonTouchDelegate>{
    
    
}

@property (strong,nonatomic) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *baseScrollViewButtomConstraint;


//聊天的展示tableView
@property (strong, nonatomic) IBOutlet UITableView *chatTableView;

//聊天的输入框
@property (strong, nonatomic) IBOutlet UITextField *editTextField;


@property (strong, nonatomic) IBOutlet VoiceButton *voiceButton;

@end
