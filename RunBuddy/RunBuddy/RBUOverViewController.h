//
//  RBUOverViewController.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 7/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBURunHelper.h"

@interface RBUOverViewController : UITableViewController
    @property NSMutableArray *maxtimes;
    @property NSMutableArray *mintimes;
    @property RBURunHelper *rh;

    @property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end
