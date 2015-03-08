//
//  API.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API : NSObject

+ (NSString *)baseUrl;
+ (NSString *)registerUrl;
+ (NSString *)loginUrl;
+ (NSString *)carparkListUrl;
+ (NSString *)checkInWithUUID:(NSString *)UUID;
+ (NSString *)checkOutWithUUID:(NSString *)UUID;
+ (NSString *)checkInsUrl;

@end
