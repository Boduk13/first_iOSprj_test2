//
//  FTWCache.h
//  test2
//
//  Created by razomer on 1/13/16.
//  Copyright © 2016 razom.s. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTWCache : NSObject

+ (void) resetCache;

+ (void) setObject:(NSData*)data forKey:(NSString*)key;
+ (id) objectForKey:(NSString*)key;

@end