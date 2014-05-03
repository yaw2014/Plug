//
//  ReviewViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuestionService.h"
#import "UserService.h"

@interface ReviewViewController : UIViewController<QuestionServiceDelegate, UIAlertViewDelegate> {
    
}


@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) QuestionService *questionService;
@property (nonatomic, retain) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, retain) IBOutlet UILabel *titleLbl;
@property (nonatomic, retain) IBOutlet UILabel *subjectLbl;
@property (nonatomic, retain) IBOutlet UILabel *questionLbl;
@property (nonatomic, retain) IBOutlet UILabel *expireDateLbl;

- (IBAction)backBtnTapped:(id)sender;
- (IBAction)postBtnTapped:(id)sender;

@end
