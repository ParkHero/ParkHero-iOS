//
//  MainNavigationController.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "MainNavigationController.h"
#import "CarparkListViewController.h"

@implementation MainNavigationController

- (instancetype)init {
    if (self = [super init]) {
        CarparkListViewController *vc = [[CarparkListViewController alloc] init];
        [self pushViewController:vc animated:NO];
    }
    return self;
}

@end
