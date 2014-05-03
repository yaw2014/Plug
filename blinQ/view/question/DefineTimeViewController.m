//
//  DefineTimeViewController.m
//  blinQ
//
//  Created by Le Thanh Hai on 5/3/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#import "DefineTimeViewController.h"
#import "ReviewViewController.h"

@interface DefineTimeViewController ()

@end

@implementation DefineTimeViewController
@synthesize question, myPickerView, expireDateLbl;
@synthesize days, hours;
@synthesize expireDate;
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
    self.days = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        [days addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    self.hours = [[NSMutableArray alloc] init];
    for (int i = 0; i < 24; i++) {
        [hours addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    [self showExpireDateLbl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showExpireDateLbl {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = [[days objectAtIndex:[myPickerView selectedRowInComponent:0]] intValue];
    components.hour = [[hours objectAtIndex:[myPickerView selectedRowInComponent:1]] intValue];
    
    NSDate *newDate = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy, HH:mm a"];
    expireDateLbl.text = [dateFormatter stringFromDate:newDate];
    expireDate = newDate;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [days count];
    } else {
        return [hours count];
    }
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [days objectAtIndex:row];
    } else {
        return [hours objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self showExpireDateLbl];
}

#pragma mark - IBAction on view
- (IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtnTapped:(id)sender {
    question.expireDate = expireDate;
    ReviewViewController *viewVC = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
    viewVC.question = question;
    [self.navigationController pushViewController:viewVC animated:YES];
}


@end
