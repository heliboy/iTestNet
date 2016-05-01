//
//  CRC32.h
//  HDCoverage
//
//  Created by David Owens on 29/01/2011.
//  Copyright 2011 RemoveBeforeFlight. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DEFAULT_POLYNOMIAL 0xEDB88320L  
#define DEFAULT_SEED       0xFFFFFFFFL  

@interface NSData (CRC)
-(uint32_t) crc32;  
-(uint32_t) crc32WithSeed:(uint32_t)seed;  
-(uint32_t) crc32UsingPolynomial:(uint32_t)poly;  
-(uint32_t) crc32WithSeed:(uint32_t)seed usingPolynomial:(uint32_t)poly;
@end
