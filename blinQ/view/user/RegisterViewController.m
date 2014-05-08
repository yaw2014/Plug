//
//  RegisterViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 4/30/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "RegisterViewController.h"
#import "Constants.h"
#import "Utils.h"
#import "User.h"
#import "UserGroupViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize nameTxt, emailTxt, sectionBtn, avatarImgView, yearTxt, cityTxt, stateTxt, countryTxt, passwordTxt, confirmPasswordTxt;
@synthesize myScrollView, changeAmount;
@synthesize sectionPicker, sectionSelectView, sections;
@synthesize warningLbl;
@synthesize nextBtn;
@synthesize tempImgView;
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

    //init sections array
    self.sections = [[NSMutableArray alloc] init];
    [sections addObject:@""];
    [sections addObject:@"A"];
    [sections addObject:@"B"];
    [sections addObject:@"C"];
    [sections addObject:@"D"];
    [sections addObject:@"E"];
    [sections addObject:@"F"];
    [sections addObject:@"J"];

    sectionSelectView.frame = CGRectMake(0, self.view.frame.size.height, sectionSelectView.frame.size.width, sectionSelectView.frame.size.height);
    [self.view addSubview:sectionSelectView];
    
    //config textfield delegate
    nameTxt.delegate = self;
    emailTxt.delegate = self;
    yearTxt.delegate = self;
    cityTxt.delegate = self;
    stateTxt.delegate = self;
    countryTxt.delegate = self;
    passwordTxt.delegate = self;
    confirmPasswordTxt.delegate = self;
    
    myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width, nextBtn.frame.origin.y + nextBtn.frame.size.height + 10);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction on view
- (IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sectionBtnTapped:(id)sender {
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.2 animations:^{
        sectionSelectView.frame = CGRectMake(0, self.view.frame.size.height - sectionSelectView.frame.size.height, sectionSelectView.frame.size.width, sectionSelectView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void) closeSectionSelectView {
    [UIView animateWithDuration:0.2 animations:^{
        sectionSelectView.frame = CGRectMake(0, self.view.frame.size.height, sectionSelectView.frame.size.width, sectionSelectView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)avatarBtnTapped:(id)sender {
    [self.view endEditing:YES];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Avatar" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a photo", @"From library", nil];
    [sheet showInView:self.view];
}

- (IBAction)nextBtnTapped:(id)sender {
    NSString *name = nameTxt.text;
    NSString *email = emailTxt.text;
    NSString *section = sectionBtn.titleLabel.text;
    NSString *year = yearTxt.text;
    NSString *city = cityTxt.text;
    NSString *state = stateTxt.text;
    NSString *country = countryTxt.text;
    NSString *password = passwordTxt.text;
    NSString *confirm = confirmPasswordTxt.text;
    
    if ([name isEqual:@""] || [email isEqual:@""] || [section isEqual:@""] || [year isEqual:@""] || [city isEqual:@""]
        || [state isEqual:@""] || [country isEqual:@""]) {
        warningLbl.text = EMPTY_REGISTER_FIELD_MSG;
    } else if (![password isEqual:confirm]) {
        warningLbl.text = PASSWORD_REGISTER_NOT_MATCH_MSG;
    } else if (![Utils validEmail:email]) {
        warningLbl.text = EMAIL_INVALID_MSG;
    } else {
        //go to select group screeen
        User *user = [[User alloc] init];
        user.name = name;
        user.email = email;
        user.section = section;
        user.year = year;
        user.city = city;
        user.state = state;
        user.country = country;
        user.password = password;
        if (avatarImgView.image != nil) {
            user.avatarImg = avatarImgView.image;
        }
        
        [self.view endEditing:YES];
        UserGroupViewController *viewVC = [[UserGroupViewController alloc] initWithNibName:@"UserGroupViewController" bundle:nil];
        viewVC.user = user;
        [self.navigationController pushViewController:viewVC animated:YES];
    }
}

- (IBAction)cancelSectionView:(id)sender {
    [self closeSectionSelectView];
}

- (IBAction)doneSectionView:(id)sender {
    [self closeSectionSelectView];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [sections count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [sections objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [sectionBtn setTitle:[sections objectAtIndex:row] forState:UIControlStateNormal];
}

#pragma mark - UIActionSheetDelegate
- (void) takePicture {
    if (!([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])) {
		UIAlertView * myAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"This device does not support the camera" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[myAlert show];
	} else {
		UIImagePickerController * pickCont = [[UIImagePickerController alloc] init];
		pickCont.delegate = self;
		pickCont.allowsEditing = YES;
		pickCont.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickCont animated:YES completion:^{
            
        }];
	}
    
}

- (void) selectPicture {
    UIImagePickerController * pickCont = [[UIImagePickerController alloc] init];
	pickCont.delegate = self;
	pickCont.allowsEditing = YES;
	pickCont.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickCont animated:YES completion:^{
        
    }];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self takePicture];
    } else if (buttonIndex == 1) {
        [self selectPicture];
    }
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    tempImgView.hidden = YES;
	avatarImgView.image = (UIImage*) [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == nameTxt) {
        [emailTxt becomeFirstResponder];
    } else if (textField == emailTxt) {
        [textField resignFirstResponder];
        [self sectionBtnTapped:nil];
    } else if (textField == yearTxt) {
        [cityTxt becomeFirstResponder];
    } else if (textField == cityTxt) {
        [stateTxt becomeFirstResponder];
    } else if (textField == stateTxt) {
        [countryTxt becomeFirstResponder];
    } else if (textField == countryTxt) {
        [passwordTxt becomeFirstResponder];
    } else if (textField == passwordTxt) {
        [confirmPasswordTxt becomeFirstResponder];
    } else if (textField == confirmPasswordTxt) {
        [textField resignFirstResponder];
        [self nextBtnTapped:nil];
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
@end
