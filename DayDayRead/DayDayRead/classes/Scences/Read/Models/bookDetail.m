//
//  bookDetail.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/30.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "bookDetail.h"

@implementation bookDetail

- (void)setValue:(id)value forKey:(NSString *)key {
    
    key = [key isEqualToString:@"id"] ? @"_id" : key;
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
     [aCoder encodeObject:self._id forKey:@"_id"];
     [aCoder encodeObject:self.author forKey:@"author"];
     [aCoder encodeObject:self.cover forKey:@"cover"];
     [aCoder encodeObject:self.longIntro forKey:@"longIntro"];
     [aCoder encodeObject:self.title forKey:@"title"];
     [aCoder encodeObject:self.minorCate forKey:@"minorCate"];
     [aCoder encodeObject:self.cat forKey:@"cat"];
     [aCoder encodeObject:self.majorCate forKey:@"majorCate"];
     [aCoder encodeBool:self.isSerial forKey:@"isSerial"];
     [aCoder encodeObject:self.latelyFollower forKey:@"latelyFollower"];
     [aCoder encodeObject:self.retentionRatio forKey:@"retentionRatio"];
     [aCoder encodeObject:self.serializeWordCount forKey:@"serializeWordCount"];
     [aCoder encodeObject:self.tags forKey:@"tags"];
     [aCoder encodeObject:self.wordCount forKey:@"wordCount"];
     [aCoder encodeObject:self.updated forKey:@"updated"];
     [aCoder encodeBool:self.isFavorite forKey:@"isFavorite"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        self._id = [aDecoder decodeObjectForKey:@"_id"];
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.cover = [aDecoder decodeObjectForKey:@"cover"];
        self.longIntro = [aDecoder decodeObjectForKey:@"longIntro"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.minorCate = [aDecoder decodeObjectForKey:@"minorCate"];
        self.cat = [aDecoder decodeObjectForKey:@"cat"];
        self.majorCate = [aDecoder decodeObjectForKey:@"majorCate"];
        self.isSerial = [aDecoder decodeBoolForKey:@"isSerial"];
        self.latelyFollower = [aDecoder decodeObjectForKey:@"latelyFollower"];
        self.retentionRatio = [aDecoder decodeObjectForKey:@"retentionRatio"];
        self.serializeWordCount = [aDecoder decodeObjectForKey:@"serializeWordCount"];
        self.tags = [aDecoder decodeObjectForKey:@"tags"];
        self.wordCount = [aDecoder decodeObjectForKey:@"wordCount"];
        self.updated = [aDecoder decodeObjectForKey:@"updated"];
        self.isFavorite = [aDecoder decodeBoolForKey:@"isFavorite"];
    }
    return self;
}
@end
