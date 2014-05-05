//
//  AppDelegate.h
//  blinQ
//
//  Created by Le Thanh Hai on 4/30/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NonRotateNavigationController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NonRotateNavigationController *navController;

+ (AppDelegate*) sharedInstance;
- (void) showMainScreen;
- (void) showFirstLogInScreen;

@end
