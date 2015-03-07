//
//  StepCell.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRouteStep;

@interface StepCell : UITableViewCell

- (instancetype)initWithStep:(MKRouteStep *)step;

@end