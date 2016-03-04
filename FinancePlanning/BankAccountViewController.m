//
//  BankAccountViewController.m
//  FinancePlanning
//
//  Created by Anil Saini on 3/2/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "BankAccountViewController.h"
#import "Model/BankAccount.h"

@interface BankAccountViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblBalance;
@property (weak, nonatomic) IBOutlet UITextField *txtUpdateBalance;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateBalance;

@end

@implementation BankAccountViewController
@synthesize lblBalance;
@synthesize txtUpdateBalance;
@synthesize btnUpdateBalance;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    btnUpdateBalance.enabled = NO;
    self.lblBalance.text = [NSString stringWithFormat:@"%.2f",  [[BankAccount sharedBankAccount] balance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.txtUpdateBalance];
}

- (void)textFieldDidChange:(NSNotification*)notif {
    BOOL isEnable = NO;
    if ([txtUpdateBalance.text length] > 0) {
        isEnable = YES;
    }
    btnUpdateBalance.enabled = isEnable;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateBalance:(id)sender {
    [[BankAccount sharedBankAccount] setBalance:[txtUpdateBalance.text floatValue]];
   // NSLog([NSString stringWithFormat:@"%.2f", [[BankAccount sharedBankAccount] balance]]);
    lblBalance.text = [NSString stringWithFormat:@"%.2f",  [[BankAccount sharedBankAccount] balance]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //[textField resignFirstResponder];
    return YES;
}

@end
