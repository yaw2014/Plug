//
//  UserGroupViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "UserGroupViewController.h"
#import "AppDelegate.h"

@interface UserGroupViewController ()

@end

@implementation UserGroupViewController
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
    
    self.selectedGroups = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QuestionServiceDelegate
- (void) didRetrieveGroupsSuccess: (QuestionService*) service {
    self.groups = service.groups;
    Group *g = [[Group alloc] init];
    g.groupName = [NSString stringWithFormat:@"%@ Section %@", user.year, user.section];
    [groups addObject:g];
    [selectedGroups addObject:g];
    g = [[Group alloc] init];
    g.groupName = [NSString stringWithFormat:@"Class of %@", user.year];
    [groups addObject:g];
    [selectedGroups addObject:g];
    
    [myTableView reloadData];
}

- (void) didRetrieveGroupsFail: (QuestionService *)service withMessage: (NSString*) message {
    
}

#pragma mark - UserServiceDelegate
- (void) goToMainScreen {
    [[AppDelegate sharedInstance] showMainScreen];
}
- (void) didRegisterSuccess: (UserService*) service {
    //submit avatar
    self.user.userId = service.user.userId;
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

    if (user.avatarImg) {
        NSMutableString *imageName = [[NSMutableString alloc] initWithCapacity:0];
        CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);
        if (theUUID) {
            [imageName appendString:CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, theUUID))];
            CFRelease(theUUID);
        }
        [imageName appendString:@".png"];
        
        NSString *filename = imageName;
        NSString *extension = [filename pathExtension];
        NSData *data = nil;
        if ([extension isEqual:@"png"]) {
            data = UIImagePNGRepresentation(user.avatarImg);
        } else if ([extension isEqual:@"jpg"] || [extension isEqual:@"jpeg"]) {
            data = UIImageJPEGRepresentation(user.avatarImg, 1);
        }
        if (data != nil) {
            //[userService submitAvatarForUser:user.userId withFileName:filename andData:data];;
#warning overcome the issue of uploading avatar
            [self goToMainScreen];
        }
    } else {
        [self goToMainScreen];
    }
}

- (void) didRegisterFail: (UserService*) service withMessage: (NSString*) message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didSubmitAvatarForUserSuccess:(UserService *)service {
    self.user.avatar = service.user.avatar;
    [UserService storeAvatar:user.avatar];
    [self goToMainScreen];
}

- (void) didSubmitAvatarForUserFail:(UserService *)service withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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
            if (g.groupId != nil) {
                [groupIds appendString:[NSString stringWithFormat:@"%@,", g.groupId]];
            } else {
                [groupIds appendString:[NSString stringWithFormat:@"%@,", g.groupName]];
            }
            
        }
        NSString *final = [groupIds substringToIndex:[groupIds length] - 1];
        user.groups = selectedGroups;
        [userService registerWithName:user.name withEmail:user.email withSection:user.section withYear:user.year withCity:user.city withState:user.state withCountry:user.country withPassword:user.password withGroupIds:final];
    }
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
    if ([selectedGroups containsObject:g]) {
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
    if ([selectedGroups containsObject:g]) {
        [selectedGroups removeObject:g];
    } else {
        [selectedGroups addObject:g];
    }
    [myTableView reloadData];
}


@end
