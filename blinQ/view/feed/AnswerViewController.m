//
//  AnswerViewController.m
//  plug
//
//  Created by Le Thanh Hai on 5/17/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "AnswerViewController.h"
#import "SectionHeaderView.h"
@interface AnswerViewController ()

@end

@implementation AnswerViewController
@synthesize info, questionService, myTextView;
@synthesize warningLbl, changeAmount;
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
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)] ;
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];

}

- (void) dismissKeyboard: (UITapGestureRecognizer*) gesture {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.5];
    [super viewWillAppear:animated];
}

- (void) showKeyboard {
    [myTextView becomeFirstResponder];
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
    
    CGRect frame = myTextView.frame;
    //myScrollView.contentSize = frame.size;
    
    CGPoint point = CGPointMake(frame.origin.x, frame.origin.y + frame.size.height);
    if (point.y > rect.origin.y) {
        changeAmount = point.y - rect.origin.y;
        frame.size.height -= changeAmount;
        myTextView.frame = frame;
    } else {
        changeAmount = 0;
    }
}

- (void) onKeyboardHide: (NSNotification*) notification {
    CGRect frame = myTextView.frame;
    frame.size.height += changeAmount;
    myTextView.frame = frame;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction on view
- (IBAction)backBtnTapped:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitBtnTapped:(id)sender {
    NSString *text = myTextView.text;
    if ([text isEqual:@""]) {
        warningLbl.text = EMPTY_ANSWER_MSG;
    } else {
        [self.view endEditing:YES];
        [questionService submitAnswerFromUserId:[UserService signedInUserId] forQuestionId:info.question.questionId withAnswer:myTextView.text];
    }
}

#pragma mark - QuestionServiceDelegate
- (void)didSubmitAnswerSuccess:(QuestionService *)service {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:ANSWER_SUBMIT_SUCCESS_MSG delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [info.headerView recallAnswers];
}

- (void)didSubmitAnswerFail:(QuestionService *)service withMessage:(NSString *)message {
    
}

#pragma mark - UIAlerViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]){
        return NO;
    }
    return YES;
}


@end
