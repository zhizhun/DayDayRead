//
//  BookReadManager.h
//  DayDayRead
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "bookDetail.h"
#import <sqlite3.h>
@interface BookReadManager : NSObject


singleton_interface(BookReadManager)


// 打开数据库
- (void)openBookRead;

// 关闭数据库
- (void)closeBookRead;

// 创建表
- (void)createTablle;

// 插入
- (void)insertNewBook:(bookDetail *)book;

// 删除
- (void)deleteBook:(bookDetail *)book;

// 查询某个
- (bookDetail *)selectBookWithID:(NSString *)ID;

// 查询所有
- (NSMutableArray *)selectAllBooks;

// 判断是否收藏
- (BOOL)isFavorateBookWithID:(NSString *)ID;




@end
