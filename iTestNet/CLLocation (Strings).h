

#import <CoreLocation/CoreLocation.h>


@interface CLLocation (Strings)

- (NSString *)localizedCoordinateString;
- (NSString *)localizedAltitudeString;
- (NSString *)localizedHorizontalAccuracyString;
- (NSString *)localizedVerticalAccuracyString;
- (NSString *)localizedCourseString;
- (NSString *)localizedSpeedString;

@end

