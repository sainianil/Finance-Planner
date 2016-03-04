//
//  MonthlyExpenseViewController.m
//  FinancePlanning
//
//  Created by Anil Saini on 04/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "MonthlyExpenseViewController.h"
#import "PNChart/PNChart.h"
#import "PNChart/PNCircleChart.h"

@interface MonthlyExpenseViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation MonthlyExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showChart:(id)sender {
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed description:@"Others"],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"Food & Groceries"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"Rent"],
                       ];
    
    
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(80.0, 155.0, 240.0, 240.0) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart strokeChart];
    [self.containerView addSubview:pieChart];
}

@end
