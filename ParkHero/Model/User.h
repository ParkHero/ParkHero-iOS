//
//  User.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (nonatomic) NSString *identifier;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *email;

@end
