#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface Device : NSObject {
	Reachability *reachability;
	NetworkStatus networkStatus;
}

@property (nonatomic, assign) NetworkStatus networkStatus;
@property (nonatomic, retain) Reachability *reachability;

+ (Device *)instance;

- (NSNumber *)batteryLevel;
- (NSString *)batteryStateDescription;
- (NSString *)imei;
- (NSString *)networkId;

- (void)loadReachability;
- (void)reachabilityChanged:(NSNotification *)notification;
- (NSString *)reachabilityDescription;

@end
