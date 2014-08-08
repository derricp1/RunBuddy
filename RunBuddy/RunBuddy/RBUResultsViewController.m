//
//  RBUResultsViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBUResultsViewController.h"
#import "RBUTableViewController.h"

@interface RBUResultsViewController ()
    @property int maxbar;
    @property NSMutableArray* levels;
    @property double maxsegspeed;
    @property double totaldistance;
    @property double maxsegdistance;
    @property NSTimer* timer;
    @property int adjustscreen;
    @property NSMutableArray* allsegs;
    @property NSMutableArray* allviews;
    @property int numviews;
    @property CGFloat scwidth;
    @property CGFloat scheight;
    @property int offset;
@end

@implementation RBUResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    _numviews = 0;
    _offset = 60;
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(width,height+_offset)];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:(0.1)
                                              target:self
                                            selector:@selector(timerFired:)
                                            userInfo:nil
                                             repeats:YES];
    
    if ([self getOrientation] == 0)
        _adjustscreen = 2;
    else
        _adjustscreen = 1;
    
    //_adjustscreen = 0;
    
    [super viewDidLoad];
    
    [self findmaxsegspeed];
    [self finddistancedata];
    
    //[self calcbars];
    [self setupmorelevels];

    
    _maxbar = 200;
    
    int lminutes = floor(_totalticks/600);
    NSString* mstring = [NSString stringWithFormat:@"%.2i", lminutes];
    int lseconds = floor((_totalticks-600*lminutes)/10);
    NSString* sstring = [NSString stringWithFormat:@"%.2i", lseconds];
    int lmseconds = floor((_totalticks-600*lminutes-10*lseconds)*6);
    NSString* msstring = [NSString stringWithFormat:@"%.2i", lmseconds];
    NSString* time1 = [[sstring stringByAppendingString:@":"] stringByAppendingString:msstring];
    NSString* time = [[mstring stringByAppendingString:@":"] stringByAppendingString:time1];
    _timeLabel.text = time;
    //_timeLabel.text = [NSString stringWithFormat:@"%i", _rh.totalsegments];
    
    // Do any additional setup after loading the view.
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        _adjustscreen = 1;
    }
    else
        _adjustscreen = 2;
}

-(void)timerFired:(NSTimer*) t
{
    if (_adjustscreen > 0) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat width = screenRect.size.width;
        CGFloat height = screenRect.size.height;
        
        for (int i=0;i<_numviews;i++) {
            UIView* r = [scroller viewWithTag:(i+1000)];
            [r removeFromSuperview];
        }
        _numviews = 0;
        
        if (_adjustscreen == 1) {
            _scwidth = height;
            _scheight = width;
        }
        else {
            _scwidth = width;
            _scheight = height;
        }
        
        [scroller setScrollEnabled:YES];
        [scroller setContentSize:CGSizeMake(width,height+_offset)];
        
        [self orientscreen];
        [self setupmorelevels];
        _adjustscreen = 0;
    }
}

- (void)finddistancedata
{
    _maxsegdistance = 0;
    for (int i=0; i<_rh.totalsegments; i++) {
        _totaldistance += [_rh.fullsegmentmotiontotal[i] doubleValue];
        if ([_rh.fullsegmentmotiontotal[i] doubleValue] > _maxsegdistance) {
            _maxsegdistance = [_rh.fullsegmentmotiontotal[i] doubleValue];
        }
    }
    _maxsegdistance = _maxsegdistance/5280;
    _totaldistance = _totaldistance/5280;
    
    NSString* tstring = [NSString stringWithFormat:@"%.02f", _maxsegdistance];
    [_maxDistanceLabel setText:[tstring stringByAppendingString:[NSString stringWithUTF8String:" miles"]]];
    
    NSString* ttstring = [NSString stringWithFormat:@"%.02f", _totaldistance];
    [_totalDistanceLabel setText:[ttstring stringByAppendingString:[NSString stringWithUTF8String:" miles"]]];
}

- (void)findmaxsegspeed
{
    double curmax = 0;
    for (int i=0; i<_rh.totalsegments; i++) {
        if ([_rh.fullsegmentspeed[i] doubleValue] > curmax) {
            curmax = [_rh.fullsegmentspeed[i] doubleValue];
        }
    }
    _maxsegspeed = ((int)(curmax * 10)) / 10;
    
    NSString* tstring = [NSString stringWithFormat:@"%.02f", _maxsegspeed];
    [_maxSpeedLabel setText:[tstring stringByAppendingString:[NSString stringWithUTF8String:" mph"]]];
}

- (void)orientscreen
{
        CGRect f = [_maxSpeedWords frame];
        int sizex = f.size.width;
        int sizey = f.size.height;
        f.origin.x = (int) _scwidth * 0.1;
        f.origin.y = (int) _scheight * 0.05;
        [_maxSpeedWords setFrame:f];
        
        f = [_maxDistanceWords frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) _scwidth * 0.1;
        f.origin.y = (int) _scheight * 0.15;
        [_maxDistanceWords setFrame:f];
        
        f = [_totalDistanceWords frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) _scwidth * 0.1;
        f.origin.y = (int) _scheight * 0.25;
        [_totalDistanceWords setFrame:f];
        
        f = [_timeWords frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) _scwidth * 0.1;
        f.origin.y = (int) _scheight * 0.35;
        [_timeWords setFrame:f];
        
        f = [_maxSpeedLabel frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) _scwidth * 0.7;
        f.origin.y = (int) _scheight * 0.05;
        [_maxSpeedLabel setFrame:f];
        
        f = [_maxDistanceLabel frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) _scwidth * 0.7;
        f.origin.y = (int) _scheight * 0.15;
        [_maxDistanceLabel setFrame:f];
        
        f = [_totalDistanceLabel frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) _scwidth * 0.7;
        f.origin.y = (int) _scheight * 0.25;
        [_totalDistanceLabel setFrame:f];
        
        f = [_timeLabel frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) _scwidth * 0.7;
        f.origin.y = (int) _scheight * 0.35;
        [_timeLabel setFrame:f];
    
        f = [_doneButton frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) _scwidth/2 -sizex/2;
        if ([self getOrientation] == 0)
            f.origin.y = (int) _scheight * 0.4;
        else
            f.origin.y = (int) _scheight * 0.5;
        [_doneButton setFrame:f];
    
        f = [_graphWords frame];
        sizex = f.size.width;
        sizey = f.size.height;
        f.origin.x = (int) _scwidth/2 -sizex/2;
        if ([self getOrientation] == 0)
            f.origin.y = (int) _scheight * 0.6;
        else
            f.origin.y = (int) _scheight * 0.7;
        [_graphWords setFrame:f];
    
}

- (void)setupmorelevels
{

    float barsize = _scwidth/_rh.totalsegments;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    for (int i=0; i<_rh.totalsegments; i++) {
        if (i < _rh.totalsegments) {
            float q = 0;
            if (_maxsegspeed == 0) {
                q = 200 - 10*i;
            }
            else {
                q = 200 * [_rh.fullsegmentspeed[i] doubleValue]/_maxsegspeed;
            }
            [_levels addObject:(id)[NSNumber numberWithInt:floor(200*([_rh.fullsegmentspeed[i] doubleValue]/_maxsegspeed))]];
            UIImageView* t = [[UIImageView alloc] initWithFrame:CGRectMake((barsize*i),(height+_offset-q),barsize,q)];
            t.backgroundColor = [UIColor redColor];
            t.tag = _numviews + 1000;
            _numviews += 1;
            [scroller addSubview: t];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calcbars
{
    double maxinseg = 0;
    for (int i=0; i<_rh.totalsegments; i++) {
        if ([_rh.fullsegmentspeed[i] floatValue] > maxinseg) {
            maxinseg = [_rh.fullsegmentspeed[i] doubleValue];
        }
    }
    if (_rh.totalsegments <= 10) {
        for (int i=0; i<10; i++) {
            if (i < _rh.totalsegments) {
                [_levels addObject:(id)[NSNumber numberWithInt:floor(200*([_rh.fullsegmentspeed[i] doubleValue]/maxinseg))]];
            }
            else {
                [_levels addObject:(id)[NSNumber numberWithInt:0]];
            }
        }
    }
    else {
        double currentportion = 0; //up to how many segments
        double portionsize = (_rh.totalsegments/10);
        for (int i=0; i<10; i++) {
            //currentportion += portionsize;
            int elements = 1 + (floor(currentportion + portionsize) - floor(currentportion));
            double val = 0; //calculated here
            double ps = portionsize; //increments the value
            for (int j=0; j<elements; j++) {
                if (ceil(ps) != ps) {
                    if (ceil(ps) < currentportion + portionsize) {
                        int q = floor(ps);
                        val += (ceil(ps) - ps) * floor(200*([_rh.fullsegmentspeed[q] doubleValue]/maxinseg));
                        ps = ceil(ps);
                    } //min((currentportion + portionsize), ceil(ps))
                    else {
                        int q = floor(ps);
                        val += (currentportion + portionsize - ps) * floor(200*([_rh.fullsegmentspeed[q] doubleValue]/maxinseg));
                    }
                }
                else {
                    if (ps + 1 < currentportion + portionsize) {
                        int q = floor(ps);
                        val += floor(200*([_rh.fullsegmentspeed[q] doubleValue]/maxinseg));
                        ps += 1;
                    } //min((currentportion + portionsize), ceil(ps))
                    else {
                        int q = ps;
                        val += floor(200*([_rh.fullsegmentspeed[q] doubleValue]/maxinseg));
                    }
                }
            }
            [_levels addObject:(id)[NSNumber numberWithInt:floor(200*(val/maxinseg))]];
            currentportion += portionsize;
        }
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //if ([segue.destinationViewController isKindOfClass:[RBUTableViewController class]])
    if ([segue.identifier isEqualToString:@"GoToTVC"])
    {
        UINavigationController *nav = (UINavigationController*) segue.destinationViewController;
        RBUResultsViewController *dest = (RBUResultsViewController*) nav.topViewController;
        dest.rh = _rh;
        dest.maxtimes = _maxtimes;
        dest.mintimes = _mintimes;
    }
}


- (IBAction)unwindToRVC:(UIStoryboardSegue *)segue
{
    
}

@end
