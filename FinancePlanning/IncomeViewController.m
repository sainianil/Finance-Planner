//
//  IncomeViewController.m
//  FinancePlanning
//
//  Created by Anil Saini on 3/2/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "IncomeViewController.h"
#import "Model/Income.h"
#import "MyUtilities.h"

@interface IncomeViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate> {
    NSArray *incomeCategories;
    NSArray *recurringCategories;
}
@property (weak, nonatomic) IBOutlet UIPickerView *incomeCategory;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIPickerView *recurringType;
@property (weak, nonatomic) IBOutlet UITextField *txtNoOfOccurences;
@property (weak, nonatomic) IBOutlet UITextField *txtIncomeDesc;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnAddIncome;
@property (weak, nonatomic) IBOutlet UILabel *lblRepeat;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;

- (void)setup;
- (void)enableDisableAddIncomeButton;
- (void)clearFields;
@end

@implementation IncomeViewController
@synthesize incomeCategory;
@synthesize segmentControl;
@synthesize recurringType;
@synthesize txtNoOfOccurences;
@synthesize lblRepeat;
@synthesize txtAmount;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set pickerView delegate and datasoruce
    incomeCategory.delegate = self;
    incomeCategory.dataSource = self;
    recurringType.delegate = self;
    recurringType.dataSource = self;
    //Setup UI
    [self setup];
    
    //Setup textfield change observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtIncomeDesc];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtNoOfOccurences];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtAmount];
}

- (void)textFieldDidChange:(NSNotification*)notif {
    [self enableDisableAddIncomeButton];
}


- (void)dealloc {
    incomeCategories = nil;
    recurringCategories = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setup
{
    //Set up UI view as per event type
    BOOL isHidden = NO;
    if(segmentControl.selectedSegmentIndex == 0) {  // Ad-hoc Income source
        isHidden = YES;
        incomeCategories = @[@"Loan", @"Borrow", @"Others"];
        [incomeCategory reloadAllComponents];
    } else if(segmentControl.selectedSegmentIndex == 1) {  //Recurring Income source
        incomeCategories = @[@"Salary", @"FD Interest", @"Others"];
        recurringCategories = @[@"Monthly", @"Quaterly"];
        [recurringType reloadAllComponents];
    }
    [self clearFields];
    
    lblRepeat.hidden = txtNoOfOccurences.hidden = recurringType.hidden = isHidden;
    [self enableDisableAddIncomeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enableDisableAddIncomeButton {
    BOOL isEnable = NO;
    BOOL isAdHoc = ([self.txtAmount.text length] > 0 && [self.txtIncomeDesc.text length] > 0);
    if((segmentControl.selectedSegmentIndex == 0 && isAdHoc) || (segmentControl.selectedSegmentIndex == 1 && [self.txtNoOfOccurences.text length] > 0 && isAdHoc))  {
        isEnable = YES;
    }

    self.btnAddIncome.enabled = isEnable;
}

- (void)clearFields {
    self.txtAmount.text = @"";
    self.txtIncomeDesc.text = @"";
    self.txtNoOfOccurences.text = @"";
    [self.incomeCategory reloadComponent:0];
    [self.recurringType reloadComponent:0];
    [self.eventDatePicker setDate:[NSDate date]];
    [self enableDisableAddIncomeButton];
}

- (IBAction)segmentControllerAction:(id)sender {
    [self setup]; //change UI as per segment control selection
}

//Add income source
- (IBAction)addIncomeSource:(id)sender {
    Income *income = [[Income alloc] init];
    EventType eType = eAd_hoc;
    
    if(self.segmentControl.selectedSegmentIndex == 1) {
        eType = eRecurring;
    }

    [[income event] setEventType:eType];
//    NSLog(@"%@", [incomeCategories objectAtIndex:[incomeCategory selectedRowInComponent:0]]);
    [[income event] setEventName:[incomeCategories objectAtIndex:[incomeCategory selectedRowInComponent:0]]];
    [[income event] setAmount:[NSNumber numberWithFloat:[self.txtAmount.text floatValue]]];
    [[income event] setEventDescription:self.txtIncomeDesc.text];
    [[income event] setStartDate:self.eventDatePicker.date];
    [[income event] setRecurringByDuration:[recurringCategories objectAtIndex:[recurringType selectedRowInComponent:0]]];
    [[income event] setOccurrences: [NSNumber numberWithInteger:[self.txtNoOfOccurences.text integerValue]]];

    if(![income updateIncome]) {
        [self presentViewController:[MyUtilities alert:@"Database Error" message:@"Failed to add income source. Please try again later." button:@"OK"] animated:YES completion:nil];
    } else {
        [self presentViewController:[MyUtilities alert:@"Income is added successfully" message:[[income event] eventDetail] button:@"OK"] animated:YES completion:nil];
        [self clearFields];
    }
    income = nil;
}

#pragma mark - pickerView datasource methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger noOfCompo = incomeCategories.count;  //Ad-hoc income source
    if (pickerView == recurringType) {  //recurrring income source
        noOfCompo = recurringCategories.count;
    }
    return noOfCompo;
}

#pragma mark - pickerView delegate methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = incomeCategories[row];
    if (pickerView == recurringType) {
        title = recurringCategories[row];
    }
    return title;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //[textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
