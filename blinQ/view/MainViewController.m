//
//  MainViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tabBarController;
@synthesize navController1, navController2, navController3, navController4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:tabBarController.view];
    tabBarController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGFloat tabHeight = 49.0f;
    [navController1 setNavigationBarHidden:YES];
    navController1.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - tabHeight);
    [navController2 setNavigationBarHidden:YES];
    navController2.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - tabHeight);
    [navController3 setNavigationBarHidden:YES];
    navController3.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - tabHeight);
    [navController4 setNavigationBarHidden:YES];
    navController4.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - tabHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
