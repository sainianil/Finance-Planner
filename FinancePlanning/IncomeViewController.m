//
//  IncomeViewController.m
//  FinancePlanning
//
//  Created by Anil Saini on 3/2/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "IncomeViewController.h"
#import "Model/Income.h"

@interface IncomeViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
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

- (void)setup;
- (void)enableDisableAddIncomeButton;
@end

@implementation IncomeViewController
@synthesize incomeCategory;
@synthesize segmentControl;
@synthesize recurringType;
@synthesize txtNoOfOccurences;
@synthesize lblRepeat;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set pickerView delegate and datasoruce
    incomeCategory.delegate = self;
    incomeCategory.dataSource = self;
    recurringType.delegate = self;
    recurringType.dataSource = self;
    [self enableDisableAddIncomeButton];
    [self setup];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtIncomeDesc];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtNoOfOccurences];
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
    } else if(segmentControl.selectedSegmentIndex == 1) {  //Recurring Income source
        incomeCategories = @[@"Salary", @"FD Interest", @"Others"];
        recurringCategories = @[@"Montly", @"Quaterly"];
        [recurringType reloadAllComponents];
    }
    
    lblRepeat.hidden = txtNoOfOccurences.hidden = recurringType.hidden = isHidden;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enableDisableAddIncomeButton {
    BOOL isEnable = NO;
    
    if(segmentControl.selectedSegmentIndex == 0 && [self.txtIncomeDesc.text length] > 0)  {
        isEnable = YES;
    }
    else if (segmentControl.selectedSegmentIndex == 1 && [self.txtNoOfOccurences.text length] > 0 && [self.txtIncomeDesc.text length] > 0) {
        isEnable = YES;
    }

    self.btnAddIncome.enabled = isEnable;
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
    NSLog(@"%@", [incomeCategories objectAtIndex:[incomeCategory selectedRowInComponent:0]]);
    [[income event] setEventName:[incomeCategories objectAtIndex:[incomeCategory selectedRowInComponent:0]]];
    [[income event] setEventDescription:self.txtIncomeDesc.text];
    [[income event] setStartDate:self.eventDatePicker.date];
    [[income event] setRecurringByDuration:[recurringCategories objectAtIndex:[recurringType selectedRowInComponent:0]]];
    [[income event] setOccurrences: [NSNumber numberWithInteger:[self.txtNoOfOccurences.text integerValue]]];
    [income updateIncome];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
