//
//  Device.m
//  iTestNet
//
//  Created by superman on 07/06/2010.
//  Copyright 2010 Penrillian. All rights reserved.
//

#import "Device.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Settings.h" // Added by STGW

@implementation Device

@synthesize networkStatus;
@synthesize reachability;

- (void)dealloc{
	//[reachability release];
	//[super dealloc];
}

NSString *UDID = [[[Device identifierForVendor] identifierForVendor] UUIDString];

- (Device *)init{
	self = (Device *)[super init];
	[[Device currentDevice] setBatteryMonitoringEnabled:YES];
	[self loadReachability];
	return self;
}

+ (Device *)instance 
{
	static Device *instance;
	
	@synchronized(self)
	{
		if (!instance)
		{
			instance = [[Device alloc] init];
		}
	}
	
	return instance;
}

- (NSNumber *)batteryLevel{
	return [NSNumber numberWithFloat: [[Device currentDevice] batteryLevel] * 100];
}

- (UIDeviceBatteryState)batteryState {
	return [[Device currentDevice] batteryState];
}

- (NSString *)batteryStateDescription {
	switch ([self batteryState]) {
		case UIDeviceBatteryStateCharging:
			return @"Charging";
			break;
		case UIDeviceBatteryStateFull:
			return @"Full";
			break;
		case UIDeviceBatteryStateUnplugged:
			return @"Unplugged";
			break;
		default:
			return @"Unknown";
			break;
	}
}

- (NSString*)imei{
	return [[UIDevice currentDevice] uniqueIdentifier];
}

- (void)loadReachability 
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
	if ([Settings usehdc] == YES) {
        self.reachability = [Reachability reachabilityWithHostName:@"www.radioplanningtools.com"]; //Changed by STGW
        NSLog(@"Using hdc for reachability"); //Changed by STGW
    }
    else {
        self.reachability = [Reachability reachabilityWithHostName:@"www.radioplanningtools.com"]; //Changed by STGW
        NSLog(@"Using itn for reachability"); //Changed by STGW
    }
    [self.reachability startNotifier];
	//networkStatus = [reachability currentReachabilityStatus];
}

- (void)reachabilityChanged:(NSNotification *)notification 
{
	networkStatus = [(Reachability *)[notification object] currentReachabilityStatus];
}


- (NSString *)networkId
{
#if TARGET_IPHONE_SIMULATOR
	return @"23410";
#else
	CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
	CTCarrier *carrierInfo = networkInfo.subscriberCellularProvider;
	NSString *result = [NSString stringWithFormat:@"%@%@", carrierInfo.mobileCountryCode, carrierInfo.mobileNetworkCode];
	[networkInfo release];
	return result;
#endif
}

- (NSString *)reachabilityDescription 
{
	NSString *reachabilityDescription;
	switch (networkStatus) 
	{
		case ReachableViaWWAN:
			reachabilityDescription = @"WWAN";
			break;
		case ReachableViaWiFi:
			reachabilityDescription = @"WiFi";
			break;
		default:
			reachabilityDescription = @"None";
			break;
	}
	return reachabilityDescription;
}


@end
