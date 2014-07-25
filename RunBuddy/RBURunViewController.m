//
//  RBURunViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBURunViewController.h"
#import "RBUResultsViewController.h"
#import "RBULeftRunViewController.h"
#import "RBURightRunViewController.h"

@interface RBURunViewController ()

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

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        _willRot = 1;
    }
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        _willRot = 2;
    }
}

- (void)landscapeRotate
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    int o = [self getOrientation];
    
    if (o == 1) {
        
        CGRect f = [_timeLabel frame];
        int sizex = f.size.width;
        int sizey = f.size.height;
        f.origin.x = ((int) height/2 - sizex/2);
        f.origin.y = (int) width * 0.1;
        [_timeLabel setFrame:f];
        
        f = [_lapButton frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) 0;
        f.origin.y = (int) width * 0.4;
        [_lapButton setFrame:f];
    
        f = [_finishButton frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) height - sizex;
        f.origin.y = (int) width * 0.4;
        [_finishButton setFrame:f];
    }
    else {
        
        CGRect f = [_timeLabel frame];
        int sizex = f.size.width;
        int sizey = f.size.height;
        f.origin.x = ((int) height/2 - sizex/2);
        f.origin.y = (int) width * 0.1;
        [_timeLabel setFrame:f];
        
        f = [_lapButton frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) 0;
        f.origin.y = (int) width * 0.4;
        [_lapButton setFrame:f];
        
        f = [_finishButton frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) height - sizex;
        f.origin.y = (int) width * 0.4;
        [_finishButton setFrame:f];
    }
}

- (void)portraitRotate
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;

    CGRect f = [_timeLabel frame];
    int sizex = f.size.width;
    int sizey = f.size.height;
    f.origin.x = (int) width/2 - sizex/2;
    f.origin.y = (int) height/6;
    [_timeLabel setFrame:f];
    
    f = [_lapButton frame];
    sizex = f.size.width;
    sizey = f.size.height;
    f.origin.x = (int) width/2 - sizex/2;
    f.origin.y = (int) height * 0.4;
    [_lapButton setFrame:f];
    
    f = [_finishButton frame];
    sizex = f.size.width;
    sizey = f.size.height;
    f.origin.x = (int) width/2 - sizex/2;
    f.origin.y = (int) height * 0.7;
    [_finishButton setFrame:f];
}

- (int)getOrientation
{
    UIInterfaceOrientation u = [UIApplication sharedApplication].statusBarOrientation;
    if (u == UIInterfaceOrientationPortrait || u == UIInterfaceOrientationPortraitUpsideDown)
        return 0;
    else if (u == UIInterfaceOrientationLandscapeLeft)
        return 1;
    else
        return 2;
}


- (void)viewDidLoad
{
    [scroller setScrollEnabled:NO];
    //[scroller setContentSize:CGSizeMake(320,568)];
    
    scroller.contentSize = CGSizeMake(scroller.contentSize.width,scroller.frame.size.height);
    
    [super viewDidLoad];
    [self setupstats];
    _motion = [[CMMotionManager alloc] init];
    [_motion startAccelerometerUpdates];
    
    if ([self getOrientation] == 0)
        _willRot = 2;
    else
        _willRot = 1;
    
    //CGRect f = [_timeLabel frame];
    //f.origin.x += 100;
    //[_timeLabel setFrame:f];
    
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
            dest.maxtimes = _xmaxtimes;
            dest.mintimes = _xmintimes;
            dest.totalticks = _totalticks;
            
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
    _totalticks = 0;
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

- (IBAction)pushedFinish:(id)sender {
    if (_delayOver) {
        [self performSegueWithIdentifier:@"GoToResVC" sender:sender];
    }
    else {
        [self performSegueWithIdentifier:@"GoToMain" sender:sender];
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
        
        if (_exceededMin == NO && _currspeed > _minspeed && _minspeed > 0) {
            _exceededMin = YES;
        }
        
        if (_exceededMin == YES && _prevspeed >= _minspeed && _currspeed < _minspeed && _minspeed > 0) {
            [_xmintimes addObject:(id)[NSNumber numberWithInt:(_currseconds)]];
        }
        if (_prevspeed <= _maxspeed && _currspeed > _maxspeed && _maxspeed > 0) {
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
    //since this always runs, it's fine to use here
    _finishButton.enabled = _delayOver;
    
    //we can also handle rotation
    if (_willRot == 1) {
        [self landscapeRotate];
        _willRot = 0;
    }
    if (_willRot == 2) {
        [self portraitRotate];
        _willRot = 0;
    }
    
    if (_delayOver) {
        
        _totalticks += 1;
        int lminutes = floor(_totalticks/600);
        NSString* mstring = [NSString stringWithFormat:@"%.2i", lminutes];
        int lseconds = floor((_totalticks-600*lminutes)/10);
        NSString* sstring = [NSString stringWithFormat:@"%.2i", lseconds];
        int lmseconds = floor((_totalticks-600*lminutes-10*lseconds)*6);
        NSString* msstring = [NSString stringWithFormat:@"%.2i", lmseconds];
        NSString* time1 = [[sstring stringByAppendingString:@":"] stringByAppendingString:msstring];
        NSString* time = [[mstring stringByAppendingString:@":"] stringByAppendingString:time1];
        _timeLabel.text = time;
        
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
