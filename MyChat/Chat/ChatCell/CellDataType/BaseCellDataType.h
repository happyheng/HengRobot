//
//  BaseCellDataType.h
//  小恒机器人
//
//  Created by 刘恒 on 15/10/3.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 整个聊天TableView中cell的基本数据类型
 */
@interface BaseCellDataType : NSObject{
    
}

//聊天的信息
@property (nonatomic) NSString *chatString;

//是否是自己发出的消息
@property (nonatomic) BOOL isOwn;

//初始化方法
-(instancetype) initWithChatString:(NSString *) chatString andIsOwn:(BOOL) isOwn;


@end
