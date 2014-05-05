//
//  FeedViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "FeedViewController.h"
#import "MyQuestionsViewController.h"
#import "QuestionsForMeViewController.h"
#import "TopQuestionsViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController
@synthesize mySegmentControl, contentView;
@synthesize navController1, navController2, navController3;
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
    MyQuestionsViewController *viewVC1 = [[MyQuestionsViewController alloc] initWithNibName:@"MyQuestionsViewController" bundle:nil];
    self.navController1 = [[UINavigationController alloc] initWithRootViewController:viewVC1];
    [navController1 setNavigationBarHidden:YES];
    QuestionsForMeViewController *viewVC2 = [[QuestionsForMeViewController alloc] initWithNibName:@"QuestionsForMeViewController" bundle:nil];
    self.navController2 = [[UINavigationController alloc] initWithRootViewController:viewVC2];
    [navController2 setNavigationBarHidden:YES];
    TopQuestionsViewController *viewVC3 = [[TopQuestionsViewController alloc] initWithNibName:@"TopQuestionsViewController" bundle:nil];
    self.navController3 = [[UINavigationController alloc] initWithRootViewController:viewVC3];
    [navController3 setNavigationBarHidden:YES];
    [mySegmentControl setSelectedSegmentIndex:0];
    [self segmentControlChanged:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction on view
- (IBAction)segmentControlChanged:(id)sender {
    NSInteger index = mySegmentControl.selectedSegmentIndex;
    for (UIView *sub in contentView.subviews) {
        [sub removeFromSuperview];
    }
    
    if (index == 0) {
        [contentView addSubview:navController1.view];
    } else if (index == 1) {
        [contentView addSubview:navController2.view];
    } else if (index == 2) {
        [contentView addSubview:navController3.view];
    }
}



@end
