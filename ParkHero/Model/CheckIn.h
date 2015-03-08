//
//  CheckIn.h
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Carpark;

@interface CheckIn : NSObject

@property (nonatomic) NSString *identifier;
@property (nonatomic) NSDate *checkinDate;
@property (nonatomic) NSDate *checkoutDate;
@property (nonatomic) NSInteger duration;
@property (nonatomic) NSInteger cost;
@property (nonatomic) Carpark *carpark;

@end
