//
//  OtherAnswerTableViewCell.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILoadingImageView.h"
@interface OtherAnswerTableViewCell : UITableViewCell {
    
}

@property (nonatomic, retain) IBOutlet UILoadingImageView *avatarImgView;
@property (nonatomic, retain) IBOutlet UILabel *nameLbl;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLbl;
@property (nonatomic, retain) IBOutlet UILabel *answerLbl;

@end
