//
//  RBUMainViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBUMainViewController.h"
#import "RBURunViewController.h"

@interface RBUMainViewController ()
    @property float delay;
    @property float segmentsize;
    @property float maxspeed;
    @property float minspeed;

@end

@implementation RBUMainViewController

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
    
    _delay = 10;
    _segmentsize = 20;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToRunVC"])
    {
        UINavigationController *nav = (UINavigationController*) segue.destinationViewController;
        RBURunViewController *dest = (RBURunViewController*) nav.topViewController;
        
        _delay = floor(_delay);
        _segmentsize = floor(_segmentsize);
        dest.segmentsize = (int)_segmentsize;
        dest.delay = (int)_delay;
        dest.maxspeed = (int)_maxspeed;
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
- (IBAction)SegmentTimeChanged:(id)sender {
    _segmentsize = self.SegmentSlider.value;
    int temp = floor(_segmentsize);
    self.SegmentLabel.text = [NSString stringWithFormat:@"%i", temp];
    
}
- (IBAction)DelayChanged:(id)sender {
    _delay = self.DelaySlider.value;
    int temp = floor(_delay);
    self.DelayLabel.text = [NSString stringWithFormat:@"%i", temp];
}

- (IBAction)MaxSpeedChanged:(id)sender {
    _maxspeed = self.MaxSlider.value;
    int temp = floor(_maxspeed);
    self.MaxLabel.text = [NSString stringWithFormat:@"%i", temp];
}

- (IBAction)MinSpeedChanged:(id)sender {
    _minspeed = self.MinSlider.value;
    int temp = floor(_minspeed);
    self.MinLabel.text = [NSString stringWithFormat:@"%i", temp];
}



- (IBAction)unwindFromRun:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)unwindFromResults:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)unwindFromMoreResults:(UIStoryboardSegue *)segue
{
    
}
 
@end
