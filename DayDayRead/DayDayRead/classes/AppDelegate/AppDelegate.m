//
//  AppDelegate.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/24.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "LeftViewController.h"
#import <UMSocial.h>


#import <UMSocialSinaSSOHandler.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"5779dec1e0f55a109d0006eb"];
   
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"21858432"
                                              secret:@"1fc059b7ef51ba7331e9169d13dff910"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    RootViewController *rootVC = [[RootViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    //抽屉对象
    RESideMenu *sideVC = [[RESideMenu alloc] initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:nil];
    //sideVC.backgroundImage = [UIImage imageNamed:@"ip6p@3x"];
    sideVC.menuPreferredStatusBarStyle = 1;
    sideVC.delegate = self;
    sideVC.contentViewShadowColor = [UIColor blackColor];
    sideVC.contentViewShadowOffset = CGSizeMake(0, 0);
    sideVC.contentViewShadowOpacity = 0.6;
    sideVC.contentViewShadowRadius = 12;
    sideVC.scaleContentView = NO; //抽屉效果不变小
    sideVC.panGestureEnabled = NO; //关闭侧滑效果
    sideVC.contentViewInLandscapeOffsetCenterX = -[UIScreen mainScreen].bounds.size.width/4;
    sideVC.contentViewInPortraitOffsetCenterX = -[UIScreen mainScreen].bounds.size.width/4;
    self.window.rootViewController = sideVC;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
