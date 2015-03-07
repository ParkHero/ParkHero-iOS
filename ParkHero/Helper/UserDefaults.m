//
//  UserDefaults.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "UserDefaults.h"
#import "User.h"

@implementation UserDefaults {
    NSUserDefaults* _defaults;
}

static User* _currentUser;
static UserDefaults* sharedInstance;

+ (void)initialize {
    [super initialize];
    sharedInstance = [[UserDefaults alloc] init];
}

+ (UserDefaults *)instance {
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (User *)currentUser {
    if (_currentUser == nil) {
        _currentUser = (User *)[self codableObjectForKey:@"currentUser"];
    }
    return _currentUser;
}

- (void)setCurrentUser:(User *)currentUser {
    _currentUser = currentUser;
    [self setCodableObject:currentUser forKey:@"currentUser"];
}

#pragma mark -
- (void)reset {
    NSString* domain = [[NSBundle mainBundle] bundleIdentifier];
    [_defaults removePersistentDomainForName:domain];
}

#pragma mark - Private
- (void)setCodableObject:(id<NSCoding>)object forKey:(NSString *)key {
    NSData* encoded = [NSKeyedArchiver archivedDataWithRootObject:object];
    [_defaults setObject:encoded forKey:key];
    [_defaults synchronize];
}
- (id<NSCoding>)codableObjectForKey:(NSString *)key {
    NSData* encoded = [_defaults objectForKey:key];
    id<NSCoding> ret = [NSKeyedUnarchiver unarchiveObjectWithData:encoded];
    return ret;
}


@end
