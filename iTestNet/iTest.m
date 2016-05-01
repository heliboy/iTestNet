//----------------------------------------------------------->
//  iPlanB.h
//  iPlanB
//
//  Created by David Owens on 21/06/2012.
//  Copyright 2012 RemoveBeforeFlight. All rights reserved.
//----------------------------------------------------------->

#import "HMAC.h"                        //
#import "iTest_Licence.h"               //user generated licence key file, provide by Synectics-tc.com
#import "iTest.h"                      //
#import <CoreLocation/CoreLocation.h>   //


@interface iTest(Private)
+ (NSArray *)getDataArray:(NSString *)url;
+ (NSDictionary *)getDataDictionary:(NSString *)url;
+ (NSString *)TileXYToQuadKey:(NSUInteger)tileX andY:(NSUInteger)tileY andZ:(NSUInteger)Zoom;
@end

@implementation iTest

+ (NSDictionary *)getiPlanBDashboard:(CLLocationCoordinate2D)coordinates Radius:(NSString *)Radius from:(NSString *)from to:(NSString *)to {
    // The function builds the required url to extract co-ordinates based on a given address
    
    //Cleanse url for weird character
    NSString *start_date = from;    //[self urlStringPercentEscapesUsingAllNonAlphaNumeric:from];
    NSString *end_date = to;        //[self urlStringPercentEscapesUsingAllNonAlphaNumeric:to];
    
    NSLog(@"startdate %@ : finishdate %@",start_date,end_date);
    
    double north = coordinates.latitude+0.1525365;  //[Radius doubleValue]; 51.671703;   //
    double south = coordinates.latitude-0.1525365;  //[Radius doubleValue]; 51.366636;   //
    double east = coordinates.longitude+0.1525365;  //[Radius doubleValue]; -0.469666;   //
    double west =  coordinates.longitude-0.1525365; //[Radius doubleValue]; 0.189514;    //
    NSLog(@"%f%f%f%f\n\r",north,south,east,west);
    
    //http://www.radioplanningtools.com/mobile/planB/mt3000_data_json.php?startdate=2013%2F02%2F03%2000%3A00&finishdate=2013%2F07%2F31%2023%3A59
    //build the address query string <HTTP Method><URL Path><URL Query String><Application ID>
    NSString *URL_PREFIX_DASHBOARD = [NSString stringWithFormat:@"%@?startdate=%@?finishdate=%@",
                                      ITEST_DASHBOARD_URL,
                                      [sha256_HMAC urlStringPercentEscapesUsingAllNonAlphaNumeric:start_date],
                                      [sha256_HMAC urlStringPercentEscapesUsingAllNonAlphaNumeric:end_date]];
    
    NSString *pathToHash = [NSString stringWithFormat:@"%@?startdate=%@?finishdate=%@",
                            ITEST_DASHBOARD_URL,
                            start_date,
                            end_date];
    
    NSLog(@"String to hash=GET%@\n\r",URL_PREFIX_DASHBOARD);
    
    //build the base url
    NSString *base_URL = [NSString stringWithFormat:ITEST_BASE_URL];
    
    
    // The string used to calculate the hash is made up of the following components:
    // <HTTP Method><URL Path><URL Query String><Application ID>
    // Now take that string and calculate a HMA check sum...
    NSString *hash = [sha256_HMAC hmacForSecret:ITEST_SECRET_ID url:[ITEST_HTTP_GET_METHOD stringByAppendingString:pathToHash]];
    
    //Combine the url prefix for sites with customerid & password
    NSString *finalPath = [NSString stringWithFormat:@"%@%@/hash/%@",base_URL,URL_PREFIX_DASHBOARD,hash];
    
    //Print out full url so it can be checked in the debug mode;
    NSLog(@"Completed URL=%@\n\r",finalPath);
    NSLog(@"%@::%@::%@",hash,ITEST_SECRET_ID,finalPath);
    
    return[self getDataDictionary:finalPath];
}

+(NSDictionary *)postAgentID:(CLLocationCoordinate2D)coordinates
                                       box_id:(NSString *)box_id
                                        speed:(NSString *)speed
                                   technology:(NSString *)technology
                                      carrier:(NSString *)carrier
                                          mcc:(NSString *)mcc
                                          nmc:(NSString *)nmc
                                   batt_level:(NSString *)batt_level
                                  batt_status:(NSString *)batt_status
                                          dir:(NSString *)dir;{

    // The function builds the required url to extract co-ordinates based on a given address

    double lat = coordinates.latitude;      //[Radius doubleValue]; 51.366636;   //
    double lon = coordinates.longitude;     //[Radius doubleValue]; -0.469666;   //
    
//http://www.itestnet.co.uk/scripts/postAgentID.php?box_id="DATA24"&latitude=54.4009&longitude=-1.344&speed=10.3&direction=234&technology=4G&carrier=Telefonica&mcc=234&nmc=10&batt_level=49&batt_status=charging
    
    //build the address query string <HTTP Method><URL Path><URL Query String><Application ID>
    NSString *URL_PREFIX_DASHBOARD = [NSString stringWithFormat:@"%@?box_id=%@&latitude=%f&longitude=%f&speed=%@&direction=%@&technology=%@&carrier=%@&mcc=%@&nmc=%@&batt_level=%@&batt_status=%@",
                                      ITEST_AGENTS_URL,
                                      box_id,
                                      lat,
                                      lon,
                                      speed,
                                      dir,
                                      technology,
                                      carrier,
                                      mcc,
                                      nmc,
                                      batt_level,
                                      batt_status];
    
    NSString *pathToHash = [NSString stringWithFormat:@"%@?box_id=%@&latitude=%f&longitude=%f&speed=%@&direction=%@&technology=%@&carrier=%@&mcc=%@&nmc=%@&batt_level=%@&batt_status=%@",
                            ITEST_AGENTS_URL,
                            box_id,
                            lat,
                            lon,
                            speed,
                            dir,
                            technology,
                            carrier,
                            mcc,
                            nmc,
                            batt_level,
                            batt_status];
    
    NSLog(@"String to hash=GET%@\n\r",URL_PREFIX_DASHBOARD);
    
    //build the base url
    NSString *base_URL = [NSString stringWithFormat:ITEST_BASE_URL];
    
    
    // The string used to calculate the hash is made up of the following components:
    // <HTTP Method><URL Path><URL Query String><Application ID>
    // Now take that string and calculate a HMA check sum...
    NSString *hash = [sha256_HMAC hmacForSecret:ITEST_SECRET_ID url:[ITEST_HTTP_GET_METHOD stringByAppendingString:pathToHash]];
    
    //Combine the url prefix for sites with customerid & password
    //NSString *finalPath = [NSString stringWithFormat:@"%@%@/hash/%@",base_URL,URL_PREFIX_DASHBOARD,hash];
    NSString *finalPath = [NSString stringWithFormat:@"%@%@",base_URL,URL_PREFIX_DASHBOARD];
    //Print out full url so it can be checked in the debug mode;
    NSLog(@"Completed URL=%@\n\r",finalPath);
    NSLog(@"%@::%@::%@",hash,ITEST_SECRET_ID,finalPath);
    //return[self getDataDictionary:URL_PREFIX_DASHBOARD];
    return[self getDataDictionary:finalPath];
}


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
                    up_speed:(NSString *)up_speed;{
    // The function builds the required url to extract co-ordinates based on a given address
    
    double lat = coordinates.latitude;      //[Radius doubleValue]; 51.366636;   //
    double lon = coordinates.longitude;     //[Radius doubleValue]; -0.469666;   //
    
    //http://www.itestnet.co.uk/scripts/postAgentID.php?box_id="DATA24"&latitude=54.4009&longitude=-1.344&speed=10.3&direction=234&technology=4G&carrier=Telefonica&mcc=234&nmc=10&batt_level=49&batt_status=charging
    
    //build the address query string <HTTP Method><URL Path><URL Query String><Application ID>
    NSString *URL_PREFIX_DASHBOARD = [NSString stringWithFormat:@"%@?box_id=%@&latitude=%f&longitude=%f&speed=%@&direction=%@&technology=%@&carrier=%@&mcc=%@&nmc=%@&batt_level=%@&batt_status=%@&latency=%@&webpage_time=%@&down_speed=%@&up_speed=%@",
                                      ITEST_RESULTS_URL,
                                      box_id,
                                      lat,
                                      lon,
                                      speed,
                                      dir,
                                      technology,
                                      carrier,
                                      mcc,
                                      nmc,
                                      batt_level,
                                      batt_status,
                                      latency,
                                      webpage_time,
                                      down_speed,
                                      up_speed];
    
    NSString *pathToHash = [NSString stringWithFormat:@"%@?box_id=%@&latitude=%f&longitude=%f&speed=%@&direction=%@&technology=%@&carrier=%@&mcc=%@&nmc=%@&batt_level=%@&batt_status=%@&latency=%@&webpage_time=%@&down_speed=%@&up_speed=%@",
                            ITEST_RESULTS_URL,
                            box_id,
                            lat,
                            lon,
                            speed,
                            dir,
                            technology,
                            carrier,
                            mcc,
                            nmc,
                            batt_level,
                            batt_status,
                            latency,
                            webpage_time,
                            down_speed,
                            up_speed];
    
    NSLog(@"String to hash=GET%@\n\r",URL_PREFIX_DASHBOARD);
    
    //build the base url
    NSString *base_URL = [NSString stringWithFormat:ITEST_BASE_URL];
    
    // The string used to calculate the hash is made up of the following components:
    // <HTTP Method><URL Path><URL Query String><Application ID>
    // Now take that string and calculate a HMA check sum...
    NSString *hash = [sha256_HMAC hmacForSecret:ITEST_SECRET_ID url:[ITEST_HTTP_GET_METHOD stringByAppendingString:pathToHash]];
    
    //Combine the url prefix for sites with customerid & password
    //NSString *finalPath = [NSString stringWithFormat:@"%@%@/hash/%@",base_URL,URL_PREFIX_DASHBOARD,hash];
    NSString *finalPath = [NSString stringWithFormat:@"%@%@",base_URL,URL_PREFIX_DASHBOARD];
    //Print out full url so it can be checked in the debug mode;
    NSLog(@"Completed URL=%@\n\r",finalPath);
    NSLog(@"%@::%@::%@",hash,ITEST_SECRET_ID,finalPath);
    //return[self getDataDictionary:URL_PREFIX_DASHBOARD];
    return[self getDataDictionary:finalPath];
}


+ (NSArray *)getDataArray:(NSString *)url {
    //define error return instance variable
    NSError *error=nil;
    
    //Cleanse url for weird character
    //url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    
    //Read contents to a data object...
    //NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSASCIIStringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"data:%@",data);
    
    //construct an array built with the data returned...
    NSArray *results =jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    // NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
    
    //NSLog(@"%@",results);
    
    return results;
}

+ (NSDictionary *)getDataDictionary:(NSString *)url {
    //define error return instance variable
    NSError *error=nil;
    
    //NSLog(@"1:%@",url);
    //url = @"http://www.radioplanningtools.com/mobile/planB/scripts/postXYZ.php?userid=01&obdvin=1M8GDM9A_KP0427&lastx=0.01&lasty=-0.06&lastz=-1.10&speed=-2.25&swvr=1.23&rssi=-85&lat=54.4009&lon=-1.344";
    //userid=01&obdvin=1M8GDM9A_KP0427&lastx=0.01&lasty=-0.06&lastz=-1.10&speed=-2.25 mph&swvr=1.0&rssi=-110&lat=51.380051&lon=-1.317316
    
   // NSString *theOrigString = @"http://maps.apple.com/maps?saddr=41.447910,-74.357881&daddr=719 Old Route 9 North, Wappingers Falls, NY 12590";
    
    //lets make sure we have no spaces;-)
    //Cleanse url for weird character
    NSString *pr_url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"2:%@",pr_url);
    
    //url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]NSASCIIStringEncoding;
    
    //Read contents to a data object...
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:pr_url] encoding:NSASCIIStringEncoding error:&error] dataUsingEncoding:NSUTF8StringEncoding];
    
    //construct an array built with the data returned...
    NSDictionary *results =jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] : nil;
    
    if (error){
        NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    }
    
    //NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
    
    NSLog(@"%@",results);
    
    return results;
}

@end
