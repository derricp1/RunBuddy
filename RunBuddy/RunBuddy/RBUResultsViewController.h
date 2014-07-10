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

    @property (weak, nonatomic) IBOutlet UIImageView *Bar1;
    @property (weak, nonatomic) IBOutlet UIImageView *Bar2;
    @property (weak, nonatomic) IBOutlet UIImageView *Bar3;
    @property (weak, nonatomic) IBOutlet UIImageView *Bar4;
    @property (weak, nonatomic) IBOutlet UIImageView *Bar5;
    @property (weak, nonatomic) IBOutlet UIImageView *Bar6;
    @property (weak, nonatomic) IBOutlet UIImageView *Bar7;
    @property (weak, nonatomic) IBOutlet UIImageView *Bar8;
    @property (weak, nonatomic) IBOutlet UIImageView *Bar9;
    @property (weak, nonatomic) IBOutlet UIImageView *Bar10;

    @property (weak, nonatomic) IBOutlet UILabel *maxSpeedLabel;
    @property (weak, nonatomic) IBOutlet UILabel *maxDistanceLabel;
    @property (weak, nonatomic) IBOutlet UILabel *totalDistanceLabel;



@end
