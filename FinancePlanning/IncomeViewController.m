//
//  IncomeViewController.m
//  FinancePlanning
//
//  Created by Anil Saini on 3/2/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "IncomeViewController.h"

@interface IncomeViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSArray *incomeCategories;
    NSArray *recurringCategories;
}
@property (weak, nonatomic) IBOutlet UIPickerView *incomeCategory;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIPickerView *recurringType;
@property (weak, nonatomic) IBOutlet UITextField *txtNoOfOccurances;

- (void)setup;
@end

@implementation IncomeViewController
@synthesize incomeCategory;
@synthesize segmentControl;
@synthesize recurringType;
@synthesize txtNoOfOccurances;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    incomeCategory.delegate = self;
    incomeCategory.dataSource = self;
    recurringType.delegate = self;
    recurringType.dataSource = self;
    [self setup];
}

- (void)setup
{
    if(segmentControl.selectedSegmentIndex == 0) {
        txtNoOfOccurances.hidden = YES;
        recurringType.hidden = YES;
        incomeCategories = @[@"Loan", @"Borrow", @"Others"];
    } else if(segmentControl.selectedSegmentIndex == 1) {
        txtNoOfOccurances.hidden = NO;
        recurringType.hidden = NO;
        incomeCategories = @[@"Salary", @"FD Interest", @"Others"];
        recurringCategories = @[@"Montly", @"Quaterly"];
        [recurringType reloadAllComponents];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger noOfCompo = incomeCategories.count;
    if (pickerView == recurringType) {
        noOfCompo = recurringCategories.count;
    }
    return noOfCompo;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = incomeCategories[row];
    if (pickerView == recurringType) {
        title = recurringCategories[row];
    }
    return title;
}

- (IBAction)segmentControllerAction:(id)sender {
    [self setup];
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
