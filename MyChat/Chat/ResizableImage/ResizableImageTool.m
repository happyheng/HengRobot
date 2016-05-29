//
//  ResizableImageTool.m
//  小恒机器人
//
//  Created by 刘恒 on 15/10/2.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import "ResizableImageTool.h"



@implementation ResizableImageTool


+(UIImage *) getResizableImageWithImageName:(NSString *) resizableImageName andTopMagin:(CGFloat) top  LeftMagin:(CGFloat) left  ButtomMagin:(CGFloat) bottom  RightMagin:(CGFloat) right{
    
    UIImage* resizableImage =[UIImage imageNamed:resizableImageName];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    
    resizableImage = [resizableImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return resizableImage;
    
}

@end
