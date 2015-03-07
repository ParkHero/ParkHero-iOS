//
//  DirectionsMapViewController.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Carpark;
@class MKRoute;

@interface DirectionsMapViewController : UIViewController

- (instancetype)initWithCarpark:(Carpark *)carpark currentLocation:(CLLocation *)currentLocation;
- (void)setRoute:(MKRoute *)route;

@end
