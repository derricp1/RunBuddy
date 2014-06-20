//
//  RBURunHelper.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBURunHelper : NSObject
    @property int totalticks; //motion data
    @property int totallaps;
    @property (retain) NSMutableArray* laptimes;

    @property int totalsegments;
    @property (retain) NSMutableArray* fullsegmentmotiontotal;
    @property (retain) NSMutableArray* fullsegmentspeed;
@end
