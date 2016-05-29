//
//  BaseCellDataType.m
//  小恒机器人
//
//  Created by 刘恒 on 15/10/3.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import "BaseCellDataType.h"

@implementation BaseCellDataType

-(instancetype) initWithChatString:(NSString *) chatString andIsOwn:(BOOL) isOwn{
    
    self = [super init];
    
    if (self) {
        
        self.chatString = chatString;
        
        self.isOwn = isOwn;
        
    }

    return self;
    
}

@end
