//
//  BankAccountViewController.m
//  FinancePlanning
//
//  Created by Anil Saini on 3/2/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "BankAccountViewController.h"

@interface BankAccountViewController ()

@end

@implementation BankAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.title = @"Bank Account Summary";
//    NSLog(@"%@", self.navigationController.title);
  
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return @"Bank Account Summary";
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
