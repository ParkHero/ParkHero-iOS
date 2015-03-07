//
//  CarparkCell.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "CarparkCell.h"
#import "Carpark.h"

@implementation CarparkCell {
    Carpark *_carpark;
}

- (instancetype)initWithCarpark:(Carpark *)carpark {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
        _carpark = carpark;
    }
    return self;
}

@end
