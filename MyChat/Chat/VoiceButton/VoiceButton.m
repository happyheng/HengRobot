//
//  VoiceButton.m
//  小恒机器人
//
//  Created by 刘恒 on 15/10/4.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import "VoiceButton.h"

@implementation VoiceButton

-(instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"调用了VoiceButton的initWithCoder方法");
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
         NSLog(@"调用了VoiceButton的initWithFrame方法");
    }
    return self;
}



/**
 重写点击事件
 */
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.buttonTouchDelegate voiceButtonTouchBegan];
}


-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    [self.buttonTouchDelegate voiceButtonTouchEnded];
}

/**
 每回创建的时候都会调用drawRect方法
 */
- (void)drawRect:(CGRect)rect {
     NSLog(@"调用了VoiceButton的drawRect方法");}

@end
