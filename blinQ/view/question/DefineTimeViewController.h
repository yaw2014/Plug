//
//  DefineTimeViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface DefineTimeViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> {
    
}

@property (nonatomic, retain) NSMutableArray *days;
@property (nonatomic, retain) NSMutableArray *hours;

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) NSDate *expireDate;
@property (nonatomic, retain) IBOutlet UIPickerView *myPickerView;
@property (nonatomic, retain) IBOutlet UILabel *expireDateLbl;

- (IBAction)backBtnTapped:(id)sender;
- (IBAction)nextBtnTapped:(id)sender;


@end
