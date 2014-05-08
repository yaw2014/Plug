//
//  FeedViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "FeedViewController.h"


@interface FeedViewController ()

@end

@implementation FeedViewController
@synthesize mySegmentControl, contentView;
@synthesize navController1, navController2, navController3;
@synthesize myQuesNotiLbl,myQuesNotiView, topQuesNotiLbl, topQuesNotiView, quesMeNotiLbl, quesMeNotiView;
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
    viewVC1.delegate = self;
    self.navController1 = [[UINavigationController alloc] initWithRootViewController:viewVC1];
    [navController1 setNavigationBarHidden:YES];
    navController1.view.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
    
    QuestionsForMeViewController *viewVC2 = [[QuestionsForMeViewController alloc] initWithNibName:@"QuestionsForMeViewController" bundle:nil];
    viewVC2.delegate = self;
    self.navController2 = [[UINavigationController alloc] initWithRootViewController:viewVC2];
    [navController2 setNavigationBarHidden:YES];
    navController2.view.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
    
    TopQuestionsViewController *viewVC3 = [[TopQuestionsViewController alloc] initWithNibName:@"TopQuestionsViewController" bundle:nil];
    viewVC3.delegate = self;
    self.navController3 = [[UINavigationController alloc] initWithRootViewController:viewVC3];
    [navController3 setNavigationBarHidden:YES];
    navController3.view.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
    
    [mySegmentControl setSelectedSegmentIndex:0];
    [self segmentControlChanged:nil];
    
    [mySegmentControl setSelectedSegmentIndex:1];
    [self segmentControlChanged:nil];
    
    [mySegmentControl setSelectedSegmentIndex:2];
    [self segmentControlChanged:nil];
    
    [mySegmentControl setSelectedSegmentIndex:0];
    [self segmentControlChanged:nil];
    
    myQuesNotiView.hidden = YES;
    quesMeNotiView.hidden = YES;
    topQuesNotiView.hidden = YES;
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
        myQuesNotiView.hidden = YES;
        myQuesNotiLbl.text = @"";
    } else if (index == 1) {
        [contentView addSubview:navController2.view];
        quesMeNotiView.hidden = YES;
        quesMeNotiLbl.text = @"";
    } else if (index == 2) {
        [contentView addSubview:navController3.view];
        topQuesNotiView.hidden = YES;
        topQuesNotiLbl.text = @"";
    }
}

#pragma mark - MyQuestionViewControllerDelegate
- (void)didGetNewMyQuestion:(MyQuestionsViewController *)viewVC withNumber:(NSInteger)num {
    NSInteger selectedIndex = mySegmentControl.selectedSegmentIndex;
    if (selectedIndex == 0) {
        //not show
    } else {
        myQuesNotiView.hidden = NO;
        myQuesNotiLbl.text = [NSString stringWithFormat:@"%d", num];
    }
}

#pragma mark - QuestionsForMeViewControllerDelegate
- (void)didGetNewQuestionForMe:(QuestionsForMeViewController *)viewVC withNumber:(NSInteger)num {
    NSInteger selectedIndex = mySegmentControl.selectedSegmentIndex;
    if (selectedIndex == 1) {
        //not show
    } else {
        quesMeNotiView.hidden = NO;
        quesMeNotiLbl.text = [NSString stringWithFormat:@"%d", num];
    }
}

#pragma mark - TopQuestionsViewControllerDelegate
- (void)didGetNewTopQuestions:(TopQuestionsViewController *)viewVC withNumber:(NSInteger)num {
    NSInteger selectedIndex = mySegmentControl.selectedSegmentIndex;
    if (selectedIndex == 2) {
        //not show
    } else {
        topQuesNotiView.hidden = NO;
        topQuesNotiLbl.text = [NSString stringWithFormat:@"%d", num];
    }
}

@end
