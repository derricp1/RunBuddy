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

- (void)viewDidLoad
{
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320,568)];
    
    [super viewDidLoad];
    
    [self setuplevels];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:(0.1)
                                                   target:self
                                                 selector:@selector(timerFired:)
                                                 userInfo:nil
                                                  repeats:NO];
    
    _maxbar = 200;
    
    // Do any additional setup after loading the view.
}

-(void)timerFired:(NSTimer*) timer
{
    [self findmaxsegspeed];
    [self finddistancedata];
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
    
    NSString* tstring = [NSString stringWithFormat:@"%.2f", _maxsegdistance];
    [_maxDistanceLabel setText:[tstring stringByAppendingString:[NSString stringWithUTF8String:" mph"]]];
    //self.maxDistanceLabel.text = [[NSString stringWithFormat:@"%f", _maxsegdistance] stringByAppendingString:[NSString stringWithUTF8String:" mph"]];
    
    NSString* ttstring = [NSString stringWithFormat:@"%.2f", _totaldistance];
    [_maxSpeedLabel setText:[ttstring stringByAppendingString:[NSString stringWithUTF8String:" mph"]]];
    //self.totalDistanceLabel.text = [[NSString stringWithFormat:@"%f", _totaldistance] stringByAppendingString:[NSString stringWithUTF8String:" mph"]];
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
    NSString* tstring = [NSString stringWithFormat:@"%.2f", _maxsegspeed];
    [_maxSpeedLabel setText:[tstring stringByAppendingString:[NSString stringWithUTF8String:" mph"]]];
}

- (void)setuplevels
{
    CGRect f1 = _Bar1.frame;
    f1.size.height = [_levels[0] intValue];
    f1.origin.y = f1.origin.y + (_maxbar - f1.size.height);
    _Bar1.frame = f1;
    
    CGRect f2 = _Bar2.frame;
    f2.size.height = [_levels[1] intValue];
    f2.origin.y = f2.origin.y + (_maxbar - f2.size.height);
    _Bar2.frame = f2;
    
    CGRect f3 = _Bar3.frame;
    f3.size.height = [_levels[2] intValue];
    f3.origin.y = f3.origin.y + (_maxbar - f3.size.height);
    _Bar3.frame = f3;
    
    CGRect f4 = _Bar4.frame;
    f4.size.height = [_levels[3] intValue];
    f4.origin.y = f4.origin.y + (_maxbar - f4.size.height);
    _Bar4.frame = f4;
    
    CGRect f5 = _Bar5.frame;
    f5.size.height = [_levels[4] intValue];
    f5.origin.y = f5.origin.y + (_maxbar - f5.size.height);
    _Bar5.frame = f5;
    
    CGRect f6 = _Bar6.frame;
    f6.size.height = [_levels[5] intValue];
    f6.origin.y = f6.origin.y + (_maxbar - f6.size.height);
    _Bar6.frame = f6;
    
    CGRect f7 = _Bar7.frame;
    f7.size.height = [_levels[6] intValue];
    f7.origin.y = f7.origin.y + (_maxbar - f7.size.height);
    _Bar7.frame = f7;
    
    CGRect f8 = _Bar8.frame;
    f8.size.height = [_levels[7] intValue];
    f8.origin.y = f8.origin.y + (_maxbar - f8.size.height);
    _Bar8.frame = f8;
    
    CGRect f9 = _Bar9.frame;
    f9.size.height = [_levels[8] intValue];
    f9.origin.y = f9.origin.y + (_maxbar - f9.size.height);
    _Bar9.frame = f9;
    
    CGRect f10 = _Bar10.frame;
    f10.size.height = [_levels[9] intValue];
    f10.origin.y = f10.origin.y + (_maxbar - f10.size.height);
    _Bar10.frame = f10;
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
    if ([segue.destinationViewController isKindOfClass:[RBUTableViewController class]])
    {
        RBUResultsViewController *dest = segue.destinationViewController;
        dest.rh = _rh;
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

@end
