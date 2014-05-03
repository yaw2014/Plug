//
//  EditAccountViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserService.h"
#import "User.h"
#import "UILoadingImageView.h"

@interface EditAccountViewController : UIViewController<UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UserServiceDelegate> {
    
}

@property (nonatomic, retain) NSMutableArray *sections;

@property (nonatomic, retain) IBOutlet UILoadingImageView *avatarImgView;
@property (nonatomic, retain) IBOutlet UITextField *nameTxt;
@property (nonatomic, retain) IBOutlet UILabel *emailLbl;
@property (nonatomic, retain) IBOutlet UIButton *sectionBtn;
@property (nonatomic, retain) IBOutlet UITextField *yearTxt;
@property (nonatomic, retain) IBOutlet UITextField *cityTxt;
@property (nonatomic, retain) IBOutlet UITextField *stateTxt;
@property (nonatomic, retain) IBOutlet UITextField *countryTxt;
@property (nonatomic, retain) IBOutlet UITextField *oldPasswordTxt;
@property (nonatomic, retain) IBOutlet UITextField *passwordTxt;
@property (nonatomic, retain) IBOutlet UITextField *confirmPasswordTxt;

@property (nonatomic, retain) IBOutlet UIView *sectionSelectView;
@property (nonatomic, retain) IBOutlet UIPickerView *sectionPicker;

@property (nonatomic, retain) IBOutlet UILabel *warningLbl;
@property (nonatomic, retain) IBOutlet UIButton *nextBtn;

@property (nonatomic, retain) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, assign) CGFloat changeAmount;

@property (nonatomic, retain) UserService *userService;
@property (nonatomic, retain) User *user;

- (IBAction)backBtnTapped:(id)sender;
- (IBAction)sectionBtnTapped:(id)sender;
- (IBAction)avatarBtnTapped:(id)sender;
- (IBAction)nextBtnTapped:(id)sender;
- (IBAction)cancelSectionView:(id)sender;
- (IBAction)doneSectionView:(id)sender;


@end
