//----------------------------------------------------------->
//  iPlanB.h
//  iPlanB
//
//  Created by David Owens on 08/08/2015.
//  Copyright 2013 RadioPlanningTools All rights reserved.
//----------------------------------------------------------->
#import <CoreLocation/CoreLocation.h>


#pragma mark ---> Agent report structure start <---
#define ITEST_USERID       @"userid"
#define ITEST_TIMESTAMP    @"dataset_timestamp"
#define ITEST_IMEI         @"MTP04"
#define ITEST_SPEED        @"speed"
#define ITEST_SOFTWARE_VR  @"swvr"
#define ITEST_RSSI         @"rssi"
#define ITEST_LATITUDE     @"lat"
#define ITEST_LONGITUDE    @"lon"

#pragma mark ---> Agent report structure finish <---

@class iTest;

@interface iTest : NSObject
//+ (NSDictionary	*)getVersionInfo;(CLLocationCoordinate2D)coordinates Radius:(NSString *)Radius
//Get a 
+ (NSDictionary *)getiPlanBDashboard:(CLLocationCoordinate2D)coordinates Radius:(NSString *)Radius from:(NSString *)from to:(NSString *)to;
//
+(NSDictionary *)postAgentID:(CLLocationCoordinate2D)coordinates
                      box_id:(NSString *)box_id
                       speed:(NSString *)speed
                  technology:(NSString *)technology
                     carrier:(NSString *)carrier
                         mcc:(NSString *)mcc
                         nmc:(NSString *)nmc
                  batt_level:(NSString *)batt_level
                 batt_status:(NSString *)batt_status
                         dir:(NSString *)dir;

//(latitude, longitude, box_id, speed, technology, carrier, mcc, nmc, batt_level, batt_status, dir)

//http://www.itestnet.co.uk/scripts/postResults.php?box_id=DATA24&latitude=37.337593&longitude=-122.036733&speed=16.18mph&direction=270.41&technology=(null)&carrier=(null)&mcc=(null)&nmc=(null)&batt_level=-100&batt_status=Unknown&latency=50&webpage_time=0.500&down_speed=25000&up_speed=5000

+(NSDictionary *)postResults:(CLLocationCoordinate2D)coordinates
                      box_id:(NSString *)box_id
                       speed:(NSString *)speed
                         dir:(NSString *)dir
                  technology:(NSString *)technology
                     carrier:(NSString *)carrier
                         mcc:(NSString *)mcc
                         nmc:(NSString *)nmc
                  batt_level:(NSString *)batt_level
                 batt_status:(NSString *)batt_status
                     latency:(NSString *)latency
                webpage_time:(NSString *)webpage_time
                  down_speed:(NSString *)down_speed
                    up_speed:(NSString *)up_speed;



@end
