//
//  OtherAnswerTableViewCell.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "OtherAnswerTableViewCell.h"

@implementation OtherAnswerTableViewCell
@synthesize answer;
@synthesize avatarImgView;
@synthesize nameLbl, descriptionLbl, answerLbl;
@synthesize delegate;
@synthesize upBtn, downBtn;
@synthesize voteUpLbl;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)voteUp:(id)sender {
    if (answer.value == 0) {
        answer.value = 1;
        upBtn.selected = YES;
        downBtn.enabled = NO;
        answer.voteUp++;
        voteUpLbl.text = [NSString stringWithFormat:@"Voted by %d people", (int)answer.voteUp];
    } else {
        answer.value = 0;
        upBtn.selected = NO;
        downBtn.enabled = YES;
        answer.voteUp--;
        voteUpLbl.text = [NSString stringWithFormat:@"Voted by %d people", (int)answer.voteUp];
    }
    if (delegate && [delegate respondsToSelector:@selector(didVoteForAnswer:withValue:)]) {
        [delegate didVoteForAnswer:answer withValue:answer.value];
    }
}

- (IBAction)voteDown:(id)sender {
    if (answer.value == 0) {
        answer.value = -1;
        downBtn.selected = YES;
        upBtn.enabled = NO;
    } else {
        answer.value = 0;
        downBtn.selected = NO;
        upBtn.enabled = YES;
    }
    if (delegate && [delegate respondsToSelector:@selector(didVoteForAnswer:withValue:)]) {
        [delegate didVoteForAnswer:answer withValue:answer.value];
    }
}



@end
