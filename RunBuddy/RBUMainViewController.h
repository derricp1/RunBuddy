//
//  RBUMainViewController.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBURunViewController.h"

@interface RBUMainViewController : UIViewController {
    IBOutlet UIScrollView *scroller;
}
    @property (weak, nonatomic) IBOutlet UISlider *SegmentSlider;
    @property (weak, nonatomic) IBOutlet UILabel *SegmentLabel;
    @property (weak, nonatomic) IBOutlet UISlider *DelaySlider;
    @property (weak, nonatomic) IBOutlet UILabel *DelayLabel;

- (IBAction)unwindFromRun:(UIStoryboardSegue *)segue;
- (IBAction)unwindFromResults:(UIStoryboardSegue *)segue;
@end
