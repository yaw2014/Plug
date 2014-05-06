//
//  OtherAnswerTableViewCell.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILoadingImageView.h"
#import "Answer.h"
@class OtherAnswerTableViewCell;
@protocol OtherAnswerTableViewCellDelegate

- (void) didVoteForAnswer: (Answer*) answer withValue: (NSInteger) value;

@end

@interface OtherAnswerTableViewCell : UITableViewCell {
    
}
@property (nonatomic, assign) Answer *answer;
@property (nonatomic, retain) IBOutlet UILoadingImageView *avatarImgView;
@property (nonatomic, retain) IBOutlet UILabel *nameLbl;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLbl;
@property (nonatomic, retain) IBOutlet UILabel *answerLbl;
@property (nonatomic, retain) IBOutlet UIButton *upBtn;
@property (nonatomic, retain) IBOutlet UIButton *downBtn;
@property (nonatomic, retain) IBOutlet UILabel *voteUpLbl;
@property (nonatomic, assign) id delegate;

- (IBAction)voteUp:(id)sender;
- (IBAction)voteDown:(id)sender;

@end
