//
//  CarparkListViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "CarparkListViewController.h"

@interface CarparkListViewController () <CLLocationManagerDelegate>
@end

@implementation CarparkListViewController {
    UIAlertView *_loadingAlert;
    CLLocationManager* _locationManager;
    CLLocation* _currentLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    _loadingAlert = [[UIAlertView alloc] initWithTitle:@"Please Wait" message:@"Finding car parks close to your current location." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [_loadingAlert show];
    
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    [_locationManager requestWhenInUseAuthorization];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_locationManager startUpdatingLocation];
}

- (void)fetchData {

}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _currentLocation = [locations lastObject];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
}


@end
