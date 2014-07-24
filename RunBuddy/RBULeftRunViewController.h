//
//  RBULeftRunViewController.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 7/23/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBURunHelper.h"
#import "RBUMainViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface RBULeftRunViewController : UIViewController {
    IBOutlet UIScrollView *scroller;
}
- (void)setupstats;
- (void)timerFired:(NSTimer*) t;
- (void)motionTimerFired:(NSTimer*) t;
@property int segmentsize;
@property int delay;
@property int maxspeed;
@property int minspeed;

@property (strong) RBURunHelper *rh;

@property int segmentticks;
@property int currentsteps;
@property double currentdistance;
@property double motionlevel; //floor for motion

@property double lapdistance;

@property int thislapticks;

@property NSMutableArray *xdata;
@property NSMutableArray *ydata;
@property NSMutableArray *zdata;

@property CMMotionManager *motion;
@property NSTimer *timer;
@property NSTimer *motiontimer;
@property NSTimer *speedtimer;

@property BOOL delayOver;
@property int delayticks; //seconds x 10
@property NSTimer *delaytimer;

@property BOOL isOverMax;
@property BOOL isUnderMin;
@property BOOL exceededMin;
@property float currspeed;
@property float prevspeed;
@property float thisspeedticks;
@property float currseconds;

@property float totalticks;

@property NSMutableArray *xmaxtimes;
@property NSMutableArray *xmintimes;

@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
