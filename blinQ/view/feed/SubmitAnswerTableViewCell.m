//
//  SubmitAnswerTableViewCell.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "SubmitAnswerTableViewCell.h"

@implementation SubmitAnswerTableViewCell
@synthesize avatarImgView, nameLbl, descriptionLbl, myTextView, submitBtn, delegate;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - IBAction on view
- (IBAction)submitBtnTapped:(id)sender {
    if (delegate && [delegate respondsToSelector:@selector(submitAnswer:)]) {
        [delegate submitAnswer:myTextView.text];
    }
}

@end
