#import <Foundation/Foundation.h>

@interface Settings : NSObject 
{
}

+ (NSString *)username;
+ (void)setUsername:(NSString *)username;

+ (NSString *)password;
+ (void)setPassword:(NSString *)password;

+ (NSString *)phoneNumber;
+ (void)setPhoneNumber:(NSString *)phoneNumber;

+ (NSString *)advancedTestEvent;
+ (void)setAdvancedTestEvent:(NSString *)event;

+ (bool)advancedTestPromptOnError;
+ (void)setAdvancedTestPromptOnError:(bool)prompt;

+ (NSString *)advancedTestWebPageUrl;
+ (void)setAdvancedTestWebPageUrl:(NSString *)url;

+ (bool)userAuthenticated;
+ (void)setUserAuthenticated:(bool)userAuthenticated;

+ (NSString *)lastCampaignUpdate;
+ (void)setLastCampaignUpdate:(NSString *)lastCampaignUpdate;

+ (bool)usessl; //Added by STGW
+ (void)setUsessl:(bool)usessl; //Added by STGW

+ (bool)usehdc; //Added by STGW
+ (void)setUsehdc:(bool)usehdc; //Added by STGW

+ (int)timer; //Added by STGW
+ (void)setTimer:(int)value; //Added by STGW

@end
