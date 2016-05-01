//
//  LocationEngine.m
//  HDCovMap
//
//  Created by Simon Wootton on 17/12/2012.
//  Copyright (c) 2012 SpatialBuzz. All rights reserved.
//

#import "LocationEngine.h"
#define kRequiredAccuracy 500.0 //meters
#define kMaxAge 10.0 //seconds

@interface LocationEngine() {
    CLLocation *currentLocation;
	CLLocationManager *locationManager;
    CLLocationSpeed *speed;
}

@end

@implementation LocationEngine

#pragma mark - Initialisation

- (id)initWithLatitude:(float)lat longitude:(float)lon {
    if (self = [super init]) {
        currentLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation; //kCLLocationAccuracyNearestTenMeters;
        locationManager.distanceFilter = 10; // meters
        
        [locationManager startUpdatingLocation];
        CLLocation* newLocation = [locationManager location];

        if (([newLocation coordinate].latitude == 37.785834 && [newLocation coordinate].longitude == -122.406417) || newLocation == NULL) return self;
        currentLocation = newLocation;
        
        NSLog(@"long %f lat %f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
        NSLog(@"speed %f ", currentLocation.speed);
    }
    return self;
}

#pragma mark - Public Methods

- (CLLocationCoordinate2D)currentCoordinates {
    return currentLocation.coordinate;
}

- (CLLocationSpeed)currentSpeed {
    return currentLocation.speed;
}

#pragma mark - Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
	if (([newLocation coordinate].latitude == 37.785834 && [newLocation coordinate].longitude == -122.406417) || newLocation == NULL) return;
    currentLocation = newLocation;

}


@end
