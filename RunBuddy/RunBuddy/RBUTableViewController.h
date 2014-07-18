//
//  RBUTableViewController.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/30/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBURunHelper.h"
#import "RBUTableViewController2.h"

@interface RBUTableViewController : UITableViewController
    @property (strong) RBURunHelper* rh;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
    @property NSMutableArray *maxtimes;
    @property NSMutableArray *mintimes;
@end
