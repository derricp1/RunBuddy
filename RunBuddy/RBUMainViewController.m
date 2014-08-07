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
    _maxspeed = 8;
    _minspeed = 3;
    
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
        dest.soundOn = _volumeSwitch.on;
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
    self.SegmentLabel.text = [[NSString stringWithFormat:@"%i", temp] stringByAppendingString:@" seconds"];
    
}
- (IBAction)DelayChanged:(id)sender {
    _delay = self.DelaySlider.value;
    int temp = floor(_delay);
    self.DelayLabel.text = [[NSString stringWithFormat:@"%i", temp] stringByAppendingString:@" seconds"];
}

- (IBAction)MaxSpeedChanged:(id)sender {
    _maxspeed = self.MaxSlider.value;
    if (_maxspeed < _minspeed) {
        self.MinSlider.value = _maxspeed;
        _minspeed = _maxspeed;
    }
    int temp = floor(_maxspeed);
    if (temp > 0) {
        self.MaxLabel.text = [[NSString stringWithFormat:@"%i", temp] stringByAppendingString:@" mph"];
    }
    else {
        self.MaxLabel.text = @"OFF";
    }
    int temps = floor(_minspeed);
    if (temps > 0) {
        self.MinLabel.text = [[NSString stringWithFormat:@"%i", temps] stringByAppendingString:@" mph"];
    }
    else {
        self.MinLabel.text = @"OFF";
    }
        
}

- (IBAction)MinSpeedChanged:(id)sender {
    if (self.MinSlider.value > _maxspeed) {
        self.MinSlider.value = _maxspeed;
    }
    _minspeed = self.MinSlider.value;
    int temp = floor(_minspeed);
    if (temp > 0) {
        self.MinLabel.text = [[NSString stringWithFormat:@"%i", temp] stringByAppendingString:@" mph"];
    }
    else {
        self.MinLabel.text = @"OFF";
    }
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

- (IBAction)unwindFromHelp:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)pushedDelay:(id)sender {
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Tooltips" message:@"Controls initial delay before timer starts" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [a show];
}

- (IBAction)pushedSegment:(id)sender {
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Tooltips" message:@"Controls multiples of time to make segments of" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [a show];
}

- (IBAction)pushedMax:(id)sender {
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Tooltips" message:@"Times above this speed will be recorded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [a show];
}

- (IBAction)pushedMin:(id)sender {
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Tooltips" message:@"Times below this speed will be recorded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [a show];
}


 
@end
