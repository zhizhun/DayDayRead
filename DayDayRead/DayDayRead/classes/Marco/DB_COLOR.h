//
//  DB_COLOR.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/27.
//  Copyright © 2016年 王志准. All rights reserved.
//

#ifndef DB_COLOR_h
#define DB_COLOR_h

#define DB_COLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

//随机色
#define DB_RANDOM_COLOR DB_COLOR(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1.0)



#endif /* DB_COLOR_h */
