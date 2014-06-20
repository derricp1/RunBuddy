//
//  RBURunViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBURunViewController.h"

@interface RBURunViewController ()
    @property RBURunHelper *rh;

    @property int segmentticks;
    @property int currentsteps;
    @property int currentdistance;
    @property double motionlevel; //floor for motion

    @property NSMutableArray *xdata;
    @property NSMutableArray *ydata;
    @property NSMutableArray *zdata;

    @property CMMotionManager *motion;
    @property NSTimer *timer;
    @property NSTimer *motiontimer;

    //@property UIAccelerometer *accel;

@end

@implementation RBURunViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupstats];
    _motion = [[CMMotionManager alloc] init];
    [_motion startAccelerometerUpdates];
    
    //set up timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:(_segmentsize)
                                              target:self
                                            selector:@selector(timerFired:)
                                            userInfo:nil
                                             repeats:YES];
    
    _motiontimer = [NSTimer scheduledTimerWithTimeInterval:(0.1)
                                              target:self
                                            selector:@selector(motionTimerFired:)
                                            userInfo:nil
                                             repeats:YES];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 - (IBAction)goToRunView:(UIStoryboardSegue *)segue
{
    
}
*/

-(void)setupstats
{
    _segmentticks = 0;
    _currentdistance = 0;
    _currentsteps = 0;
    _motionlevel = 0.5;
    _xdata = [NSMutableArray new];
    _ydata = [NSMutableArray new];
    _zdata = [NSMutableArray new];
    _rh = [RBURunHelper new];
}

-(void)timerFired:(NSTimer*) t
{
    _segmentticks = 0;
    _currentdistance = 0;
    _currentsteps = 0;
    [_xdata removeAllObjects];
    [_ydata removeAllObjects];
    [_zdata removeAllObjects];
}

-(void)motionTimerFired:(NSTimer*) t
{
    CMAccelerometerData *data = _motion.accelerometerData;
    CMAcceleration accel = data.acceleration;
    
    _segmentticks += 1;
    [_xdata addObject:(id)[NSNumber numberWithDouble:accel.x]];
    [_ydata addObject:(id)[NSNumber numberWithDouble:accel.y]];
    [_zdata addObject:(id)[NSNumber numberWithDouble:accel.z]];
    
    if (_segmentticks > 1)
    {
        if (([_xdata[_segmentticks-2] doubleValue] < _motionlevel && [_xdata[_segmentticks-1] doubleValue] >= _motionlevel) ||([_xdata[_segmentticks-2] doubleValue] > -_motionlevel && [_xdata[_segmentticks-1] doubleValue] <= -_motionlevel))
        {
            //xcalculation
        }
        if (([_ydata[_segmentticks-2] doubleValue] < _motionlevel && [_ydata[_segmentticks-1] doubleValue] >= _motionlevel) ||([_ydata[_segmentticks-2] doubleValue] > -_motionlevel && [_ydata[_segmentticks-1] doubleValue] <= -_motionlevel))
        {
            //ycalculation
        }
        if (([_zdata[_segmentticks-2] doubleValue] < _motionlevel && [_zdata[_segmentticks-1] doubleValue] >= _motionlevel) ||([_zdata[_segmentticks-2] doubleValue] > -_motionlevel && [_zdata[_segmentticks-1] doubleValue] <= -_motionlevel))
        {
            //zcalculation
        }
    }
    
}

@end
