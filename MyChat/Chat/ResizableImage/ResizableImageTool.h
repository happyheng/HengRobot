//
//  ResizableImageTool.h
//  小恒机器人
//
//  Created by 刘恒 on 15/10/2.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/**
 获取拉伸图片的工具类
 */
@interface ResizableImageTool : NSObject{
    
}

/**
 
 得到一个指定图片名称的可拉伸图片
 4个数分别是图片拉伸区域距顶，距左，距下，距右的距离。
 
 比如(10,10,10,10)即是拉伸区域距离原图上左下右都为10pt
 
 UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
 UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
 
 */
+(UIImage *) getResizableImageWithImageName:(NSString *) resizableImageName andTopMagin:(CGFloat) top  LeftMagin:(CGFloat) left  ButtomMagin:(CGFloat) bottom  RightMagin:(CGFloat) right;

@end
