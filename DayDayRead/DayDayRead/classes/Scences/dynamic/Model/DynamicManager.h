//
//  DynamicManager.h
//  DayDayRead
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Dynamic.h"
#import <sqlite3.h>

@interface DynamicManager : NSObject

singleton_interface(DynamicManager)


//打开数据库
- (void)openDM;

//关闭数据库

- (void)closeDM;
//创建表
- (void)createTable;
//插入
- (void)insertNewDynamic:(Dynamic*)dynamic;
//删除
- (void)deleteDynamic:(Dynamic*)dynamic;
//查询某个
- (Dynamic *)selectDynamicWith_id:(NSString *)_id;
//查询所有
- (NSMutableArray *)selectAllDynamic;
//判断是否转发
- (BOOL)isFavoriteDynamicWith_id:(NSString *)_id;

@end
