//
//  UserFileHandle.h
//  豆瓣
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 王治庭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <UIKit/UIKit.h>
@interface UserFileHandle : NSObject
#pragma mark - 方法
+ (instancetype)shareInstance;



// 存储用户信息
+ (void)saveUserInfo:(User *)user;



// 删除用户信息
+(void)deleteUserInfo;


// 查询用户信息
+ (User *)selectUserInfo;

#pragma mark - 数据库
#pragma mark 缓存文件夹
- (NSString *)cachesPath;

#pragma mark 数据库路径
//数据库存储的路径
- (NSString *)databaseFilePath:(NSString *)databaseName;



#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
- (NSString *)imageFilePathWithURL:(NSString *)imageURL;
#pragma mark 保存图片缓存
- (void)saveDownloadImage:(UIImage *)image filePath:(NSString *)path;
#pragma mark 清除缓存
- (void)cleanDownloadImages;


@end
