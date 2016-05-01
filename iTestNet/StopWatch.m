//----------------------------------------------------------->
//  iPlanB.h
//  iPlanB
//
//  Created by David Owens on 21/06/2012.
//  Copyright 2012 RemoveBeforeFlight. All rights reserved.
//----------------------------------------------------------->

//
//StopWatch* stopWatch = [StopWatch stopWatch];
//[stopWatch Start];

//... do stuff

//[stopWatch StopWithContext:[NSString stringWithFormat:@"Created %d Records",[records count]]];
//}


#import "StopWatch.h"
#include <mach/mach_time.h>

@implementation StopWatch

-(void) Start{
    _stop = 0;
    _elapsed = 0;
    _start = mach_absolute_time();
}
-(void) Stop{
    _stop = mach_absolute_time();
    if(_stop > _start)
    {
        _elapsed = _stop - _start;
    }
    else
    {
        _elapsed = 0;
    }
    _start = mach_absolute_time();
}

-(void) StopWithContext:(NSString*) context{
    _stop = mach_absolute_time();
    if(_stop > _start)
    {
        _elapsed = _stop - _start;
    }
    else
    {
        _elapsed = 0;
    }
    NSLog([NSString stringWithFormat:@"[%@] Stopped at %f",context,[self seconds]]);
    
    _start = mach_absolute_time();
}


-(double) seconds{
    if(_elapsed > 0)
    {
        uint64_t elapsedTimeNano = 0;
        
        mach_timebase_info_data_t timeBaseInfo;
        mach_timebase_info(&timeBaseInfo);
        elapsedTimeNano = _elapsed * timeBaseInfo.numer / timeBaseInfo.denom;
        double elapsedSeconds = elapsedTimeNano * 1.0E-9;
        return elapsedSeconds;
    }
    return 0.0;
}
-(NSString*) description{
    return [NSString stringWithFormat:@"%f secs.",[self seconds]];
}
+(StopWatch*) stopWatch{
   // StopWatch* obj = [[[StopWatch alloc] init] autorelease];
    return obj;
}
-(StopWatch*) init{
    [self   init];
    return self;
}

@end