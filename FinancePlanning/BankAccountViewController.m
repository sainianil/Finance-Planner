//
//  BankAccountViewController.m
//  FinancePlanning
//
//  Created by Anil Saini on 3/2/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "BankAccountViewController.h"
#import "Model/BankAccount.h"

@interface BankAccountViewController ()

@property (nonatomic, strong) BankAccount* bankAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblBalance;
@property (weak, nonatomic) IBOutlet UITextField *txtUpdateBalance;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateBalance;

@end

@implementation BankAccountViewController
@synthesize bankAccount;
@synthesize lblBalance;
@synthesize txtUpdateBalance;
@synthesize btnUpdateBalance;

- (BankAccount*)bankAccount {
    
    if (bankAccount == nil) {
        bankAccount = [[BankAccount alloc] init];
    }
    
    return bankAccount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btnUpdateBalance.enabled = NO;
    self.lblBalance.text = [NSString stringWithFormat:@"%.2f",  self.bankAccount.balance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateBalance:(id)sender {
    self.bankAccount.balance = [txtUpdateBalance.text floatValue];
    NSLog([NSString stringWithFormat:@"%.2f", self.bankAccount.balance]);
    lblBalance.text = [NSString stringWithFormat:@"%.2f",  self.bankAccount.balance];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextFieldDelegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField.text floatValue] > 0.0) {
        btnUpdateBalance.enabled = YES;
    }
}

@end
