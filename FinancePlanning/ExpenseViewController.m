//
//  ExpenseViewController.m
//  FinancePlanning
//
//  Created by Anil Saini on 3/2/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "ExpenseViewController.h"
#import "Expense.h"
#import "MyUtilities.h"

@interface ExpenseViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    NSArray *expenseCategories;
    NSArray *recurringCategories;
}

@property (weak, nonatomic) IBOutlet UIPickerView *expenseCategory;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIPickerView *recurringType;
@property (weak, nonatomic) IBOutlet UITextField *txtNoOfOccurences;
@property (weak, nonatomic) IBOutlet UITextField *txtExpenseDesc;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnAddExpense;
@property (weak, nonatomic) IBOutlet UILabel *lblRepeat;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;

- (void)setup;
- (void)enableDisableAddExpenseButton;
- (void)clearFields;
@end

@implementation ExpenseViewController
@synthesize expenseCategory;
@synthesize segmentControl;
@synthesize recurringType;
@synthesize txtNoOfOccurences;
@synthesize lblRepeat;
@synthesize txtAmount;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up picker view delegate and data soruce
    self.expenseCategory.delegate = self;
    self.expenseCategory.dataSource = self;
    self.recurringType.delegate = self;
    self.recurringType.dataSource = self;

    //setup ui
    [self setup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtExpenseDesc];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtNoOfOccurences];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtAmount];
}

- (void)textFieldDidChange:(NSNotification*)notif {
    [self enableDisableAddExpenseButton];
}

- (void)dealloc {
    expenseCategories = nil;
    recurringCategories = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup
{
    //Set up UI view as per event type
    BOOL isHidden = NO;
    if(segmentControl.selectedSegmentIndex == 0) {  // Ad-hoc expense source
        isHidden = YES;
        expenseCategories = @[@"Car Insurance", @"Life Insurance", @"Others"];
    } else if(segmentControl.selectedSegmentIndex == 1) {  //Recurring expense source
        expenseCategories = @[@"Food & Groceries", @"Utility Bills", @"Rent", @"Others"];
        recurringCategories = @[@"Monthly", @"Quaterly"];
        [recurringType reloadAllComponents];
    }
    
    lblRepeat.hidden = txtNoOfOccurences.hidden = recurringType.hidden = isHidden;
    [self enableDisableAddExpenseButton];
    [self clearFields];
}

- (void)enableDisableAddExpenseButton {
    BOOL isEnable = NO;
    BOOL isAdHoc = ([self.txtAmount.text length] > 0 && [self.txtExpenseDesc.text length] > 0);
    if((segmentControl.selectedSegmentIndex == 0 && isAdHoc) || (segmentControl.selectedSegmentIndex == 1 && [self.txtNoOfOccurences.text length] > 0 && isAdHoc))  {
        isEnable = YES;
    }
    
    self.btnAddExpense.enabled = isEnable;
}

- (void)clearFields {
    self.txtAmount.text = @"";
    self.txtExpenseDesc.text = @"";
    self.txtNoOfOccurences.text = @"";
    [self.eventDatePicker setDate:[NSDate date]];
    [expenseCategory reloadComponent:0];
    [recurringType reloadComponent:0];
    [self enableDisableAddExpenseButton];
}

- (IBAction)segmentControlAction:(UISegmentedControl *)sender {
    [self setup];
}

- (IBAction)addExpense:(UIButton *)sender {
    
    Expense *expense = [[Expense alloc] init];
    EventType eType = eAd_hoc;
    
    if(self.segmentControl.selectedSegmentIndex == 1) {
        eType = eRecurring;
    }
    
    [[expense event] setEventType:eType];
//    NSLog(@"%@", [expenseCategories objectAtIndex:[expenseCategory selectedRowInComponent:0]]);
    [[expense event] setEventName:[expenseCategories objectAtIndex:[expenseCategory selectedRowInComponent:0]]];
    [[expense event] setAmount:[NSNumber numberWithFloat:[self.txtAmount.text floatValue]]];
    [[expense event] setEventDescription:self.txtExpenseDesc.text];
    [[expense event] setStartDate:self.eventDatePicker.date];
    [[expense event] setRecurringByDuration:[recurringCategories objectAtIndex:[recurringType selectedRowInComponent:0]]];
    [[expense event] setOccurrences: [NSNumber numberWithInteger:[self.txtNoOfOccurences.text integerValue]]];
    if(![expense updateExpense]) {
       [self presentViewController:[MyUtilities alert:@"Database Error" message:@"Failed to add expense source. Please try again later." button:@"OK"] animated:YES completion:nil];
    } else {
        [self presentViewController:[MyUtilities alert:@"Expense is added successfully" message:[[expense event] eventDetail] button:@"OK"] animated:YES completion:nil];
        [self clearFields];
    }
    expense = nil;
}


#pragma mark - pickerView datasource methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger noOfCompo = expenseCategories.count;  //Ad-hoc income source
    if (pickerView == recurringType) {  //recurrring income source
        noOfCompo = recurringCategories.count;
    }
    return noOfCompo;
}

#pragma mark - pickerView delegate methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = expenseCategories[row];
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
