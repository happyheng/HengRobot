//
//  BaseChatTableViewCell.h
//  小恒机器人
//
//  Created by 刘恒 on 15/10/3.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseChatTableViewCell : UITableViewCell{
    
}

//chatImageView居右的约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *chatImageViewTrailingConstraint;

//cell真正的高度
@property (nonatomic) float currentCellHeight;


@property (strong, nonatomic) IBOutlet UIImageView *chatContentImageView;

@property (strong, nonatomic) IBOutlet UILabel *chatLabel;

/**
 设置此Cell聊天内容的方法，此方法在设置chatLabel内容的同时，也会自动设置聊天内容的背景图片
 */
-(void) setChatContentString:(NSString *) chatString;

@end
