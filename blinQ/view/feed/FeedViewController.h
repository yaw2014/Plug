//
//  FeedViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewController : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *mySegmentControl;
@property (nonatomic, retain) IBOutlet UIView *contentView;

@property (nonatomic, retain) UINavigationController *navController1;
@property (nonatomic, retain) UINavigationController *navController2;
@property (nonatomic, retain) UINavigationController *navController3;

- (IBAction)segmentControlChanged:(id)sender;

@end
