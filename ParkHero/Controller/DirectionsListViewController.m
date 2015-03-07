//
//  DirectionsListViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "DirectionsListViewController.h"
#import "Carpark.h"
#import <MapKit/MapKit.h>
#import "StepCell.h"

@implementation DirectionsListViewController {
    Carpark *_carpark;
    CLLocation *_currentLocation;
    NSArray *_steps;
}

- (instancetype)initWithCarpark:(Carpark *)carpark currentLocation:(CLLocation *)currentLocation {
    if (self = [super init]) {
        _carpark = carpark;
        _currentLocation = currentLocation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setSteps:(NSArray *)steps {
    _steps = steps;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _steps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRouteStep *step = _steps[indexPath.row];
    StepCell *cell = [[StepCell alloc] initWithStep:step];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
