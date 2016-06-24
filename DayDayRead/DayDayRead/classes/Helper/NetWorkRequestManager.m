//
//  NetWorkRequestManager.m
//  MusicPlayer
//
//  Created by 王志准 on 16/6/13.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "NetWorkRequestManager.h"

@implementation NetWorkRequestManager

singleton_implementation(NetWorkRequestManager)

+ (void)requestType:(RequestType)type urlString:(NSString *)urlString prama:(NSDictionary *)pramas success:(RequestSuccessed)success fail:(RequestFailed)fail {
    //转到对象方法进行实现
    NetWorkRequestManager *manager = [NetWorkRequestManager shareNetWorkRequestManager];
    [manager requestWithType:type urlString:urlString prama:pramas success:success fail:fail];
    
}
- (void)requestWithType:(RequestType)type urlString:(NSString *)urlString prama:(NSDictionary *)pramas success:(RequestSuccessed)success fail:(RequestFailed)fail{
    //1.使用urlSession
    NSURLSession *session = [NSURLSession sharedSession];
    //2.准备url
    NSURL *url = [NSURL URLWithString:urlString];
    //3.设置request对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //判断请求类型
    if (type == POST) {
        //设置请求方式
        request.HTTPMethod = @"POST";
        //post参数需要加在body里面，将字典中的内容转成符合 key=value&key=value形式
        if (pramas.count>0) {
            NSData *data = [self parDicToDataWithDic:pramas];
            [request setHTTPBody:data];
        }
    }
    //链接并发送请求
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //当调用block之前必须确认存在，否则崩溃
        if (data && !error) {
            if (success) {
                success(data);
            }
        }else{
            if (!data) {
                NSLog(@"请求数据为空");
            }
            if (error) {
                if (fail) {
                    fail(error);
                }
            }
        }
    }];
    [task resume];
    
}
- (NSData *)parDicToDataWithDic:(NSDictionary *)dic{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    //遍历字典内的所有key 和 value (数组中也有类似方法)
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [arr addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
    }];
    //使用&进行拼接
    NSString *parString = [arr componentsJoinedByString:@"&"];
    return [parString dataUsingEncoding:NSUTF8StringEncoding];
}
@end
