//
//  VoiceButton.h
//  小恒机器人
//
//  Created by 刘恒 on 15/10/4.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 VoiceButton的触摸回调协议
 */
@protocol VoiceButtonTouchDelegate <NSObject>

@required
/**
 VoiceButton开始触摸的时候
 */
-(void) voiceButtonTouchBegan;
/**
 VoiceButton结束触摸的时候
 */
-(void) voiceButtonTouchEnded;

@end

/**
 自定义的语音按钮
 可响应开始触摸和取消触摸事件
 */
@interface VoiceButton : UIButton{
    
}

@property (nonatomic) id<VoiceButtonTouchDelegate> buttonTouchDelegate;

@end
