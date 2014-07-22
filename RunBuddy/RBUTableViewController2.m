//
//  RBUTableViewController2.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 7/8/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBUTableViewController2.h"
#import "RBUOverViewController.h"
#import "RBUResultsViewController.h"

@interface RBUTableViewController2 ()

@end

@implementation RBUTableViewController2

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_maxtimes count] + [_mintimes count] == 0) {
        _moreButton.enabled = NO;
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rh.totallaps;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];

    int ld = [[_rh.lapdistances objectAtIndex:indexPath.row] intValue];
    double distance = (ld/5280);

    NSString* dist = [@"" stringByAppendingString:[NSString stringWithFormat:@"%.2f", distance]];
    dist = [dist stringByAppendingString:@" miles"];
    
    //cell.textLabel.text = [time stringByAppendingString:dist];
    cell.textLabel.text = dist;
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToUp"])
    {
        UINavigationController *nav = (UINavigationController*) segue.destinationViewController;
        RBUOverViewController *dest = (RBUOverViewController*) nav.topViewController;
        dest.maxtimes = _maxtimes;
        dest.mintimes = _mintimes;
        dest.rh = _rh;
    }
    if ([segue.identifier isEqualToString:@"BackToResults"])
    {
        UINavigationController *nav = (UINavigationController*) segue.destinationViewController;
        RBUResultsViewController *dest = (RBUResultsViewController*) nav.topViewController;
        dest.maxtimes = _maxtimes;
        dest.mintimes = _mintimes;
        dest.rh = _rh;
    }
}

- (IBAction)pushedMore:(id)sender {
    [self performSegueWithIdentifier:@"GoToUp" sender:sender];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
