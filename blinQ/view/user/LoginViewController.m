//
//  LoginViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/2/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import "Utils.h"
#import "User.h"
#import "RegisterViewController.h"
#import "ForgotPasswordViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize emailTxt, passwordTxt, myScrollView, changeAmount;
@synthesize userService;
@synthesize warningLbl;
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
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)] ;
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    emailTxt.delegate = self;
    passwordTxt.delegate = self;
    
    self.userService = [[UserService alloc] init];
    userService.delegate = self;
    

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
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
    
    CGRect frame = myScrollView.frame;
    myScrollView.contentSize = frame.size;
    
    CGPoint point = CGPointMake(frame.origin.x, frame.origin.y + frame.size.height);
    if (point.y > rect.origin.y) {
        changeAmount = point.y - rect.origin.y;
        frame.size.height -= changeAmount;
        myScrollView.frame = frame;
    } else {
        changeAmount = 0;
    }
}

- (void) onKeyboardHide: (NSNotification*) notification {
    CGRect frame = myScrollView.frame;
    frame.size.height += changeAmount;
    myScrollView.frame = frame;
}

#pragma mark - IBAction on view
- (IBAction)loginBtnTapped:(id)sender {
    NSString *email = emailTxt.text;
    NSString *password = passwordTxt.text;
    
    if ([email isEqual:@""] || [password isEqual:@""]) {
        warningLbl.text = EMPTY_LOGIN_FIELD_MSG;
        //for some accounts which do not have right email format.
//    } else if (![Utils validEmail:email]){
//        warningLbl.text = EMAIL_INVALID_MSG;
    } else {
        [userService loginWithEmail:email andPassword:password];
    }
}

- (IBAction)signUpBtnTapped:(id)sender {
    [self.view endEditing:YES];
    RegisterViewController *viewVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:viewVC animated:YES];
}

- (IBAction)forgotPasswordBtnTapped:(id)sender {
    [self.view endEditing:YES];
    ForgotPasswordViewController *viewVC = [[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:viewVC animated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == emailTxt) {
        [passwordTxt becomeFirstResponder];
    } else if (textField == passwordTxt) {
        [passwordTxt resignFirstResponder];
        [self loginBtnTapped:nil];
    }
    return YES;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]){
        return NO;
    }
    return YES;
}

#pragma mark - UserServiceDelegate
- (void)didLoginWithEmailSuccess:(UserService *)service {
    User *user = service.user;
    [UserService storeUserId:user.userId];
    [UserService storeUserName:user.name];
    [UserService storeEmail:user.email];
    [UserService storeYear:user.year];
    [UserService storeSection:user.section];
    [UserService storeCity:user.city];
    [UserService storeState:user.state];
    [UserService storeCountry:user.country];
    [UserService storeCreatedDate:user.createdDate];
    [UserService storeAvatar:user.avatar];
    [[AppDelegate sharedInstance] showMainScreen];
}

- (void)didLoginWithEmailFail:(UserService *)service withMessage:(NSString *)message {
    warningLbl.text = message;
}


@end
