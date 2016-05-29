//
//  BaseChatTableViewCell.m
//  小恒机器人
//
//  Created by 刘恒 on 15/10/3.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import "BaseChatTableViewCell.h"

#import "ResizableImageTool.h"

#import "OtherChatTableViewCell.h"

#import "OwnChatTableViewCell.h"

//chatLabel居左的距离
#define chatLabelLeftMagin 75

//屏幕宽度
#define screenWidth [UIScreen mainScreen].bounds.size.width


@interface BaseChatTableViewCell(){
    
    //聊天label真正的大小
    CGSize chatLabelTrueSize;
}

@end

@implementation BaseChatTableViewCell

/**
 设置此Cell聊天内容的方法，此方法在设置chatLabel内容的同时，也会自动设置聊天内容的背景图片
 */
-(void) setChatContentString:(NSString *) chatString{
    
    /*
     因为cell会复用，但你不知道是真正原来位置的复用，还是别的位置取你的来进行复用
     
     假如只有三个cell，拖拽向上滑动一些，消失了，在撒手，这就是真正原来位置的复用
     
     假如有一百个cell，滑动到最底端，就可能去最上面的cell来进行填充，所以必须要进行判断
     
     如果要显示的内容不一样的话，重新生成
     
     */
    if (![self.chatLabel.text isEqualToString:chatString]) {
        
        
        //1.设置聊天内容
        self.chatLabel.text = chatString;
        
        
        //得到真实高度
        [self getMyCurrentHeightAndLabelCurrentSize];
        
        
        //如果是其他人聊天的话
        if ([NSStringFromClass([self class]) isEqualToString:NSStringFromClass([OtherChatTableViewCell class])]) {
            
            //设置其他人的聊天的背景图片
            [self.chatContentImageView setImage:[ResizableImageTool getResizableImageWithImageName:@"otherChat.png" andTopMagin:45 LeftMagin:30 ButtomMagin:15 RightMagin:15]];
            
            //设置聊天的背景图片的大小
            self.chatImageViewTrailingConstraint.constant = -(screenWidth-chatLabelLeftMagin-chatLabelTrueSize.width-5);
            
        }else {
            
            //设置自己的聊天的背景图片
            [self.chatContentImageView setImage:[ResizableImageTool getResizableImageWithImageName:@"myChat.png" andTopMagin:45 LeftMagin:15 ButtomMagin:15 RightMagin:30]];
            
            //设置聊天的背景图片的大小
            self.chatImageViewTrailingConstraint.constant = screenWidth-chatLabelLeftMagin-chatLabelTrueSize.width-5;
        }
        
    }
    
    
    
}

/**
 1.得到这个cell的currentCellHeight值
 2.得到里面label正确的大小
 */
-(void) getMyCurrentHeightAndLabelCurrentSize{
    
    
    chatLabelTrueSize = [self.chatLabel.text  boundingRectWithSize:
                               //注意第一个参数是指定的label的宽度
                               CGSizeMake(screenWidth-95, CGFLOAT_MAX)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                              attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.chatLabel.font,NSFontAttributeName, nil] context:nil].size;
    
    //得到chatlabel的高度
    CGFloat chatLabelHeight = chatLabelTrueSize.height;
    
    //得到并设置自己的真实高度
    self.currentCellHeight = chatLabelHeight+30;
    
    
}



/**
 
 废弃的方法，使用这个方法在第二次获取高度的时候会获取错误，还是不适用这种自动获取了，略坑
 
 得到这个cell的currentCellHeight值
 */
//-(void) getMyCurrentHeight{
//
//
//
//    //设置label的最大宽度,其中95是chatLabel左边的约束加上右边的约束,
//    /*
//     但是我们需要注意的是，我们的chatLabel右边本来是没有约束的，这样做的好处就是得到chatLabel的宽高是其
//     真实宽高
//
//     因为假如我们约束了chatLabel的上下左右的话，如果chatLabel只有一行字的话，那么他的宽高就不是真实的宽高
//
//     而我们向下面这种约束的话，设置了label的最大宽度，但是label的实际宽度是可以少于这个最大宽度的，这种方法就能得到label的最大宽度了
//     */
//    self.chatLabel.preferredMaxLayoutWidth = screenWidth - 95;
//
//    //调整布局
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//
//
//    //得到并设置自己的真实高度
//    self.currentCellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
//    
//    
//}

@end
