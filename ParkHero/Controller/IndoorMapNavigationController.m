//
//  IndoorMapNavigationController.m
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "IndoorMapNavigationController.h"
#import "IndoorMapViewController.h"

@implementation IndoorMapNavigationController

- (instancetype)init {
    if (self = [super init]) {
        IndoorMapViewController *vc = [[IndoorMapViewController alloc] init];
        [self pushViewController:vc animated:NO];
    }
    return self;
}

@end
