//
//  AppDelegate.m
//  LTDemo
//
//  Created by 刘涛 on 3/25/19.
//  Copyright © 2019 刘涛. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LTWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"AppDelegate 响应了touch事件");
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ViewController *homeVC = [ViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
//    LTNav *nav = [[LTNav alloc] initWithRootViewController:homeVC];
    
//    LTSplitViewController *homeVC = [LTSplitViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    self.window = [[LTWindow alloc] init];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    //injection 热重载
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    
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
