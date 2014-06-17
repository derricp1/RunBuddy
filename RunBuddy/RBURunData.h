//
//  RBURunData.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/16/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBURunData : NSObject
    @property (retain) NSNumber* totalticks;
    @property (retain) NSNumber* totallaps;
    @property (retain) NSMutableArray* laptimes;

    @property (retain) NSNumber* totalsegments;
    @property (retain) NSMutableArray* fullsegmentmotiontotal;
    @property (retain) NSMutableArray* fullsegmentspeed;
@end
