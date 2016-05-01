#import "Settings.h"


@implementation Settings

+ (NSString *)getField:(NSString *)fieldName
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
	
	if (standardUserDefaults) 
	{
		val = [standardUserDefaults objectForKey:fieldName];
	}
	if (val == nil) 
	{
		val = @"";
	}
	
	return val;
}

+ (void)setField:(NSString *)fieldName fieldValue:(NSString *)value
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults) 
	{
		[standardUserDefaults setObject:value forKey:fieldName];
		[standardUserDefaults synchronize];
	}
}

+ (bool)getBooleanField:(NSString *)fieldName
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	bool val = NO;
	
	if (standardUserDefaults) 
	{
		val = [standardUserDefaults boolForKey:fieldName];
	}
	
	return val;
}

+ (void)setBooleanField:(NSString *)fieldName fieldValue:(bool)value
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults) 
	{
		[standardUserDefaults setBool:value forKey:fieldName];
		[standardUserDefaults synchronize];
	}
}

// Added by STGW
+ (int)timer
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	int val = kSpeedTestDuration;
	
	if (standardUserDefaults) 
	{
		val = [standardUserDefaults integerForKey:@"timer"];
	}
	
	return val;
}

// Added by STGW
+ (void)setTimer:(int)value
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults) 
	{
		[standardUserDefaults setInteger:value forKey:@"timer"];
		[standardUserDefaults synchronize];
	}
}


+ (NSString *)username
{
	return [[self getField:@"username"] length] == 0 ? @"anonymous" : [self getField:@"username"];
}

+ (void)setUsername:(NSString *)username
{
	[self setField:@"username" fieldValue:username];
}

+ (NSString *)password
{
	return [[self getField:@"password"] length] == 0 ? @"8Jn43HGe3kMazuOie" : [self getField:@"password"];
}

+ (void)setPassword:(NSString *)password
{
	[self setField:@"password" fieldValue:password];
}

+ (NSString *)phoneNumber
{
	return [self getField:@"phoneNumber"];
}

+ (void)setPhoneNumber:(NSString *)phoneNumber
{
	[self setField:@"phoneNumber" fieldValue:phoneNumber];
}

// Added by STGW
+ (bool)usessl
{
	return [self getBooleanField:@"usessl"];
}
+ (void)setUsessl:(bool)usessl
{
	[self setBooleanField:@"usessl" fieldValue:usessl];
}

// Added by STGW
+ (bool)usehdc
{
	return [self getBooleanField:@"usehdc"];
}
+ (void)setUsehdc:(bool)usehdc
{
	[self setBooleanField:@"usehdc" fieldValue:usehdc];
}

+ (NSString *)advancedTestEvent
{
	NSString* result = [self getField:@"event"];
	
	if ([result length] == 0)
	{
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"dd/MM/yyyy"];
		result = [dateFormatter stringFromDate:[NSDate date]];
		[dateFormatter release];
	}
	return result;
}

+ (void)setAdvancedTestEvent:(NSString *)event
{
	[self setField:@"event" fieldValue:event];
}

+ (bool)advancedTestPromptOnError
{
	return ![self getBooleanField:@"prompt"];
}

+ (void)setAdvancedTestPromptOnError:(bool)prompt
{
	[self setBooleanField:@"prompt" fieldValue:!prompt];
}

+ (NSString *)advancedTestWebPageUrl
{
	return [self getField:@"webpageurl"];
}

+ (void)setAdvancedTestWebPageUrl:(NSString *)url
{
	[self setField:@"webpageurl" fieldValue:url];
}

+ (bool)userAuthenticated
{
	return [self getBooleanField:@"userauthenticated"] && ![[self username] isEqualToString:@"anonymous"];
}

+ (void)setUserAuthenticated:(bool)userAuthenticated
{
	[self setBooleanField:@"userauthenticated" fieldValue:userAuthenticated];
}

+ (NSString *)lastCampaignUpdate
{
	return [self getField:@"lastcampaignupdate"];
}

+ (void)setLastCampaignUpdate:(NSString *)lastCampaignUpdate
{
	[self setField:@"lastcampaignupdate" fieldValue:lastCampaignUpdate];
}

@end
