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
@implementation SectionHeaderView
@synthesize question;
@synthesize questionService;
@synthesize section, delegate;
@synthesize sectionInfo;
@synthesize avatarImgView, fromLbl, toLbl, subjectLbl, questionLbl, expireDateLbl;
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
        NSString *final = [temp substringToIndex:[temp length] - 1];
        toLbl.text = final;

        
        subjectLbl.text = question.subject;
        questionLbl.text = question.question;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        expireDateLbl.text = [dateFormatter stringFromDate:question.expireDate];
        
        CGFloat heightDistance = 10;
        CGRect frame;
        
        frame = subjectLbl.frame;
        //frame.origin.y = heightDistance;
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
    if (!sectionInfo.open) {
        [questionService retrieveAnswersForQuestion:question.questionId];
    }
}


-(void)toggleOpenWithUserAction:(BOOL)userAction {
    if (sectionInfo.open) {
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
    [self toggleOpenWithUserAction:YES];
}

- (void)didRetrieveAnswersForQuestionFail:(QuestionService *)service withMessage:(NSString *)message {
    
}

@end
