//
//  ArchiverHandle.m
//  豆瓣
//
//  Created by lanou3g on 16/6/21.
//  Copyright © 2016年 王治庭. All rights reserved.
//

#import "ArchiverHandle.h"

@implementation ArchiverHandle

singleton_implementation(ArchiverHandle)
// 归档

- (NSData *)dataOfArchiveObject:(id)object forKey:(NSString *)key {
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    return data;

}



// 反归档
- (id)unArchiveObject:(NSData *)data forKey:(NSString *)key {
    
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id object = [unArchiver decodeObjectForKey:key];
    return object;
}


@end
