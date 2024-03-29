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
#import "AppDelegate.h"

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
    
    self.userService = [[UserService alloc] init];
    userService.delegate = self;
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    nameLbl.text = [UserService signedInUserName];
    yearLbl.text = [NSString stringWithFormat:@"Year of %@", [UserService signedInYear]];
    sectionLbl.text = [NSString stringWithFormat:@"Section %@", [UserService signedInSection]];
    if (![[UserService signedInAvatar] isEqual:@""]) {
        NSLog(@"avatar: %@", [UserService signedInAvatar]);
        avatarImgView.imgUrl = [UserService signedInAvatar];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    memberSinceLbl.text = [NSString stringWithFormat:@"Member since: %@", [formatter stringFromDate:[UserService signedInCreatedDate]]];
    [userService retrieveUserInfoByUserId:[UserService signedInUserId]];
    [super viewWillAppear:animated];
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

- (IBAction)logOutBtnTapped:(id)sender {
    [UserService clearUserData];
    [[AppDelegate sharedInstance] showFirstLogInScreen];
}

#pragma mark - UserServiceDelegate
- (void)didRetrieveUserInfoByUserIdSuccess:(UserService *)service {
    self.user = service.user;
    NSMutableArray *groups = user.groups;
    NSMutableString *groupNames = [[NSMutableString alloc] initWithString:@""];
    for (Group *g in groups) {
        [groupNames appendString:[NSString stringWithFormat:@"%@, ", g.groupName]];
    }
    NSString *final = [groupNames substringToIndex:[groupNames length] - 2];
    groupsLbl.text = final;
    CGRect frame = groupsLbl.frame;
    CGSize limitSize = CGSizeMake(groupsLbl.frame.size.width, 9999);
    frame.size.height = [groupsLbl.text sizeWithFont:groupsLbl.font constrainedToSize:limitSize lineBreakMode:NSLineBreakByCharWrapping].height;
    groupsLbl.frame = frame;
}

- (void)didRetrieveUserInfoByUserIdFail:(UserService *)service withMessage:(NSString *)message {
    
}

@end
