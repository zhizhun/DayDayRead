//
//  Tool.h
//  UILesson12_cell自适应高度
//
//  Created by 王志准 on 16/4/21.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tool : NSObject
//声明类方法用来计算文本高度
+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font;
//声明类方法用来计算文本宽度
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font;
//计算某个label的高度
+ (CGFloat)calculateTextHeightWithMovie:(NSString *)string LabelWidth:(CGFloat)width font:(CGFloat)font;
//声明类方法用来计算图片高度
+ (CGFloat)imageHeightWithImage:(UIImage *)image;
@end
