//
//  RBUTableViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/30/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBUTableViewController.h"

@interface RBUTableViewController ()

@end

@implementation RBUTableViewController

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
    
    // Configure the cell...
    int lt = [[_rh.laptimes objectAtIndex:indexPath.row] intValue];
    double allseconds = lt/10;
    int minutes = allseconds/60;
    int seconds = allseconds - 60*minutes;
    
    NSString* mstring = [NSString stringWithFormat:@"%i", minutes];
    NSString* sstring = [NSString stringWithFormat:@"%i", seconds];
    
    if (seconds < 10) {
        sstring = [@"0" stringByAppendingString:sstring];
    }
    
    NSString* time = [[mstring stringByAppendingString:@":"] stringByAppendingString:sstring];
    
    //NSString* dist = [@"          " stringByAppendingString:[NSString stringWithFormat:@"%.2f", distance]];
    //dist = [dist stringByAppendingString:@" miles"];
    
    //cell.textLabel.text = [time stringByAppendingString:dist];
    cell.textLabel.text = time;
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToTVC2"])
    {
        UINavigationController *nav = (UINavigationController*) segue.destinationViewController;
        RBUTableViewController2 *dest = (RBUTableViewController2*) nav.topViewController;
        dest.rh = _rh;
        dest.maxtimes = _maxtimes;
        dest.mintimes = _mintimes;
    }
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
