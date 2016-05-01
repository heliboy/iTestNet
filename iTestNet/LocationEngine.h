//
//  LocationEngine.h
//  HDCovMap
//
//  Created by Simon Wootton on 17/12/2012.
//  Copyright (c) 2012 SpatialBuzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationEngine : NSObject <CLLocationManagerDelegate> {}

- (id)initWithLatitude:(float)startlat longitude:(float)startlon;

- (CLLocationCoordinate2D)currentCoordinates;
- (CLLocationSpeed)currentSpeed;

@end

