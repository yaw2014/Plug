//
//  FeedViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyQuestionsViewController.h"
#import "QuestionsForMeViewController.h"
#import "TopQuestionsViewController.h"

@interface FeedViewController : UIViewController<MyQuestionViewControllerDelegate, QuestionsForMeViewControllerDelegate, TopQuestionsViewControllerDelegate> {
    
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *mySegmentControl;
@property (nonatomic, retain) IBOutlet UIView *contentView;

@property (nonatomic, retain) UINavigationController *navController1;
@property (nonatomic, retain) UINavigationController *navController2;
@property (nonatomic, retain) UINavigationController *navController3;

@property (nonatomic, retain) IBOutlet UILabel *myQuesNotiLbl;
@property (nonatomic, retain) IBOutlet UILabel *quesMeNotiLbl;
@property (nonatomic, retain) IBOutlet UILabel *topQuesNotiLbl;

@property (nonatomic, retain) IBOutlet UIView *myQuesNotiView;
@property (nonatomic, retain) IBOutlet UIView *quesMeNotiView;
@property (nonatomic, retain) IBOutlet UIView *topQuesNotiView;


- (IBAction)segmentControlChanged:(id)sender;

@end
