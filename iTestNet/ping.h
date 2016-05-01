//----------------------------------------------------------->
//  iPlanB.h
//  iPlanB
//
//  Created by David Owens on 08/08/2012.
//  Copyright 2013 RadioPlanningTools All rights reserved.
//----------------------------------------------------------->
//#import <CoreLocation/CoreLocation.h>
#import "SimplePing.h"

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

@class ping;

@interface SimplePingClient : NSObject<SimplePingDelegate>

+(void)pingHostname:(NSString*)hostName andResultCallback:(void(^)(NSString* latency))result;

@end
