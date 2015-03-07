//
//  Carpark.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "Carpark.h"

@implementation Carpark

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.identifier = [aDecoder decodeObjectForKey:@"identifier"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.distance = [aDecoder decodeIntegerForKey:@"distance"];
        self.capacity = [aDecoder decodeIntegerForKey:@"capacity"];
        self.free = [aDecoder decodeIntegerForKey:@"free"];
        self.cost = [aDecoder decodeIntegerForKey:@"cost"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeInteger:self.distance forKey:@"distance"];
    [aCoder encodeInteger:self.capacity forKey:@"capacity"];
    [aCoder encodeInteger:self.free forKey:@"free"];
    [aCoder encodeInteger:self.cost forKey:@"cost"];
}

@end
