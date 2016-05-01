//--------------------------------------------------------
//  HMAC.h
//  VIP trackerV2
//
//  Created by David Owens on 11/07/2012.
//  Copyright (c) 2012 David Owens. All rights reserved.
//--------------------------------------------------------

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import "NSData+Base64.h"
#import "NSData+Conversion.h"
//---------------------------------------------->
//#define CC_SHA256_DIGEST_LENGTH     32          /* digest length in bytes */
//#define CC_SHA256_HASH_LENGTH       24
//#define CC_SHA256_BLOCK_BYTES       64          /* block size in bytes */
//---------------------------------------------->

@class sha256_HMAC;
//Wadaro_Mobile:NSObject
@interface sha256_HMAC:NSData
+(NSString *) hmacForSecret:(NSString *)secret url:(NSString *)url;
+(NSString *) encodeSha256Hmac:(NSString *)url andSecreturl: (NSString *)secret;
+(NSString *) sha256:(NSString *)clear;
+(NSString *) encodeParameter:(NSString *)param;
+(NSString *) urlStringPercentEscapesUsingAllNonAlphaNumeric:(NSString *)place;
+(NSString *) stringToHexidecimal:(NSString *)inString;
@end
