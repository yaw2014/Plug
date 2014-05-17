//
//  AnswerViewController.h
//  plug
//
//  Created by Le Thanh Hai on 5/17/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuestionService.h"
#import "UserService.h"
#import "SectionInfo.h"
@interface AnswerViewController : UIViewController<UIGestureRecognizerDelegate, QuestionServiceDelegate, UIAlertViewDelegate> {
    
}

@property (nonatomic, retain) SectionInfo *info;
@property (nonatomic, retain) QuestionService *questionService;
@property (nonatomic, retain) IBOutlet UITextView *myTextView;
@property (nonatomic, retain) IBOutlet UILabel *warningLbl;
@property (nonatomic, assign) CGFloat changeAmount;

- (IBAction)backBtnTapped:(id)sender;
- (IBAction)submitBtnTapped:(id)sender;

@end
