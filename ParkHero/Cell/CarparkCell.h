//
//  CarparkCell.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Carpark;

@interface CarparkCell : UITableViewCell

- (instancetype)initWithCarpark:(Carpark *)carpark;

@end
