//
//  NetWorkRequestManager.h
//  MusicPlayer
//
//  Created by 王志准 on 16/6/13.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
//1.类型枚举 GET POST
// RequestType {GET POST}
//做项目中当需要实现某些固定类型选择的需求时使用枚举
typedef NS_ENUM(NSUInteger, RequestType) {
    GET,
    POST,
};
//2.成功和失败的回调 block

typedef void(^RequestSuccessed)(id data);
typedef void(^RequestFailed)(NSError *error);
@interface NetWorkRequestManager : NSObject
//单例
singleton_interface(NetWorkRequestManager)

//3.接口  调用
+ (void)requestType:(RequestType)type urlString:(NSString *)urlString prama:(NSDictionary *)pramas success:(RequestSuccessed)success fail:(RequestFailed)fail;
//预留（目前没有在需求中，但是后面可能添加进需求里面的接口）

@end
