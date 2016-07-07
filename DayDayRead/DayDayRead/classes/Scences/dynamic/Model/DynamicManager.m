//
//  DynamicManager.m
//  DayDayRead
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "DynamicManager.h"
#import "ArchiverHandle.h"
#import "UserFileHandle.h"

#define kDynamicArchiver @"dynamic"
@interface DynamicManager ()
//数据库路径
@property (nonatomic, strong)NSString *databasePath;

@end
@implementation DynamicManager

singleton_implementation(DynamicManager)


- (NSString *)databasePath{
    if (_databasePath == nil) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _databasePath = [documentPath stringByAppendingPathComponent:@"DM.sqlite"];
    }
    return _databasePath;
}


//数据库指针
static sqlite3 *db = nil;

//打开数据库
- (void)openDM{
    
    NSLog(@"%@",self.databasePath);
    int result = sqlite3_open([self.databasePath UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        [self createTable];
    }else{
        NSLog(@"数据库打开失败");
    }
}

//关闭数据库
- (void)closeDM{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭成功");
    }else{
        NSLog(@"失败");
    }
}

//创建表
- (void)createTable {
    //创建表的语句
   NSString *createTable =  @"create table if not exists DynamicTable(userName TEXT, _id TEXT,title TEXT,imageUrl TEXT,data BLOB)";
    //执行sql语句
    int result = sqlite3_exec(db, [createTable UTF8String], NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"建表成功");
    }else{
        NSLog(@"建表失败");
    }
    
}
//插入
- (void)insertNewDynamic:(Dynamic *)dynamic {
    [self openDM];
    sqlite3_stmt *stmt = nil;
    NSString * insertString = @"insert into DynamicTable(userName,_id,title,imageUrl, data) values (?,?,?,?,?)";
     int result = sqlite3_prepare_v2(db, insertString.UTF8String, -1, &stmt, NULL);
    
        if (result == SQLITE_OK) {
        
            sqlite3_bind_text(stmt, 1, [[UserFileHandle selectUserInfo].userName UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[dynamic.refTweet objectForKey:@"_id"] UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [[dynamic.refTweet objectForKey:@"title"]UTF8String], -1, NULL);
        NSString *imageStr = [dynamic.from objectForKey:@"avatar"];
        NSString *urlStr= @"http://statics.zhuishushenqi.com/";
        NSString *imageViewStr = [NSString stringWithFormat:@"%@%@",urlStr,imageStr];
        sqlite3_bind_text(stmt, 4, [imageViewStr UTF8String], -1, NULL);
        NSString *archiverKey = [NSString stringWithFormat:@"%@%@",kDynamicArchiver, [dynamic.refTweet objectForKey:@"_id"]];
        NSData *data = [[ArchiverHandle shareArchiverHandle]dataOfArchiveObject:dynamic forKey:archiverKey];
            sqlite3_bind_blob(stmt, 5, [data bytes], (int)[data length], NULL);NSLog(@"插入成功");
            NSLog(@"%@======",imageViewStr);
            NSLog(@"%@----",dynamic._id);
        sqlite3_step(stmt);
    }else{
        NSLog(@"插入语句错误 %d",result);
    }
    sqlite3_finalize(stmt);

 }

- (void)deleteDynamic:(Dynamic*)dynamic; {
    [self openDM];
    sqlite3_stmt * stmt = nil;
    
    NSString * string = @"delete from DynamicTable where _id = ? and userName = ? ";
    int result = sqlite3_prepare_v2(db, [string UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [dynamic._id UTF8String], -1, NULL);
        
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
//查询某个

- (Dynamic *)selectDynamicWith_id:(NSString *)_id {
    [self openDM];
    
    sqlite3_stmt *stmt = nil;
    
    NSString *string = @"select data from DynamicTable where _id = ? and userName = ?";
    int result = sqlite3_prepare_v2(db, [string UTF8String], -1, &stmt, NULL);
    Dynamic *dynamic = nil;
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [dynamic._id UTF8String], -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            NSString *stringKey = [NSString stringWithFormat:@"%@%@",kDynamicArchiver,_id];

            dynamic = [[ArchiverHandle shareArchiverHandle] unArchiveObject:data forKey:stringKey];
            NSLog(@"-=====---");
     }
    }
    sqlite3_finalize(stmt);
        return dynamic;
}

//查询所有
- (NSMutableArray *)selectAllDynamic {
    [self openDM];
    sqlite3_stmt *stmt = nil;
     NSString *string = @"select _id, data from DynamicTable where userName = ? ";
    int result = sqlite3_prepare_v2(db, [string UTF8String], -1, &stmt, NULL);
    

    NSMutableArray *results = [NSMutableArray array];
    if (result == SQLITE_OK) {
       
        sqlite3_bind_text(stmt, 1, [[UserFileHandle selectUserInfo].userName UTF8String], -1, NULL);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString *_id = [NSString stringWithUTF8String:(const char  *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *string = [NSString stringWithFormat:@"%@%@",kDynamicArchiver, _id];
            Dynamic *dynamic = [[ArchiverHandle shareArchiverHandle]unArchiveObject:data forKey:string];
            [results addObject:dynamic];
            NSLog(@"--------------");
        }
    }
    sqlite3_finalize(stmt);
    return results;

    
}

- (BOOL)isFavoriteDynamicWith_id:(NSString *)_id {
    Dynamic *dynamic = [self selectDynamicWith_id:_id];
    if (dynamic == nil) {
        return NO;
    }
    return  YES;
}
@end
