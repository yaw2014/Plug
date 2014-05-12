//
//  QuestionViewController.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionService.h"
#import "UserService.h"

@interface QuestionViewController : UIViewController<QuestionServiceDelegate, UITableViewDataSource, UITableViewDelegate, UserServiceDelegate> {
    
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) UserService *userService;
@property (nonatomic, retain) QuestionService *questionService;
@property (nonatomic, retain) NSMutableArray *groups;
@property (nonatomic, retain) NSMutableArray *selectedGroups;
@property (nonatomic, retain) IBOutlet UILabel *warningLbl;

- (IBAction) nextBtnTapped:(id)sender;


@end
