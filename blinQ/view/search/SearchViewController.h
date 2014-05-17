//
//  SearchViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
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


@interface SearchViewController : UIViewController<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, QuestionServiceDelegate, QuestionServiceDelegate, SectionHeaderViewDelegate, SubmitAnswerTableViewCellDelegate, OtherAnswerTableViewCellDelegate,UIGestureRecognizerDelegate> {
    
}
@property (nonatomic, retain) IBOutlet UISearchBar *mySearchBar;
@property (nonatomic, retain) QuestionService *questionService;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *sectionInfoArray;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, assign) NSInteger currentQuestionIndex;
@property (nonatomic, assign) CGFloat changeAmount;

@property (nonatomic, retain) IBOutlet SubmitAnswerTableViewCell *submitAnswerCell;
@property (nonatomic, retain) IBOutlet OtherAnswerTableViewCell *otherAnswerCell;
@property (nonatomic, retain) IBOutlet SubmitAnAnswerTableViewCell *submitAnAnswerCell;


@end
