//
//  SearchViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "SearchViewController.h"
#import "UILineFooterView.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize mySearchBar, myTableView;
@synthesize questionService;
@synthesize hud;
@synthesize sectionInfoArray;
@synthesize openSectionIndex;
@synthesize submitAnswerCell, otherAnswerCell;
@synthesize currentQuestionIndex;
@synthesize changeAmount;
@synthesize submitAnAnswerCell;
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
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"Loading";

    self.sectionInfoArray = [[NSMutableArray alloc] init];
    openSectionIndex = NSNotFound;
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)] ;
//    tapGesture.delegate = self;
//    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dismissKeyboard: (UITapGestureRecognizer*) gesture {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}


- (void) onKeyboardShow: (NSNotification*) notification {
    NSDictionary *dic = notification.userInfo;
    NSValue *val = [dic objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [val CGRectValue];
    rect = [self.view convertRect:rect fromView:nil];
    
    CGRect frame = myTableView.frame;
    myTableView.contentSize = frame.size;
    
    CGPoint point = CGPointMake(frame.origin.x, frame.origin.y + frame.size.height);
    if (point.y > rect.origin.y) {
        changeAmount = point.y - rect.origin.y;
        frame.size.height -= changeAmount;
        myTableView.frame = frame;
    } else {
        changeAmount = 0;
    }
}

- (void) onKeyboardHide: (NSNotification*) notification {
    CGRect frame = myTableView.frame;
    frame.size.height += changeAmount;
    myTableView.frame = frame;
}

#pragma mark - QuestionServiceDelegate
- (void)didSearchQuestionsSuccess:(QuestionService *)service {
    [hud hide:YES];
    NSMutableArray *array = service.questions;
    [sectionInfoArray removeAllObjects];
    for (Question *question in array) {
        SectionInfo *info = [[SectionInfo alloc] init];
        info.open = NO;
        info.question = question;
        
        [sectionInfoArray addObject:info];
    }
    [myTableView reloadData];

}

- (void)didSearchQuestionsFail:(QuestionService *)service withMessage:(NSString *)message {
    
}

- (void)didSubmitAnswerSuccess:(QuestionService *)service {
    [hud hide:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:ANSWER_SUBMIT_SUCCESS_MSG delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    SectionInfo *info = [sectionInfoArray objectAtIndex:currentQuestionIndex];
    [info.headerView recallAnswers];
}

- (void)didSubmitAnswerFail:(QuestionService *)service withMessage:(NSString *)message {
    
}

- (void) didVoteAnswerSuccess:(QuestionService *)service {
    
}

- (void)didVoteAnswerFail:(QuestionService *)service withMessage:(NSString *)message {
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [sectionInfoArray removeAllObjects];
    [myTableView reloadData];
    searchBar.showsCancelButton = YES;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (![searchBar.text isEqual:@""]) {
        [hud show:YES];
        [questionService searchQuestionByKeyword:searchBar.text];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [sectionInfoArray removeAllObjects];
    [myTableView reloadData];
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
}


#pragma mark - OtherAnswerTableViewCellDelegate
- (void)didVoteForAnswer:(Answer *)answer withValue:(NSInteger)value {
    [questionService voteForAnswer:answer.answerId withUserId:[UserService signedInUserId] withValue:value];
}

#pragma mark - SubmitAnswerTableViewCellDelegate
- (void)submitAnswer:(NSString *)answer forQuestion:(Question *)question atSectionIndex:(NSInteger)sectionIndex{
    self.currentQuestionIndex = sectionIndex;
    [hud show:YES];
    [questionService submitAnswerFromUserId:[UserService signedInUserId] forQuestionId:question.questionId withAnswer:answer];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SectionInfo *info = [sectionInfoArray objectAtIndex:section];
    if (info.headerView == nil) {
        info.headerView = [[SectionHeaderView alloc] initWithQuestion:info.question section:section delegate:self];
    }
    
    return info.headerView.frame.size.height;
}

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
        return 44;
    } else {
        
        UIFont *font = [UIFont systemFontOfSize:14.0];
        CGSize limitSize = CGSizeMake(227, 9999);
        
        SectionInfo *info = [sectionInfoArray objectAtIndex:indexPath.section];
        Answer *answer = [info.question.answers objectAtIndex:indexPath.row - 1];
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
    return info.open ? count + 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *CellIdentifier1 = @"SubmitAnAnswerTableViewCell";
        
        SubmitAnAnswerTableViewCell *cell = (SubmitAnAnswerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            NSString * viewStr = @"SubmitAnAnswerTableViewCell";
            UINib * cellNib = [UINib nibWithNibName:viewStr bundle:nil];
            [cellNib instantiateWithOwner:self options:nil];
            cell = self.submitAnAnswerCell;
            self.submitAnAnswerCell = nil;
        }
        /*
        SectionInfo *info = [sectionInfoArray objectAtIndex:indexPath.section];
        cell.delegate = self;
        cell.sectionIndex = indexPath.section;
        cell.question = info.question;
        cell.nameLbl.text = [UserService signedInUserName];
        cell.descriptionLbl.text = [NSString stringWithFormat:@"%@, Section %@", [UserService signedInYear], [UserService signedInSection]];
        cell.avatarImgView.imgUrl = [UserService signedInAvatar];
         */
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
        cell.delegate = self;
        Answer *answer = [info.question.answers objectAtIndex:indexPath.row - 1];
        cell.answer = answer;
        cell.nameLbl.text = answer.user.name;
        cell.descriptionLbl.text = [NSString stringWithFormat:@"%@, Section %@", answer.user.year, answer.user.section];
        cell.answerLbl.text = answer.answer;
        cell.voteUpLbl.text = [NSString stringWithFormat:@"Voted by %d people", (int)answer.voteUp];
        if (answer.value == 1) {
            cell.upBtn.selected = YES;
            cell.downBtn.enabled = NO;
        } else if (answer.value == -1) {
            cell.downBtn.selected = YES;
            cell.upBtn.enabled = NO;
        }
        cell.avatarImgView.imgUrl = answer.user.avatar;
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
    if (indexPath.row == 0) {
        //open new screen to input answer
        SectionInfo *info = [sectionInfoArray objectAtIndex:indexPath.section];
        AnswerViewController *viewVC = [[AnswerViewController alloc] initWithNibName:@"AnswerViewController" bundle:nil];
        viewVC.info = info;
        [self.navigationController pushViewController:viewVC animated:YES];
    }
}

#pragma mark Section header delegate
- (void)requestAnswerDidStart:(SectionHeaderView *)sectionHeaderView {
    [hud show:YES];
}

- (void)requestAnswerDidEnd:(SectionHeaderView *)sectionHeaderView {
    [hud hide:YES];
}

- (void)didRetrieveAnswersSectionHeaderView:(SectionHeaderView *)headerView {
    [myTableView reloadData];
}

-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionOpened];
	
	sectionInfo.open = YES;
    self.openSectionIndex = sectionOpened;
    [myTableView reloadData];
}


-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionClosed];
	
    sectionInfo.open = NO;
    self.openSectionIndex = NSNotFound;
    [myTableView reloadData];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]){
        return NO;
    } else {
        UIView *superView = touch.view.superview;
        while (![superView isKindOfClass:[UITableViewCell class]]) {
            if (superView.superview) {
                superView = superView.superview;
            }
        }
        if ([superView isKindOfClass:[UITableViewCell class]]) {
            return NO;
        }
    }
    return YES;
}


@end
