//----------------------------------------------------------->
//  iPlanB.h
//  iPlanB
//
//  Created by David Owens on 08/08/2012.
//  Copyright 2013 RadioPlanningTools All rights reserved.
//----------------------------------------------------------->
///#import <CoreLocation/CoreLocation.h>
//#import "SimplePing.h"
//#import <Foundation/Foundation.h>
@import Foundation;

#pragma mark ---> ping structure start <---
//#define ITEST_USERID       @"userid"
//#define ITEST_TIMESTAMP    @"dataset_timestamp"
//#define ITEST_IMEI         @"imei"
//#define ITEST_SPEED        @"speed"
//#define ITEST_SOFTWARE_VR  @"swvr"
//#define ITEST_RSSI         @"rssi"
//#define ITEST_LATITUDE     @"lat"
//#define ITEST_LONGITUDE    @"lon"

#pragma mark ---> Agent report structure finish <---

@class StopWatch;

@interface StopWatch : NSObject{
    uint64_t _start;
    uint64_t _stop;
    uint64_t _elapsed;
}

-(void) Start;
-(void) Stop;
-(void) StopWithContext:(NSString*) context;
-(double) seconds;
-(NSString*) description;
+(StopWatch*) stopWatch;
-(StopWatch*) init;
@end
