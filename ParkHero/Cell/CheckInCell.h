//
//  CheckInCell.h
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CheckIn;

@interface CheckInCell : UITableViewCell

- (instancetype)initWithCheckIn:(CheckIn *)checkIn;

@end