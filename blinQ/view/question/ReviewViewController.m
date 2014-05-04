//
//  ReviewViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "ReviewViewController.h"
#import "Group.h"
#import "QuestionViewController.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController
@synthesize question;
@synthesize myScrollView;
@synthesize titleLbl, subjectLbl, questionLbl, expireDateLbl;
@synthesize questionService;

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
    
    NSMutableString *temp = [[NSMutableString alloc] initWithString:@"To: "];
    for (Group *group in question.groups) {
        [temp appendString:[NSString stringWithFormat:@"%@, ", group.groupName]];
    }
    NSString *final = [temp substringToIndex:[temp length] - 1];
    titleLbl.text = final;
    subjectLbl.text = question.subject;
    questionLbl.text = question.question;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy, HH:mm a"];
    expireDateLbl.text = [dateFormatter stringFromDate:question.expireDate];
    
    CGFloat heightDistance = 10;
    CGRect frame;
    
    frame = titleLbl.frame;
    frame.origin.y = heightDistance;
    frame.size.height = [titleLbl.text sizeWithFont:titleLbl.font constrainedToSize:CGSizeMake(frame.size.width, 9999) lineBreakMode:NSLineBreakByCharWrapping].height;
    titleLbl.frame = frame;
    
    frame = subjectLbl.frame;
    frame.origin.y = titleLbl.frame.origin.y + titleLbl.frame.size.height + heightDistance;
    frame.size.height = [subjectLbl.text sizeWithFont:subjectLbl.font constrainedToSize:CGSizeMake(frame.size.width, 9999) lineBreakMode:NSLineBreakByCharWrapping].height;
    subjectLbl.frame = frame;
    
    frame = questionLbl.frame;
    frame.origin.y = subjectLbl.frame.origin.y + subjectLbl.frame.size.height + heightDistance;
    frame.size.height = [questionLbl.text sizeWithFont:questionLbl.font constrainedToSize:CGSizeMake(frame.size.width, 9999) lineBreakMode:NSLineBreakByCharWrapping].height;
    questionLbl.frame = frame;
    
    frame = expireDateLbl.frame;
    frame.origin.y = questionLbl.frame.origin.y + questionLbl.frame.size.height + heightDistance;
    frame.size.height = [expireDateLbl.text sizeWithFont:expireDateLbl.font constrainedToSize:CGSizeMake(frame.size.width, 9999) lineBreakMode:NSLineBreakByCharWrapping].height;
    expireDateLbl.frame = frame;
    
    myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width, frame.origin.y + frame.size.height + heightDistance);
    
    self.questionService = [[QuestionService alloc] init];
    questionService.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction on view
- (IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)postBtnTapped:(id)sender {    
    NSMutableString *groupIds = [[NSMutableString alloc] initWithString:@""];
    for (Group *g in question.groups) {
        [groupIds appendString:[NSString stringWithFormat:@"%@,", g.groupId]];
    }
    NSString *final = [groupIds substringToIndex:[groupIds length] - 1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy, HH:mm a"];
    [questionService askAQuestionFromUserId:[UserService signedInUserId] withSubject:question.subject withQuestion:question.question withGroupIds:final withExpireDate:[dateFormatter stringFromDate:question.expireDate]];
}

#pragma mark - QuestionServiceDelegate
- (void)didAskAQuestionSuccess:(QuestionService *)service {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:ASK_QUESTION_SUCCESS_MSG delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didAskAQuestionFail:(QuestionService *)service withMessage:(NSString *)message {
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    QuestionViewController *viewVC = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    NSArray *arr = [NSArray arrayWithObject:viewVC];
    [self.navigationController setViewControllers:arr animated:YES];
}

@end
