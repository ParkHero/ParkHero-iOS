//
//  Carpark.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CarparkTypeDefault
} CarparkType;


@interface Carpark : NSObject <NSCoding>

@property (nonatomic) NSString *identifier;
@property (nonatomic) NSString *name;
@property (nonatomic) CarparkType type;
@property (nonatomic) UIImage *image;
@property (nonatomic) CLLocation *location;
@property (nonatomic) NSInteger distance;
@property (nonatomic) NSInteger capacity;
@property (nonatomic) NSInteger free;
@property (nonatomic) NSInteger cost;
@property (nonatomic) NSString *address;

- (void)downloadImage:(NSString *)url;

@end
