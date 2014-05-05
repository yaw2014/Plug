//
//  MyQuestionsViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/4/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "MyQuestionsViewController.h"

@interface MyQuestionsViewController ()

@end

@implementation MyQuestionsViewController
@synthesize myTableView, sectionInfoArray, questionService;
@synthesize openSectionIndex;
@synthesize submitAnswerCell, otherAnswerCell;
@synthesize currentQuestionIndex;

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
    openSectionIndex = NSNotFound;
    
    self.questionService = [[QuestionService alloc] init];
    questionService.delegate = self;
    [questionService getMyQuestionsWithUserId:[UserService signedInUserId] withIgnoreIds:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QuestionServiceDelegate
- (void)didGetMyQuestionsSuccess:(QuestionService *)service {
    NSMutableArray *array = service.questions;
    self.sectionInfoArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (Question *question in array) {
        SectionInfo *info = [[SectionInfo alloc] init];
        info.open = NO;
        info.question = question;
        
        [sectionInfoArray addObject:info];
    }
    [myTableView reloadData];
}

- (void)didGetMyQuestionsFail:(QuestionService *)service withMessage:(NSString *)message {
    
}

- (void)didSubmitAnswerSuccess:(QuestionService *)service {
    SectionInfo *info = [sectionInfoArray objectAtIndex:currentQuestionIndex];
    [info.headerView retrieveAnswers];
}

- (void)didSubmitAnswerFail:(QuestionService *)service withMessage:(NSString *)message {
    
}

#pragma mark - SubmitAnswerTableViewCellDelegate
- (void)submitAnswer:(NSString *)answer forQuestion:(Question *)question atSectionIndex:(NSInteger)sectionIndex{
    self.currentQuestionIndex = sectionIndex;
    [questionService submitAnswerFromUserId:[UserService signedInUserId] forQuestionId:question.questionId withAnswer:answer];
}

#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionInfo *info = [sectionInfoArray objectAtIndex:section];
    if (info.headerView == nil) {
        info.headerView = [[SectionHeaderView alloc] initWithQuestion:info.question section:section delegate:self];
    }
    return info.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGRect f = CGRectMake(0, 0, tableView.frame.size.width, 5.0f);
    UILineFooterView * v = [[UILineFooterView alloc] initWithFrame:f];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 125;
    } else {
        
        UIFont *font = [UIFont systemFontOfSize:14.0];
        CGSize limitSize = CGSizeMake(227, 9999);
        
        SectionInfo *info = [sectionInfoArray objectAtIndex:indexPath.section];
        Answer *answer = [info.question.answers objectAtIndex:indexPath.row];
        CGSize size = [answer.answer sizeWithFont:font constrainedToSize:limitSize lineBreakMode:NSLineBreakByCharWrapping];
        if (size.height < 94) {
            return 125;
        } else {
            return size.height + 20;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [sectionInfoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    SectionInfo *info = [sectionInfoArray objectAtIndex:section];
    NSInteger count = [info.question.answers count];
    return info.open ? count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *CellIdentifier1 = @"SubmitAnswerTableViewCell";
        
        SubmitAnswerTableViewCell *cell = (SubmitAnswerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            NSString * viewStr = @"SubmitAnswerTableViewCell";
            UINib * cellNib = [UINib nibWithNibName:viewStr bundle:nil];
            [cellNib instantiateWithOwner:self options:nil];
            cell = self.submitAnswerCell;
            self.submitAnswerCell = nil;
        }
        
        SectionInfo *info = [sectionInfoArray objectAtIndex:indexPath.section];
        cell.delegate = self;
        cell.sectionIndex = indexPath.section;
        cell.question = info.question;
        cell.nameLbl.text = [UserService signedInUserName];
        cell.descriptionLbl.text = [NSString stringWithFormat:@"%@, Section %@", [UserService signedInYear], [UserService signedInSection]];
        return cell;
    } else {
        static NSString *CellIdentifier2 = @"OtherAnswerTableViewCell";
        
        OtherAnswerTableViewCell *cell = (OtherAnswerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            NSString * viewStr = @"OtherAnswerTableViewCell";
            UINib * cellNib = [UINib nibWithNibName:viewStr bundle:nil];
            [cellNib instantiateWithOwner:self options:nil];
            cell = self.otherAnswerCell;
            self.otherAnswerCell = nil;
        }
        
        SectionInfo *info = [sectionInfoArray objectAtIndex:indexPath.section];
        Answer *answer = [info.question.answers objectAtIndex:indexPath.row];
        cell.nameLbl.text = answer.user.name;
        cell.descriptionLbl.text = [NSString stringWithFormat:@"%@, Section %@", answer.user.year, answer.user.section];
        cell.answerLbl.text = answer.answer;
        return cell;
    }
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
}

#pragma mark Section header delegate
- (void)didRetriveAnswersSectionHeaderView:(SectionHeaderView *)headerView {
    [myTableView reloadData];
}

-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionOpened];
	
	sectionInfo.open = YES;
    
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
     */
    NSInteger countOfRowsToInsert = [sectionInfo.question.answers count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
		
		SectionInfo *previousOpenSection = [self.sectionInfoArray objectAtIndex:previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = [previousOpenSection.question.answers count];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationFade;
        deleteAnimation = UITableViewRowAnimationFade;
    }
    else {
        insertAnimation = UITableViewRowAnimationFade;
        deleteAnimation = UITableViewRowAnimationFade;
    }
    
    // Apply the updates.
    [self.myTableView beginUpdates];
    [self.myTableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.myTableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.myTableView endUpdates];
    self.openSectionIndex = sectionOpened;
    
}


-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionClosed];
	
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.myTableView numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.myTableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationFade];
    }
    self.openSectionIndex = NSNotFound;
}

@end
