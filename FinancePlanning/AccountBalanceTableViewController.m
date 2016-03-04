//
//  AccountBalanceTableViewController.m
//  FinancePlanning
//
//  Created by Anil Saini on 04/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "AccountBalanceTableViewController.h"
#import "DBManager.h"
#import "MyUtilities.h"

@interface MonthlyBalanceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAccBalance;

@end

@implementation MonthlyBalanceTableViewCell
@synthesize lblDate;
@synthesize lblAccBalance;

@end

@interface AccountBalanceTableViewController ()
{
    NSArray *accBalance;
}
@end

@implementation AccountBalanceTableViewController

- (instancetype)init {
    if (self = [super init]) {
        accBalance = [NSArray array];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self calculateAccountBalance];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [accBalance count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"monthlyBalance";
    MonthlyBalanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MonthlyBalanceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.lblDate.text = [MyUtilities stringFromDate:[MyUtilities date:[NSDate date] increaseDateByMonth:indexPath.row]];
    cell.lblAccBalance.text = [NSString stringWithFormat:@"%@", [accBalance objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)calculateAccountBalance {
    NSArray *incomes = [[DBManager sharedDatabaseManager] allIncomes];
    NSArray *expenses = [[DBManager sharedDatabaseManager] allExpenses];
    
    float balance = [[DBManager sharedDatabaseManager] accountBalance];
    
    NSMutableArray *newBalances = [NSMutableArray array];
    float bal = balance;
    
    for (int i=0; i<12; i++) {
        NSDate *date = [MyUtilities date:[NSDate date] increaseDateByMonth:i];
        
        for (NSDictionary* dic in incomes) {
            if ([MyUtilities isDate:[MyUtilities dateFromString:[dic valueForKey:@"Date"]] equalTo:date]) {
                bal += [[dic valueForKey:@"Amount"] floatValue];
            }
        }
        
        NSLog(@"Income: %0.2f", bal);
        [newBalances addObject:[NSNumber numberWithFloat:bal]];
    }
    
//    NSLog(@"%@", newBalances);
    
    for (int i=0; i<12; i++) {
        NSDate *date = [MyUtilities date:[NSDate date] increaseDateByMonth:i];
        BOOL isExpense = NO;
        bal = [[newBalances objectAtIndex:i] floatValue];
        for (NSDictionary* dic in expenses) {
            if ([MyUtilities isDate:[MyUtilities dateFromString:[dic valueForKey:@"Date"]] equalTo:date]) {
                bal -= [[dic valueForKey:@"Amount"] floatValue];
                isExpense = YES;
            }
        }
        if (isExpense) {
//            NSLog(@"Expense: %0.2f", bal);
            [newBalances replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:bal]];
        }
        
    }
    
    accBalance = newBalances;
//    NSLog(@"=== %@", accBalance);
    newBalances = nil;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
