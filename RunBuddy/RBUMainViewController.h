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

    @property (weak, nonatomic) IBOutlet UISlider *MaxSlider;
    @property (weak, nonatomic) IBOutlet UILabel *MaxLabel;

    @property (weak, nonatomic) IBOutlet UISlider *MinSlider;
    @property (weak, nonatomic) IBOutlet UILabel *MinLabel;

- (IBAction)unwindFromRun:(UIStoryboardSegue *)segue;
- (IBAction)unwindFromResults:(UIStoryboardSegue *)segue;

@property (weak, nonatomic) IBOutlet UISwitch *volumeSwitch;



@end
