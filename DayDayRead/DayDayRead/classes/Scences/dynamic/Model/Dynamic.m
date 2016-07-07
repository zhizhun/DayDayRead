//
//  Dynamic.m
//  项目
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "Dynamic.h"

@implementation Dynamic


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}



- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeObject:self.tweet forKey:@"tweet"];
    [aCoder encodeObject:self.from forKey:@"from"];
    [aCoder encodeObject:self.refTweet forKey:@"refTweet"];
    [aCoder encodeObject:self.commented forKey:@"commented"];
    [aCoder encodeObject:self.retweeted forKey:@"retweeted"];
    [aCoder encodeObject:self.created forKey:@"created"];
    [aCoder encodeBool:self.isFavorite forKey:@"isFavorite"];
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self._id = [aDecoder decodeObjectForKey:@"_id"];
        self.tweet = [aDecoder decodeObjectForKey:@"tweet"];
        self.from = [aDecoder decodeObjectForKey:@"from"];
        self.refTweet = [aDecoder decodeObjectForKey:@"refTweet"];
        self.commented = [aDecoder decodeObjectForKey:@"commented"];
        self.retweeted = [aDecoder decodeObjectForKey:@"retweeted"];
        self.created = [aDecoder decodeObjectForKey:@"created"];
        self.isFavorite = [aDecoder decodeBoolForKey:@"isFavorite"];
    }
    return self;
}









@end
