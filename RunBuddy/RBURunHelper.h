//
//  RBURunHelper.h
//  RunBuddy
//
//  Created by Patrick D'Errico on 6/17/14.
//  Copyright (c) 2014 derricp1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBURunHelper : NSObject
    @property int totalticks; //amount of total distance, so this math in the oncreate

    @property int totallaps; //do in lap button, also manage lap times
    @property (retain) NSMutableArray* laptimes;
    @property (retain) NSMutableArray* lapdistances;

    @property int totalsegments;
    @property (retain) NSMutableArray* fullsegmentmotiontotal;
    @property (retain) NSMutableArray* fullsegmentspeed;
@end
