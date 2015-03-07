//
//  API.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "API.h"

@implementation API

+ (NSString *)baseUrl {
    return @"http://parkhero.io";
}

+ (NSString *)registerUrl {
    return [[self baseUrl] stringByAppendingString:@"/users/register"];
}

+ (NSString *)loginUrl {
    return [[self baseUrl] stringByAppendingString:@"/users/login"];
}

@end
