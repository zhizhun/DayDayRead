//
//  ArchiverHandle.h
//  豆瓣
//
//  Created by lanou3g on 16/6/21.
//  Copyright © 2016年 王治庭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface ArchiverHandle : NSObject

singleton_interface(ArchiverHandle)


// 归档

- (NSData *)dataOfArchiveObject:(id)object forKey:(NSString *)key;



// 反归档
- (id)unArchiveObject:(NSData *)data forKey:(NSString *)key;
@end
