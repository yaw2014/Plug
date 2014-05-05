//
//  EditUserGroupViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "EditUserGroupViewController.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"

@interface EditUserGroupViewController ()

@end

@implementation EditUserGroupViewController
@synthesize myTableView, questionService, groups, selectedGroups;
@synthesize user;
@synthesize userService;

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
    self.questionService = [[QuestionService alloc] init];
    questionService.delegate = self;
    [questionService retrieveGroups];
    
    self.userService = [[UserService alloc] init];
    userService.delegate = self;
    self.selectedGroups = user.groups;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QuestionServiceDelegate
- (void) didRetrieveGroupsSuccess: (QuestionService*) service {
    self.groups = service.groups;
    [myTableView reloadData];
}

- (void) didRetrieveGroupsFail: (QuestionService *)service withMessage: (NSString*) message {
    
}

#pragma mark - UserServiceDelegate
- (void)didUpdateUserInfoByUserIdSuccess:(UserService *)service {
    User *temp = service.user;
    [UserService storeUserId:temp.userId];
    [UserService storeUserName:temp.name];
    [UserService storeEmail:temp.email];
    [UserService storeYear:temp.year];
    [UserService storeSection:temp.section];
    [UserService storeCity:temp.city];
    [UserService storeState:temp.state];
    [UserService storeCountry:temp.country];
    [UserService storeCreatedDate:temp.createdDate];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:EDIT_USER_SUCCESS_MSG delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didUpdateUserInfoByUserIdFail:(UserService *)service withMessage:(NSString *)message {
    
}

#pragma mark - IBAction on view
- (IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneBtnTapped:(id)sender {
    if ([selectedGroups count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:EMPTY_GROUP_MSG delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        NSMutableString *groupIds = [[NSMutableString alloc] initWithString:@""];
        for (Group *g in selectedGroups) {
            [groupIds appendString:[NSString stringWithFormat:@"%@,", g.groupId]];
        }
        NSString *final = [groupIds substringToIndex:[groupIds length] - 1];
        user.groups = selectedGroups;
        [userService updateUserInfoWithUserId:user.userId withName:user.name withSection:user.section withYear:user.year withCity:user.city withState:user.state withCountry:user.country withOldPassword:user.oldPassword withNewPassword:user.password withGroupIds:final];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ProfileViewController *viewVC = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    NSArray *arr = [NSArray arrayWithObject:viewVC];
    [self.navigationController setViewControllers:arr animated:YES];
}

#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGRect f = CGRectMake(0, 0, tableView.frame.size.width, 5.0f);
    UILineFooterView * v = [[UILineFooterView alloc] initWithFrame:f];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Group *g = [groups objectAtIndex:indexPath.row];
    cell.textLabel.text = g.groupName;
    
    BOOL exist = NO;
    for (Group *temp in selectedGroups) {
        if ([temp.groupId isEqual:g.groupId]) {
            exist = YES;
            break;
        }
    }
    
    if (exist) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    Group *g = [groups objectAtIndex:indexPath.row];
    
    BOOL exist = NO;
    for (Group *temp in selectedGroups) {
        if ([temp.groupId isEqual:g.groupId]) {
            exist = YES;
            [selectedGroups removeObject:temp];
            break;
        }
    }
    
    if (!exist) {
        [selectedGroups addObject:g];
    }
    [myTableView reloadData];
}

@end
