//
//  AppDelegate.m
//  Pop-Test
//
//  Created by mac on 11/02/2019.
//  Copyright © 2019 Woodsoo. All rights reserved.
//
//Spring弹性   Decay衰减     Basic基础     Custom自定义

#import "AppDelegate.h"
#import "SpringViewController.h"
#import "DecayViewController.h"
#import "BasicViewController.h"
#import "CustomViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    SpringViewController *springVc = [[SpringViewController alloc]init];
    UINavigationController *springNavi = [[UINavigationController alloc]initWithRootViewController:springVc];
    springVc.title = @"Spring";
    DecayViewController *decayVc = [[DecayViewController alloc]init];
    UINavigationController *decayNavi = [[UINavigationController alloc]initWithRootViewController:decayVc];
    decayVc.title = @"Decay";
    BasicViewController *basicVc = [[BasicViewController alloc]init];
    UINavigationController *basicNavi = [[UINavigationController alloc]initWithRootViewController:basicVc];
    basicVc.title = @"Basic";
    CustomViewController *customVc = [[CustomViewController alloc]init];
    UINavigationController *customNavi = [[UINavigationController alloc]initWithRootViewController:customVc];
    customVc.title = @"Custom";
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    tabBar.viewControllers = @[springNavi,decayNavi,basicNavi,customNavi];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
