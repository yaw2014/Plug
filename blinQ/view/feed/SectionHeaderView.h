//
//  SectionHeaderView.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILoadingImageView.h"
#import "QuestionService.h"
@class Question;
@class SectionInfo;
@protocol SectionHeaderViewDelegate;

@interface SectionHeaderView : UIView<QuestionServiceDelegate, UIGestureRecognizerDelegate> {
    
}

@property (nonatomic, retain) QuestionService *questionService;
@property (nonatomic, assign) Question *question;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) SectionInfo *sectionInfo;
@property (nonatomic, assign) id <SectionHeaderViewDelegate> delegate;

@property (nonatomic, retain) IBOutlet UILoadingImageView *avatarImgView;
@property (nonatomic, retain) IBOutlet UILabel *expireDateLbl;
@property (nonatomic, retain) IBOutlet UILabel *fromLbl;
@property (nonatomic, retain) IBOutlet UILabel *toLbl;
@property (nonatomic, retain) IBOutlet UILabel *createdDateLbl;
@property (nonatomic, retain) IBOutlet UILabel *subjectLbl;
@property (nonatomic, retain) IBOutlet UILabel *questionLbl;
@property (nonatomic, retain) IBOutlet UIButton *arrowBtn;
@property (nonatomic, retain) IBOutlet UIButton *hiddenBtn;
@property (nonatomic, assign) BOOL shouldUpdateHeader;

-(id)initWithQuestion:(Question*) ques section:(NSInteger)sectionNumber delegate:(id <SectionHeaderViewDelegate>)aDelegate;
-(void)toggleOpenWithUserAction:(BOOL)userAction;
- (void) recallAnswers;

@end

@protocol SectionHeaderViewDelegate <NSObject>

@optional
- (void) requestAnswerDidStart: (SectionHeaderView*)sectionHeaderView;
- (void) requestAnswerDidEnd: (SectionHeaderView*)sectionHeaderView;
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;
- (void) didRetrieveAnswersSectionHeaderView:(SectionHeaderView*) headerView;
@end
