//
//  HMAC.m
//  VIP trackerV2
//
//  Created by David Owens on 11/07/2012.
//  Copyright (c) 2012 David Owens. All rights reserved.
//

#import "HMAC.h"

@implementation sha256_HMAC

+(NSString *) hmacForSecret:(NSString *)secret url:(NSString *)url {
//-(NSString *) encodeSha256Hmac:(NSString *)url andSecreturl: (NSString *)secret {
    
    const char *cKey  = [secret cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [url cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    //david's code
    //NSLog(@"%@",[HMAC hexadecimalString]);
    //return [HMAC hexadecimalString];
    
    //NSLog(@"%@",[HMAC base64EncodedString]);
    //return [HMAC base64EncodedString];
    //Epitiro code
    NSString *s = [HMAC hexadecimalString];
    NSLog(@"\r\n%@s\r\n",s);
    return s;
}

+(NSString *) encodeSha256Hmac:(NSString *)url andSecreturl: (NSString *)secret {
    
    const char *cKey  = [secret cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [url cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *s = [HMAC hexadecimalString];
    
    NSLog(@"\r\n%@s\r\n",s);
    
    return s;
}

+(NSString *) sha256:(NSString *)clear{
    const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

+(NSString *) encodeParameter:(NSString *)param{    
    NSString *encodedString;
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes( NULL, (__bridge CFStringRef)param, NULL, (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
    
    encodedString = [NSString stringWithFormat:@"%@",(__bridge NSString*) stringRef];
    return encodedString;
}

+(NSString *) urlStringPercentEscapesUsingAllNonAlphaNumeric:(NSString *)place{
    //define a mutable array that we can store the percent escapes changes in
    NSMutableString *rtnString = [NSMutableString string];
    
    //Cleanse url for weird character…
    //place = [place stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //Get the strings length
    NSUInteger stringLen = [place length];
    
    //Now lets loop through each of the characters and percent escape…
    for (int i = 0; i < stringLen; ++i) {
        const unsigned char thisChar = [place characterAtIndex:i];
        
        //!’\"();:@&=+$,/?%#[]%
        //Now let make sure that ALL characters other than the following characters are escaped
        if ((thisChar >= 'a' && thisChar <= 'z') ||
            (thisChar >= 'A' && thisChar <= 'Z') ||
            (thisChar >= '0' && thisChar <= '9') ||
            (thisChar == '-')) {  //||(thisChar == '+')
            [rtnString appendFormat:@"%c", thisChar];
        } else {
            [rtnString appendFormat:@"%%%02X", thisChar];
        }
    }
    NSLog(@"%@", rtnString);    
    return rtnString;
}

+(NSString *) stringToHexidecimal:(NSString *)inString{
    //define a mutable array that we can store the percent escapes changes in
    NSMutableString *rtnString = [NSMutableString string];
    
    //Cleanse url for weird character…
    inString = [inString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //Get the strings length
    NSUInteger stringLen = [inString length];
    
    //Now lets loop through each of the characters and percent escape…
    for (int i = 0; i < stringLen; ++i) {
        const unsigned char thisChar = [inString characterAtIndex:i];
        [rtnString appendFormat:@"%02X", thisChar];
        
        //Now let make sure that ALL characters other than the following characters are escaped
        /*if ((thisChar >= 'a' && thisChar <= 'z') ||
         (thisChar >= 'A' && thisChar <= 'Z') ||
         (thisChar >= '0' && thisChar <= '9')) {
         [rtnString appendFormat:@"%c", thisChar];
         } else {
         [rtnString appendFormat:@"%%%02X", thisChar];
         }*/
    }
    NSLog(@"%@", rtnString);    
    return rtnString;
}

@end
