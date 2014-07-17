//
//  RBURunViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBURunViewController.h"
#import "RBUResultsViewController.h"

@interface RBURunViewController ()
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

    @property NSMutableArray *xmaxtimes;
    @property NSMutableArray *xmintimes;

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
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320,568)];
    
    [super viewDidLoad];
    [self setupstats];
    _motion = [[CMMotionManager alloc] init];
    [_motion startAccelerometerUpdates];
    
    _delayticks = _delay*10;
    
    _isOverMax = NO;
    _isUnderMin = NO;
    _exceededMin = NO;
    
    //set up timers

    
    _motiontimer = [NSTimer scheduledTimerWithTimeInterval:(0.1)
                                              target:self
                                            selector:@selector(motionTimerFired:)
                                            userInfo:nil
                                             repeats:YES];
    
    _delaytimer = [NSTimer scheduledTimerWithTimeInterval:(0.1)
                                                    target:self
                                                  selector:@selector(delayTimerFired:)
                                                  userInfo:nil
                                                   repeats:YES];
    
    _speedtimer = [NSTimer scheduledTimerWithTimeInterval:(1)
                                                   target:self
                                                 selector:@selector(speedTimerFired:)
                                                 userInfo:nil
                                                  repeats:YES];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"GoToResVC"])
    {
        UINavigationController *nav = (UINavigationController*) segue.destinationViewController;
        RBUResultsViewController *dest = (RBUResultsViewController*) nav.topViewController;
        if (_delayOver) { //end the current lap
            _rh.totallaps += 1;
            [_rh.laptimes addObject:(id)[NSNumber numberWithInt:(_thislapticks)]];
            [_rh.lapdistances addObject:(id)[NSNumber numberWithInt:(_lapdistance)]];
            _thislapticks = 0;
        }
        
        dest.rh = _rh;
        [_motiontimer invalidate];
        [_timer invalidate];
    }
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
    _thislapticks = 0;
    _motionlevel = 0.5;
    _xdata = [[NSMutableArray alloc] init];
    _ydata = [[NSMutableArray alloc] init];
    _zdata = [[NSMutableArray alloc] init];
    _rh = [[RBURunHelper alloc] init];
    
    _rh.fullsegmentmotiontotal = [[NSMutableArray alloc] init];
    _rh.fullsegmentspeed = [[NSMutableArray alloc] init];
    _rh.lapdistances = [[NSMutableArray alloc] init];
    _rh.laptimes = [[NSMutableArray alloc] init];
    
    _currspeed = 0;
    _prevspeed = 0;
    _thisspeedticks = 0;

}

- (IBAction)pushedLap:(id)sender {
    
    if (_delayOver) {
        _rh.totallaps += 1;
        [_rh.laptimes addObject:(id)[NSNumber numberWithInt:(_thislapticks)]];
        [_rh.lapdistances addObject:(id)[NSNumber numberWithInt:(_lapdistance)]]; //need lap distances at some point
        _thislapticks = 0;
        _lapdistance = 0;
    }
}

-(void)delayTimerFired:(NSTimer*) t
{
    //dec delayticks, if 0, bool is true, turn off timer (you should turn off all timers in segue, then if-wrap the other timers
    _delayticks -= 1;
    if (_delayticks <= 0) {
        [_delaytimer invalidate];
        _delayOver = YES;
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:(_segmentsize)
                                                  target:self
                                                selector:@selector(timerFired:)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

-(void)timerFired:(NSTimer*) t
{
    [self segmentUpdate];
}

-(void)speedTimerFired:(NSTimer*) t
{
    if (_delayOver) {
        _currseconds += 1;
        if (_currspeed > 0) {
            _prevspeed = _currspeed;
        }
        
        _currspeed = _thisspeedticks*3600/5280;
        _thisspeedticks = 0;
        
        if (_exceededMin == NO && _currspeed > _minspeed) {
            _exceededMin = YES;
        }
        
        if (_exceededMin == YES && _prevspeed >= _minspeed && _currspeed < _minspeed) {
            [_xmintimes addObject:(id)[NSNumber numberWithInt:(_currseconds)]];
        }
        if (_prevspeed <= _maxspeed && _currspeed > _maxspeed) {
            [_xmaxtimes addObject:(id)[NSNumber numberWithInt:(_currseconds)]];
        }
        
    }
}

-(void)segmentUpdate {
    
    [_xdata removeAllObjects];
    [_ydata removeAllObjects];
    [_zdata removeAllObjects];
    
    _rh.totalsegments += 1;
    [_rh.fullsegmentmotiontotal addObject:(id)[NSNumber numberWithDouble:(_currentdistance)]];
    
    
    [_rh.fullsegmentspeed addObject:(id)[NSNumber numberWithDouble:((_currentdistance*3600)/(_segmentsize*5280))]]; //feet per second -> mph
    
    _segmentticks = 0;
    _currentdistance = 0;
    _currentsteps = 0;
    
}

-(void)motionTimerFired:(NSTimer*) t
{
    if (_delayOver) {
        CMAccelerometerData *data = _motion.accelerometerData;
        CMAcceleration accel = data.acceleration;
    
        _segmentticks += 1;
        [_xdata addObject:(id)[NSNumber numberWithDouble:accel.x]];
        [_ydata addObject:(id)[NSNumber numberWithDouble:accel.y]];
        [_zdata addObject:(id)[NSNumber numberWithDouble:accel.z]];
        
        _thislapticks += 1;
    
        if (_segmentticks > 1)
        {
            /*
            if (([_xdata[_segmentticks-2] doubleValue] < _motionlevel && [_xdata[_segmentticks-1] doubleValue] >= _motionlevel) ||([_xdata[_segmentticks-2] doubleValue] > -_motionlevel && [_xdata[_segmentticks-1] doubleValue] <= -_motionlevel))
            {
                //xcalculation
            }
            if (([_ydata[_segmentticks-2] doubleValue] < _motionlevel && [_ydata[_segmentticks-1] doubleValue] >= _motionlevel) ||([_ydata[_segmentticks-2] doubleValue] > -_motionlevel && [_ydata[_segmentticks-1] doubleValue] <= -_motionlevel))
            {
                //ycalculation
            }
             */
            if (([_zdata[_segmentticks-2] doubleValue] < _motionlevel && [_zdata[_segmentticks-1] doubleValue] >= _motionlevel) ||  ([_zdata[_segmentticks-2] doubleValue] > -_motionlevel && [_zdata[_segmentticks-1] doubleValue] <= -_motionlevel))
            {
                //zcalculation, needs to be tested though
                if ([_zdata[_segmentticks-1] doubleValue] > 0) {
                    float adder = (3 + sqrt([_zdata[_segmentticks-1] doubleValue]));
                    _currentdistance += adder;
                    _lapdistance += adder;
                    _thisspeedticks += adder;
                }
                else if ([_zdata[_segmentticks-1] doubleValue] < 0) {
                    float adder = (3 + sqrt([_zdata[_segmentticks-1] doubleValue]));
                    _currentdistance += adder;
                    _lapdistance += adder;
                    _thisspeedticks += adder;
                }
            
            }
        }
    }
    
}

@end
