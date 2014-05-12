//
//  QuestionViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "QuestionViewController.h"
#import "UILineFooterView.h"
#import "Question.h"
#import "FillAQuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController
@synthesize myTableView, questionService, groups, selectedGroups;
@synthesize warningLbl;
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
    //[questionService retrieveGroups];
    
    self.userService = [[UserService alloc] init];
    userService.delegate = self;
    [userService retrieveUserInfoByUserId:[UserService signedInUserId]];
    
    if (selectedGroups == nil) {
        self.selectedGroups = [[NSMutableArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UserServiceDelegate
- (void)didRetrieveUserInfoByUserIdSuccess:(UserService *)service {
    self.groups = service.user.groups;
    [myTableView reloadData];
}

- (void)didRetrieveUserInfoByUserIdFail:(UserService *)service withMessage:(NSString *)message {
    
}

#pragma mark - QuestionServiceDelegate
- (void) didRetrieveGroupsSuccess: (QuestionService*) service {
    self.groups = service.groups;
    [myTableView reloadData];
}

- (void) didRetrieveGroupsFail: (QuestionService *)service withMessage: (NSString*) message {
    
}

#pragma mark - IBAction on view
- (IBAction)nextBtnTapped:(id)sender {
    if ([selectedGroups count] == 0) {
        warningLbl.text = EMPTY_GROUP_MSG;
    } else {
        FillAQuestionViewController *viewVC = [[FillAQuestionViewController alloc] initWithNibName:@"FillAQuestionViewController" bundle:nil];
        Question *question = [[Question alloc] init];
        question.groups = selectedGroups;
        viewVC.question = question;
        [self.navigationController pushViewController:viewVC animated:YES];
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
