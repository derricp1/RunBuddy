//
//  RBURunViewController.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBURunHelper.h"
#import "RBUMainViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface RBURunViewController : UIViewController
    - (void)setupstats;
    - (void)timerFired:(NSTimer*) t;
    - (void)motionTimerFired:(NSTimer*) t;
    @property int segmentsize;
    @property int delay;
@end
