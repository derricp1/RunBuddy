//
//  RBUHelpViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 7/28/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBUHelpViewController.h"

@interface RBUHelpViewController ()

@end

@implementation RBUHelpViewController

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
    // Do any additional setup after loading the view.
    [self adjustView];
}

- (void) adjustView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    CGRect r = _helpText.frame;
    r.size.height = height;
    r.size.width = width;
    
    _helpText.text = [NSString stringWithUTF8String:"Delay: Time before timer starts.\n\nSegment Size: Size of times to get data over.\n\nMax Speed Tracking: Speed to record time if surpassed.\n\nMin Speed Tracking: Speed to record time if under."];
    
    _helpText.editable = NO;
    
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

@end
