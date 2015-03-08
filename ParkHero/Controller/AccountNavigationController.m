//
//  AccountNavigationController.m
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "AccountNavigationController.h"
#import "AccountViewController.h"

@implementation AccountNavigationController

- (instancetype)init {
    if (self = [super init]) {
        AccountViewController *vc = [[AccountViewController alloc] init];
        [self pushViewController:vc animated:NO];
    }
    return self;
}


@end
