//
//  ForgotPasswordViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserService.h"
@interface ForgotPasswordViewController : UIViewController<UIGestureRecognizerDelegate, UITextFieldDelegate, UserServiceDelegate> {
    
}

@property (nonatomic, retain) UserService *userService;
@property (nonatomic, retain) IBOutlet UITextField *emailTxt;
@property (nonatomic, retain) IBOutlet UILabel *warningLbl;

@property (nonatomic, retain) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, assign) CGFloat changeAmount;

- (IBAction)submitBtnTapped:(id)sender;
@end
