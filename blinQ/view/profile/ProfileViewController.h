//
//  ProfileViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserService.h"
#import "UILoadingImageView.h"
@interface ProfileViewController : UIViewController<UserServiceDelegate> {
    
}

@property (nonatomic, retain) UserService *userService;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) IBOutlet UILoadingImageView *avatarImgView;
@property (nonatomic, retain) IBOutlet UILabel *nameLbl;
@property (nonatomic, retain) IBOutlet UILabel *yearLbl;
@property (nonatomic, retain) IBOutlet UILabel *sectionLbl;

@property (nonatomic, retain) IBOutlet UILabel *memberSinceLbl;
@property (nonatomic, retain) IBOutlet UILabel *groupsLbl;

- (IBAction)editBtnTapped:(id)sender;



@end
