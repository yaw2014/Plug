//
//  AppDelegate.m
//  blinQ
//
//  Created by Le Thanh Hai on 4/30/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "KeyboardStateListener.h"

@implementation AppDelegate
@synthesize navController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //init keyboard listener
    [KeyboardStateListener sharedInstance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    LoginViewController *viewVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.navController = [[NonRotateNavigationController alloc] initWithRootViewController:viewVC];
    [navController setNavigationBarHidden:YES];

    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if ([UserService signedInUserId]) {
        [self showMainScreen];
    }
    
    return YES;
}

+ (AppDelegate *)sharedInstance {
    return (AppDelegate*) [UIApplication sharedApplication].delegate;
}

- (void) showMainScreen {
    MainViewController *viewVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.navController popToRootViewControllerAnimated:NO];
    [self.navController pushViewController:viewVC animated:YES];
}

- (void) showFirstLogInScreen {
    [self.navController popToRootViewControllerAnimated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
