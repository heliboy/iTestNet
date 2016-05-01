//----------------------------------------------------------->
//  webpage.h
//  iTest
//
//  Created by David Owens on 05/09/2015.
//  Copyright 2015 RadioPlanningTools All rights reserved.
//----------------------------------------------------------->
//#import <CoreLocation/CoreLocation.h>


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

@class webpage;

@interface webpage : NSObject

+(void)webpageHostname:(NSString*)hostName andResultCallback:(void(^)(NSString* latency))result;

@end
