//
//  TopQuestionsViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionService.h"
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
#import "SubmitAnAnswerTableViewCell.h"
#import "Answer.h"
#import "AnswerViewController.h"
#import "QuestionProtocol.h"
@interface TopQuestionsViewController : UIViewController<OtherAnswerTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource, QuestionServiceDelegate, QuestionServiceDelegate, SectionHeaderViewDelegate, SubmitAnswerTableViewCellDelegate, UIGestureRecognizerDelegate> {
    NSTimer *timer;
}
@property (nonatomic, retain) QuestionService *questionService;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *sectionInfoArray;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, retain) QuestionService *timerService;
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) NSInteger currentQuestionIndex;
@property (nonatomic, assign) CGFloat changeAmount;

@property (nonatomic, retain) IBOutlet SubmitAnswerTableViewCell *submitAnswerCell;
@property (nonatomic, retain) IBOutlet OtherAnswerTableViewCell *otherAnswerCell;
@property (nonatomic, retain) IBOutlet SubmitAnAnswerTableViewCell *submitAnAnswerCell;
- (void) queryData;

@end

@protocol TopQuestionsViewControllerDelegate <NSObject>

- (void) didGetNewTopQuestions: (TopQuestionsViewController*) viewVC withNumber: (NSInteger) num;

@end

