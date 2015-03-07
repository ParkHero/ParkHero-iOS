//
//  UserDefaults.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface UserDefaults : NSObject

@property (nonatomic) User *currentUser;

+ (UserDefaults *)instance;

@end
