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
        self.address = [aDecoder decodeObjectForKey:@"address"];
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
    [aCoder encodeObject:self.address forKey:@"address"];
}

- (instancetype)initWithJson:(NSDictionary *)json {
    if (self = [super init]) {
        self.identifier = json[@"id"];
        self.name = [json[@"name"] stringByReplacingOccurrencesOfString:@"Marriot" withString:@"Marriott"];;
        self.type = [json[@"type"] integerValue];
        self.address = json[@"address"];
        self.free = [json[@"free"] integerValue];
        self.capacity = [json[@"capacity"] integerValue];
        self.cost = [json[@"cost"] integerValue];
        self.distance = [json[@"distance"] integerValue];
        [self downloadImage:[[API baseUrl] stringByAppendingString:json[@"image"]]];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[json[@"latitude"] doubleValue] longitude:[json[@"longitude"] doubleValue]];
        self.location = loc;
    }
    return self;
}

- (void)downloadImage:(NSString *)url {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response,
                                               NSData* data,
                                               NSError* error) {
                               self.image = [[UIImage alloc] initWithData:data];
                           }];
}

@end
