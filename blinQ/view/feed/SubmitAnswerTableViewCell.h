//
//  SubmitAnswerTableViewCell.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILoadingImageView.h"
@class SubmitAnswerTableViewCell;
@protocol SubmitAnswerTableViewCellDelegate

- (void) submitAnswer: (NSString*) answer;

@end

@interface SubmitAnswerTableViewCell : UITableViewCell {
    
}

@property (nonatomic, retain) IBOutlet UILoadingImageView *avatarImgView;
@property (nonatomic, retain) IBOutlet UILabel *nameLbl;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLbl;
@property (nonatomic, retain) IBOutlet UITextView *myTextView;
@property (nonatomic, retain) IBOutlet UIButton *submitBtn;
@property (nonatomic, assign) id delegate;
- (IBAction)submitBtnTapped:(id)sender;

@end
