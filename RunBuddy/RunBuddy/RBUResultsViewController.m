//
//  RBUResultsViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBUResultsViewController.h"

@interface RBUResultsViewController ()
    @property int maxbar;
    @property NSMutableArray* levels;
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
    
    _maxbar = 200;
    
    /*CGRect f1 = _Bar1.frame;
    f1.size.height = 100;
    f1.origin.y = f1.origin.y + (_maxbar - f1.size.height);
    _Bar1.frame = f1;*/
    
    /*CGRect f2 = _Bar2.frame;
    CGRect f3 = _Bar3.frame;
    CGRect f4 = _Bar4.frame;
    CGRect f5 = _Bar5.frame;
    CGRect f6 = _Bar6.frame;
    CGRect f7 = _Bar7.frame;
    CGRect f8 = _Bar8.frame;
    CGRect f9 = _Bar9.frame;
    CGRect f10 = _Bar1.frame;*/
    
    // Do any additional setup after loading the view.
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
