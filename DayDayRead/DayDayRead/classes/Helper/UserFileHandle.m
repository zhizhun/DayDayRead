//
//  UserFileHandle.m
//  豆瓣
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 王治庭. All rights reserved.
//

#import "UserFileHandle.h"
#import <UIImageView+WebCache.h>

#define kFileSize @"size"

#define kUserId @"userId"
#define kAvatar @"avatar"
#define kPassword @"password"
#define kUserName @"userName"
#define kIsLogin @"isLogin"

//存储对象类型的
#define kUserDefaults(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]
//存储BOOL类型的
#define kBoolUserDefaults(value,key) [[NSUserDefaults standardUserDefaults] setBool:value forKey:key]

//获取对象类型的值
#define kGetObjectUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
//获取BOOL类型值
#define kGetBoolUserDefaults(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]


@implementation UserFileHandle


static UserFileHandle *fileDataHandle = nil;
+ (instancetype)shareInstance
{
    if (fileDataHandle == nil) {
        fileDataHandle = [[[self class] alloc] init];
    }
    return fileDataHandle;
}

- (void)setFilesSize:(CGFloat)size
{
    [[NSUserDefaults standardUserDefaults] setFloat:size forKey:kFileSize];
}
/**
 *  存储用户信息
 *
 *  @param user 用户对象
 */
+ (void)saveUserInfo:(User *)user
{
    
    kUserDefaults(user.userId, @"userId");
    kUserDefaults(user.userName, @"userName");
    kUserDefaults(user.password, @"password");
    ;
    kBoolUserDefaults(user.isLogin, @"loginState");
    kUserDefaults(user.avatar, @"avatar");
    
}
/**
 *  获取用户信息
 *
 *  @return 用户对象
 */
+ (User *)selectUserInfo
{
    User * user = [[User alloc] init];
    user.userId   =  kGetObjectUserDefaults(@"userId");
    user.userName =  kGetObjectUserDefaults(@"userName");
    user.password =  kGetObjectUserDefaults(@"password");
    user.isLogin =  kGetBoolUserDefaults(@"loginState");
    user.avatar = kGetObjectUserDefaults(@"avatar");
    return user;
}
/**
 *  删除用户信息
 */
+ (void)deleteUserInfo
{
    kUserDefaults(nil, @"userId");
    kUserDefaults(nil, @"userName");
    kUserDefaults(nil, @"password");
    kBoolUserDefaults(NULL, @"loginState");
    kUserDefaults(nil, @"avatar");
}


#pragma mark - 数据库
#pragma mark 缓存文件夹
- (NSString *)cachesPath
{
    return  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

//数据库存储的路径
- (NSString *)databaseFilePath:(NSString *)databaseName
{
    NSLog(@"%@",[[self cachesPath] stringByAppendingPathComponent:databaseName]);
    return [[self cachesPath] stringByAppendingPathComponent:databaseName];
}





#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
#pragma mark----自定义存储图片。将下载下来的图片保存在本地沙盒中，每张图片的名字统一格式是，将imageURL中‘/’都替换成‘_’作为图片文件的名字。
- (NSString *)imageFilePathWithURL:(NSString *)imageURL
{
    //根据图像的URL，创建图像在存储时的文件名
    NSString * imageName = [imageURL stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    
    return [[self downloadImageManagerFilePath] stringByAppendingPathComponent:imageName];
}
//通常用于删除缓存的时，计算缓存大小
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//将下载的图片存储到沙盒中
- (void)saveDownloadImage:(UIImage *)image filePath:(NSString *)path
{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    [data writeToFile:path atomically:YES];
    CGFloat size = [self folderSizeAtPath:[self downloadImageManagerFilePath]];
    //获取SDWebImage下载图片时的缓存，并得到大小
    size = size + [[SDImageCache sharedImageCache] getSize] / (1024.0*1024.0);
    NSLog(@"%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]);
    [self setFilesSize:size];
}
#pragma mark 存储下载图片的文件夹路径
- (NSString *)downloadImageManagerFilePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * imageManagerPath = [[self cachesPath] stringByAppendingPathComponent:@"DownloadImages"];
    if (NO == [fileManager fileExistsAtPath:imageManagerPath]) {
        //如果沙盒中没有存储图像的文件夹，创建文件夹
        [fileManager createDirectoryAtPath:imageManagerPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return imageManagerPath;
}

#pragma mark 清除缓存
- (void)cleanDownloadImages
{
    //清除头像图片
    [[SDImageCache sharedImageCache] clearDisk];
    
    NSString * imageManagerPath = [self downloadImageManagerFilePath];
    //清除活动列表和电影列表对应 的图片
    NSFileManager * fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageManagerPath error:nil];
    [self setFilesSize:0];
    
}





@end
