//
//  AppDelegate.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/11/30.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ReadViewController.h"
#import "PictureViewController.h"
#import "PicturevViewController.h"
#import "SettingTableViewController.h"
#import "QuestionViewController.h"

static int who;
static int TotalVol;

@interface AppDelegate ()

@end

@implementation AppDelegate

+(int)getTotalVol {
    return TotalVol;
}

+(int)instanceWho {
    return who;
}

+(void)setWho:(int) co {
    who = co;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *rootTabBarController = [[UITabBarController alloc] init];
    who = 0;
    
    NSString *data1 = @"http://localhost:8080/IosService/TotalVol";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data1]];
    NSError * error = nil;
    NSURLResponse *response=nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    TotalVol = (int)[aString integerValue];
    NSLog(@"%d", TotalVol);
   
    ViewController *v1 = [[ViewController alloc] init];
    v1.navigationItem.title=@"首页";
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:v1];
    nav1.tabBarItem.title = @"首页";
    
    ReadViewController *v2 = [[ReadViewController alloc]init];
    v2.navigationItem.title=@"文章";
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:v2];
    nav2.tabBarItem.title = @"文章";
    
    QuestionViewController *v3 = [[QuestionViewController alloc]init];
    v3.navigationItem.title = @"问题";
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:v3];
    nav3.tabBarItem.title = @"问题";
    
    PicturevViewController *v4 = [[PicturevViewController alloc]init];
    v4.navigationItem.title = @"图片";
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:v4];
    nav4.tabBarItem.title = @"图片";
    
    SettingTableViewController *v5 = [[SettingTableViewController alloc]init];
    v5.navigationItem.title = @"设置";
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:v5];
    nav5.tabBarItem.title = @"设置";
    
    rootTabBarController.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    self.window.rootViewController = rootTabBarController;
    [self.window makeKeyAndVisible];
    return YES;
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
