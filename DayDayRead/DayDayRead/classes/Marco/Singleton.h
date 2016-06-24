//
//  Singleton.h
//  MusicPlayer
//
//  Created by 王志准 on 16/6/13.
//  Copyright © 2016年 王志准. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

//单例声明
#define singleton_interface(className)\
+ (instancetype)share##className;

//单例实现
#define singleton_implementation(className)\
static className *manager;\
+ (instancetype)share##className{\
 static dispatch_once_t onceToken;\
 dispatch_once(&onceToken, ^{\
    manager = [[[self class] alloc]init];\
  });\
  return manager;\
}

#endif /* Singleton_h */
