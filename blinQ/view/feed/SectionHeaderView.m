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
#import "Question.h"

@implementation SectionHeaderView
@synthesize section, delegate;
@synthesize sectionInfo;
@synthesize avatarImgView, nameLbl, classLbl, sectionLbl, subjectLbl, questionLbl, expireDateLbl;
-(id)initWithQuestion:(Question *)question section:(NSInteger)sectionNumber delegate:(id<SectionHeaderViewDelegate>)aDelegate {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"SectionHeaderView" owner:self options:nil] objectAtIndex:0];
    
    if (self != nil) {
        // Set up the tap gesture recognizer.
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
        [self addGestureRecognizer:tapGesture];
        
        delegate = aDelegate;
        self.userInteractionEnabled = YES;
        
        // Create and configure the title label.
        section = sectionNumber;
        
        User *user = question.user;
        nameLbl.text = user.name;
        classLbl.text = user.year;
        sectionLbl.text = user.section;
        
        subjectLbl.text = question.subject;
        questionLbl.text = question.question;
        
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
    [self toggleOpenWithUserAction:YES];
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
@end
