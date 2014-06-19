//
//  RBUMainViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBUMainViewController.h"

@interface RBUMainViewController ()
    @property float delay;
    @property float segmentsize;

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
    _delay = floor(_delay);
    _segmentsize = floor(_segmentsize);
    RBURunViewController *dest = segue.destinationViewController;
    dest.segmentsize = (int)_segmentsize;
    dest.delay = (int)_delay;
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
    self.SegmentLabel.text = [NSString stringWithFormat:@"%f", self.SegmentSlider.value];
    _segmentsize = self.SegmentSlider.value;
}
- (IBAction)DelayChanged:(id)sender {
    self.DelayLabel.text = [NSString stringWithFormat:@"%f", self.DelaySlider.value];
    _delay = self.DelaySlider.value;
}

- (IBAction)unwindFromRun:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)unwindFromResults:(UIStoryboardSegue *)segue
{
    
}
 
@end
