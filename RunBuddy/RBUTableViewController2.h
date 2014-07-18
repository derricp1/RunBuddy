//
//  RBUTableViewController2.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 7/8/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBURunHelper.h"

@interface RBUTableViewController2 : UITableViewController
    @property (strong) RBURunHelper* rh;
    @property NSMutableArray *maxtimes;
    @property NSMutableArray *mintimes;
@end
