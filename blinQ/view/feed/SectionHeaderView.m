//
//  SectionHeaderView.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "SectionHeaderView.h"
#import "SectionInfo.h"
#import "User.h"
#import "Group.h"
#import "Question.h"
#import "QuestionService.h"
#import "UserService.h"

@implementation SectionHeaderView
@synthesize question;
@synthesize questionService;
@synthesize section, delegate;
@synthesize sectionInfo;
@synthesize avatarImgView, fromLbl, toLbl, subjectLbl, questionLbl, expireDateLbl;
@synthesize hiddenBtn;
@synthesize shouldUpdateHeader;
@synthesize arrowBtn;
@synthesize createdDateLbl;
-(id)initWithQuestion:(Question *)ques section:(NSInteger)sectionNumber delegate:(id<SectionHeaderViewDelegate>)aDelegate {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"SectionHeaderView" owner:self options:nil] objectAtIndex:0];
    
    if (self != nil) {
        // Set up the tap gesture recognizer.
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
        [self addGestureRecognizer:tapGesture];
        
        delegate = aDelegate;
        self.userInteractionEnabled = YES;
        self.questionService = [[QuestionService alloc] init];
        questionService.delegate = self;
        
        // Create and configure the title label.
        section = sectionNumber;
        
        self.question = ques;
        User *user = question.user;
        fromLbl.text = [NSString stringWithFormat:@"%@, Section %@, Class of %@", user.name, user.section, user.year];
        
        NSMutableString *temp = [[NSMutableString alloc] initWithString:@"To: "];
        for (Group *group in question.groups) {
            [temp appendString:[NSString stringWithFormat:@"%@, ", group.groupName]];
        }
        NSString *final = [temp substringToIndex:[temp length] - 2];
        toLbl.text = final;

        
        subjectLbl.text = question.subject;
        questionLbl.text = question.question;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd, yyyy"];
        createdDateLbl.text = [NSString stringWithFormat:@"Posted %@", [formatter stringFromDate:question.createdDate]];
        
        //format date here
        if ([[NSDate date] compare:question.expireDate] == NSOrderedAscending) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:NSDayCalendarUnit | NSHourCalendarUnit fromDate:[NSDate date] toDate:question.expireDate options:0];
            NSInteger day = [components day];
            NSInteger hour = [components hour];
            
            NSMutableString *tmp = [[NSMutableString alloc] init];
            if (day > 0) {
                [tmp appendFormat:@"%d days", day];
            }
            if (hour > 0) {
                [tmp appendFormat:@" %d hours", hour];
            }
            expireDateLbl.text = tmp;
        } else {
            expireDateLbl.text = @"Expired";
        }
        
        
        CGFloat heightDistance = 10;
        CGRect frame;
        frame = fromLbl.frame;
        frame.size.height = [fromLbl.text sizeWithFont:fromLbl.font constrainedToSize:CGSizeMake(frame.size.width, 9999) lineBreakMode:NSLineBreakByCharWrapping].height;
        fromLbl.frame = frame;
        
        frame = toLbl.frame;
        frame.origin.y = fromLbl.frame.origin.y + fromLbl.frame.size.height + heightDistance;
        frame.size.height = [toLbl.text sizeWithFont:toLbl.font constrainedToSize:CGSizeMake(frame.size.width, 9999) lineBreakMode:NSLineBreakByCharWrapping].height;
        toLbl.frame = frame;
        
        frame = createdDateLbl.frame;
        frame.origin.y = toLbl.frame.origin.y + toLbl.frame.size.height + heightDistance;
        frame.size.height = [createdDateLbl.text sizeWithFont:createdDateLbl.font constrainedToSize:CGSizeMake(frame.size.width, 9999) lineBreakMode:NSLineBreakByCharWrapping].height;
        createdDateLbl.frame = frame;
        
        frame = subjectLbl.frame;
        frame.origin.y = createdDateLbl.frame.origin.y + createdDateLbl.frame.size.height + heightDistance;
        frame.size.height = [subjectLbl.text sizeWithFont:subjectLbl.font constrainedToSize:CGSizeMake(frame.size.width, 9999) lineBreakMode:NSLineBreakByCharWrapping].height;
        subjectLbl.frame = frame;
        
        frame = questionLbl.frame;
        frame.origin.y = subjectLbl.frame.origin.y + subjectLbl.frame.size.height + heightDistance;
        frame.size.height = [questionLbl.text sizeWithFont:questionLbl.font constrainedToSize:CGSizeMake(frame.size.width, 9999) lineBreakMode:NSLineBreakByCharWrapping].height;
        questionLbl.frame = frame;
        self.frame = CGRectMake(0, 0, self.frame.size.width, frame.origin.y + frame.size.height + heightDistance);
    }
    return self;
}

-(IBAction)toggleOpen:(id)sender {
    shouldUpdateHeader = YES;
    if (hiddenBtn.selected) {
        [self toggleOpenWithUserAction:YES];
    } else {
        [self retrieveAnswers];
    }
}

- (void)recallAnswers {
    shouldUpdateHeader = NO;
    [self retrieveAnswers];
}

- (void) retrieveAnswers {
    [questionService retrieveAnswersForQuestion:question.questionId withUserId:[UserService signedInUserId]];
}

-(void)toggleOpenWithUserAction:(BOOL)userAction {
    arrowBtn.selected = !arrowBtn.selected;
    hiddenBtn.selected = !hiddenBtn.selected;
    if (hiddenBtn.selected) {
        if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
            [delegate sectionHeaderView:self sectionOpened:section];
        }
    }
    else {
        if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
            [delegate sectionHeaderView:self sectionClosed:section];
        }
    }
}

#pragma mark - QuestionServiceDelegate
- (void)didRetrieveAnswersForQuestionSuccess:(QuestionService *)service {
    question.answers = service.answers;
    if (shouldUpdateHeader) {
        [self toggleOpenWithUserAction:YES];
    } else {
        if (delegate && [delegate respondsToSelector:@selector(didRetrieveAnswersSectionHeaderView:)]) {
            [delegate didRetrieveAnswersSectionHeaderView:self];
        }
    }
    
}

- (void)didRetrieveAnswersForQuestionFail:(QuestionService *)service withMessage:(NSString *)message {
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]){
        return NO;
    }
    return YES;
}

@end
