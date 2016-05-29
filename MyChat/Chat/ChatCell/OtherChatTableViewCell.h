//
//  OwnChatTableViewCell.h
//  小恒机器人
//
//  Created by 刘恒 on 15/10/2.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseChatTableViewCell.h"

@interface OtherChatTableViewCell : BaseChatTableViewCell{
    
}

//chatImageView居左的约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *chatImageViewTrailingConstraint;

@property (strong, nonatomic) IBOutlet UIImageView *chatContentImageView;

@property (strong, nonatomic) IBOutlet UILabel *chatLabel;



@end
