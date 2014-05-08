//
//  QuestionsForMeViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserService.h"
#import "MBProgressHUD.h"
#import "SectionInfo.h"
#import "SectionHeaderView.h"
#import "User.h"
#import "UserService.h"
#import "Question.h"
#import "QuestionService.h"
#import "UILineFooterView.h"
#import "SubmitAnswerTableViewCell.h"
#import "OtherAnswerTableViewCell.h"
#import "Answer.h"

@interface QuestionsForMeViewController : UIViewController<OtherAnswerTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource, QuestionServiceDelegate, QuestionServiceDelegate, SectionHeaderViewDelegate, SubmitAnswerTableViewCellDelegate, UIGestureRecognizerDelegate, UserServiceDelegate> {
    NSTimer *timer;
}
@property (nonatomic, retain) UserService *userService;
@property (nonatomic, retain) QuestionService *questionService;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *sectionInfoArray;
@property (nonatomic, retain) QuestionService *timerService;
@property (nonatomic, retain) NSMutableArray *results;


@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, assign) NSInteger currentQuestionIndex;
@property (nonatomic, assign) CGFloat changeAmount;
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) User *user;

@property (nonatomic, retain) IBOutlet SubmitAnswerTableViewCell *submitAnswerCell;
@property (nonatomic, retain) IBOutlet OtherAnswerTableViewCell *otherAnswerCell;

@end
@protocol QuestionsForMeViewControllerDelegate <NSObject>

- (void) didGetNewQuestionForMe: (QuestionsForMeViewController*) viewVC withNumber: (NSInteger) num;

@end
