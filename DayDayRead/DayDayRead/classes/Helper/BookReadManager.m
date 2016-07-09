//
//  BookReadManager.m
//  DayDayRead
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "BookReadManager.h"
#import "ArchiverHandle.h"
#import "UserFileHandle.h"
// 归档时所需要的key
#define kBookArchiver @"bookDetail"

@interface BookReadManager ()

// 数据储存路径
@property (nonatomic, strong) NSString *dataDetailPath;



@end
@implementation BookReadManager

singleton_implementation(BookReadManager)

- (NSString *)dataDetailPath {
    
    if (_dataDetailPath == nil) {
        NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        self.dataDetailPath = [document stringByAppendingPathComponent:@"BookRead.sqlite"];
    }
    return _dataDetailPath;
}

// 数据库指针
static sqlite3 *db = nil;
// 打开数据库
- (void)openBookRead {
    
   
    
    int result = sqlite3_open([self.dataDetailPath UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        [self createTablle];
    } else {
        NSLog(@"数据库打开失败");
    }
}

// 关闭数据库
- (void)closeBookRead {
    
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    } else {
        NSLog(@"数据库关闭失败");
    }
}

// 创建表

- (void)createTablle {
    
    NSString *createTable =  @"create table if not exists BookReadTable(userName TEXT, Id TEXT, title TEXT, imageUrl TEXT, data BLOB)";
    
    int result = sqlite3_exec(db, [createTable UTF8String], NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
}

// 插入
- (void)insertNewBook:(bookDetail *)book {
    
    [self openBookRead];
    
    sqlite3_stmt *stmt = nil;
    NSString *insetString = @"insert into BookReadTable(userName,Id,title,imageUrl, data) values (?,?,?,?,?)";
    int result = sqlite3_prepare_v2(db, [insetString UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [[UserFileHandle selectUserInfo].userName UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [book._id UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [book.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [[book.cover substringFromIndex:7] UTF8String], -1, NULL);
        NSString *archiverKey = [NSString stringWithFormat:@"%@%@", kBookArchiver, book._id];
        NSData *data = [[ArchiverHandle shareArchiverHandle] dataOfArchiveObject:book forKey:archiverKey];
        sqlite3_bind_blob(stmt, 5, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
        NSLog(@"%@",book._id);

    } else {
        NSLog(@"插入语句错误%d", result);
    }
    sqlite3_finalize(stmt);
    [self closeBookRead];
}

// 删除

- (void)deleteBook:(bookDetail *)book {
    
    [self openBookRead];
    static sqlite3_stmt *stmt = nil;
    NSString *string = @"delete from BookReadTable where Id = ? and userName = ?";
    int result = sqlite3_prepare_v2(db, [string UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [book._id UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[UserFileHandle selectUserInfo].userName UTF8String], -1, NULL);

        sqlite3_step(stmt);
    }
    sqlite3_step(stmt);
    [self closeBookRead];
}

// 查询某个
- (bookDetail *)selectBookWithID:(NSString *)ID {
    
    [self openBookRead];
    static sqlite3_stmt *stmt = nil;
    NSString *select = @"select data from BookReadTable where Id = ? and userName = ?";
    
    int result = sqlite3_prepare_v2(db, [select UTF8String], -1, &stmt, NULL);
    
    bookDetail *book = nil;
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[UserFileHandle selectUserInfo].userName UTF8String], -1, NULL);
        
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            NSString *stringKey = [NSString stringWithFormat:@"%@%@", kBookArchiver, ID];
            book = [[ArchiverHandle shareArchiverHandle] unArchiveObject:data forKey:stringKey];
        }
    } else {
        NSLog(@"");
    }
    sqlite3_finalize(stmt);
    [self closeBookRead];
    return book;
}

- (NSMutableArray *)selectAllBooks {
    
    [self openBookRead];
    
    
    sqlite3_stmt *stmt = nil;
    NSString *string = @"select Id, data from BookReadTable where userName = ?";
    int result = sqlite3_prepare_v2(db, string.UTF8String, -1, &stmt, NULL);
    NSMutableArray *results = [NSMutableArray array];
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [UserFileHandle selectUserInfo].userName.UTF8String, -1, NULL);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString *Id = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *string = [NSString stringWithFormat:@"%@%@", kBookArchiver, Id];
            bookDetail *book = [[ArchiverHandle shareArchiverHandle] unArchiveObject:data forKey:string];
            [results addObject:book];
         
            
        }
    }
    sqlite3_finalize(stmt);
    return results;
}

- (BOOL)isFavorateBookWithID:(NSString *)ID {
    
    bookDetail *book = [self selectBookWithID:ID];
    if (book == nil) {
        return NO;
    }
    return YES;
}
@end
