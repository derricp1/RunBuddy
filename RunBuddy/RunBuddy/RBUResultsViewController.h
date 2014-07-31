//
//  RBUResultsViewController.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBURunHelper.h"

@interface RBUResultsViewController : UIViewController {
    IBOutlet UIScrollView *scroller;
}
- (IBAction)unwindToRVC:(UIStoryboardSegue *)segue;
    @property RBURunHelper* rh;
    @property NSMutableArray *maxtimes;
    @property NSMutableArray *mintimes;
    @property double totalticks;

    @property (weak, nonatomic) IBOutlet UILabel *maxSpeedLabel;
    @property (weak, nonatomic) IBOutlet UILabel *maxDistanceLabel;
    @property (weak, nonatomic) IBOutlet UILabel *totalDistanceLabel;
    @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
    @property (weak, nonatomic) IBOutlet UIButton *doneButton;



@end
