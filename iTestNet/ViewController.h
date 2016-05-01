//
//  ViewController.h
//  iTestNet
//
//  Created by David Owens on 03/09/2015.
//  Copyright (c) 2015 David Owens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//#import <CoreTelephony/CTCarrier.h>
//#import <CoreTelephony/CTTelephonyNetworkInfo.h>
@import CoreTelephony;
@import CFNetwork;
@import UIKit;
@import AudioToolbox;
//#import "LocationEngine.h"
//#import "CLLocation (Strings).h"

//add classes here
@interface ViewController :UIViewController <CLLocationManagerDelegate >{
    NSMutableData *_responseData;
}
//{
    //CLLocationManager *locationManager;
    //UIBarButtonItem *pause;
    //NSString   *gpsSpeed;
    //CLLocationCoordinate2D *currentCoordinates;
    //CLLocationSpeed *currentSpeed;
    //CLLocation *location;
//}


//set location parameters
//@property(nonatomic, strong) CLLocationManager *locationManager;
//@property(nonatomic, assign) CLLocationCoordinate2D currentCoordinates;
//@property(nonatomic, assign) CLLocationSpeed *currentSpeed;
@property(nonatomic, assign) NSString *gpsSpeed;
@property(nonatomic, retain) CLLocation *location;

//Mobile related stuff for the database
@property(nonatomic, readonly, retain) NSString *carrierName;
@property(nonatomic, readonly, retain) NSString *mobileNetworkCode;
@property(nonatomic, readonly, retain) NSString *mobileCountryCode;
@property(nonatomic, readonly, retain) CTCarrier *subscriberCellularProvider;
@property(nonatomic, readonly) float batteryLevel;

//itest test result parameters
@property(retain, nonatomic) IBOutlet UILabel *lblLatency;


//@property(nonatomic, strong) CLLocationManager *locationManager; //retain?

//screen assets...
@property(retain, nonatomic) IBOutlet UILabel *txtLat;
@property(retain, nonatomic) IBOutlet UILabel *txtLng;
@property(retain, nonatomic) IBOutlet UILabel *txtSpeed;
@property(retain, nonatomic) IBOutlet UILabel *lblStatus;
@property(retain, nonatomic) IBOutlet UILabel *lblDirection;
@property(retain, nonatomic) IBOutlet UILabel *lblWePageSpeed;
@property(retain, nonatomic) IBOutlet UILabel *lblDownloadSpeed;
@property(retain, nonatomic) IBOutlet UILabel *lblUploadSpeed;
@property(retain, nonatomic) IBOutlet UIButton *btnStart;
@property(retain, nonatomic) IBOutlet UILabel *lblBatt_Percentage;
@property(retain, nonatomic) IBOutlet UILabel *lblBatt_Status;
@property(retain, nonatomic) IBOutlet UILabel *lblTimeStamp;

//status indicator...
@property(retain, nonatomic) IBOutlet UIActivityIndicatorView *indStatus;


//Network Carrier information...
@property(retain, nonatomic) IBOutlet UILabel *lblRadioAccessTechnology;
@property(retain, nonatomic) IBOutlet UILabel *lblCarrier;
@property(retain, nonatomic) IBOutlet UILabel *lblmcc;
@property(retain, nonatomic) IBOutlet UILabel *lblmnc;


//screen images
@property(retain, nonatomic) IBOutlet UIImageView *imgRedRock;
@property(retain, nonatomic) IBOutlet UIImageView *imgBlueRock;
@property(retain, nonatomic) IBOutlet UIImageView *imgOrangeRock;
@property(retain, nonatomic) IBOutlet UIImageView *imgGreenRock;

@end

