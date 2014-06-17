//
//  RBURunViewController.m
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/16/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import "RBURunViewController.h"
#import "RBURunData.h"

@interface RBURunViewController ()

    @property RBURunData *rd;
    @property NSNumber *segmentticks;
    @property NSNumber *currentsteps;
    @property NSNumber *currentdistance;
    @property NSMutableArray *xdata;
    @property NSMutableArray *ydata;
    @property NSMutableArray *zdata;

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

- (IBAction)unwindToMain:(UIStoryboardSegue *)segue
{
    
}

@end
