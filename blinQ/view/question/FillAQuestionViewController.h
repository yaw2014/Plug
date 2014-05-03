//
//  FillAQuestionViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface FillAQuestionViewController : UIViewController<UIGestureRecognizerDelegate> {
    
}

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) IBOutlet UITextView *subjectTxt;
@property (nonatomic, retain) IBOutlet UITextView *questionTxt;
@property (nonatomic, retain) IBOutlet UILabel *warningLbl;


@property (nonatomic, retain) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, assign) CGFloat changeAmount;

- (IBAction)backBtnTapped:(id)sender;
- (IBAction)nextBtnTapped:(id)sender;

@end
