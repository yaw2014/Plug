//
//  UserGroupViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionService.h"
#import "UserService.h"
#import "UILineFooterView.h"
#import "Constants.h"
#import "User.h"

@interface UserGroupViewController : UIViewController<UserServiceDelegate, QuestionServiceDelegate, UITableViewDataSource, UITableViewDelegate> {
    
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) QuestionService *questionService;
@property (nonatomic, retain) UserService *userService;
@property (nonatomic, retain) NSMutableArray *groups;
@property (nonatomic, retain) NSMutableArray *selectedGroups;
@property (nonatomic, retain) User *user;

- (IBAction)backBtnTapped:(id)sender;
- (IBAction)doneBtnTapped:(id)sender;

@end
