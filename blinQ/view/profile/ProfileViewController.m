//
//  ProfileViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "ProfileViewController.h"
#import "Group.h"
#import "EditAccountViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize nameLbl, yearLbl, sectionLbl, memberSinceLbl, groupsLbl;
@synthesize userService;
@synthesize avatarImgView;
@synthesize user;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    nameLbl.text = [UserService signedInUserName];
    yearLbl.text = [NSString stringWithFormat:@"Year of %@", [UserService signedInYear]];
    sectionLbl.text = [NSString stringWithFormat:@"Section %@", [UserService signedInSection]];
    if ([UserService signedInAvatar]) {
        avatarImgView.imgUrl = [UserService signedInAvatar];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    memberSinceLbl.text = [NSString stringWithFormat:@"Member since: %@", [formatter stringFromDate:[UserService signedInCreatedDate]]];
    
    self.userService = [[UserService alloc] init];
    userService.delegate = self;
    
    [userService retrieveUserInfoByUserId:[UserService signedInUserId]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction on view
- (IBAction)editBtnTapped:(id)sender {
    EditAccountViewController *viewVC = [[EditAccountViewController alloc] initWithNibName:@"EditAccountViewController" bundle:nil];
    viewVC.user = user;
    [self.navigationController pushViewController:viewVC animated:YES];
}

#pragma mark - UserServiceDelegate
- (void)didRetrieveUserInfoByUserIdSuccess:(UserService *)service {
    self.user = service.user;
    NSMutableArray *groups = user.groups;
    NSMutableString *groupNames = [[NSMutableString alloc] initWithString:@""];
    for (Group *g in groups) {
        [groupNames appendString:[NSString stringWithFormat:@"%@, ", g.groupName]];
    }
    NSString *final = [groupNames substringToIndex:[groupNames length] - 1];
    groupsLbl.text = final;
}

- (void)didRetrieveUserInfoByUserIdFail:(UserService *)service withMessage:(NSString *)message {
    
}

@end
