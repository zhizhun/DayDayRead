//
//  Tool.m
//  UILesson12_cell自适应高度
//
//  Created by 王志准 on 16/4/21.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "Tool.h"

@implementation Tool

//声明类方法用来计算文本高度
+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font {
    
    //ios7.0中求文本高度。返回一个cgrect的高度
    
    //第一个参数
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 10000);
    //第二个参数：设置以行高为单位
    
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
}

//声明类方法用来计算文本宽度
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font {
    //ios7.0中求文本高度。返回一个cgrect的宽度
    
    //第一个参数
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 10000);
    //第二个参数：设置以行高为单位
    
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;

}
#pragma mark -- 计算文本高度
+ (CGFloat)calculateTextHeightWithMovie:(NSString *)string LabelWidth:(CGFloat)width font:(CGFloat)font
{
    CGSize size = CGSizeMake(width, 1000000);
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    CGRect frame = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return  frame.size.height;
    
}
//计算图片高度
+ (CGFloat)imageHeightWithImage:(UIImage *)image {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    if (width == 0) {
        return 0;
    }
    return height/width*([UIScreen mainScreen].bounds.size.width);
}
@end
