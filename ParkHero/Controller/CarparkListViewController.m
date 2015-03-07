//
//  CarparkListViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "CarparkListViewController.h"
#import "Carpark.h"
#import "CarparkCell.h"
#import "LoadingViewController.h"

@interface CarparkListViewController () <CLLocationManagerDelegate>
@end

@implementation CarparkListViewController {
    LoadingViewController *_loadingViewController;
    CLLocationManager* _locationManager;
    CLLocation* _currentLocation;
    NSArray *_carparks;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = 100;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [_locationManager requestWhenInUseAuthorization];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_locationManager startUpdatingLocation];
}

- (void)fetchData {

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _carparks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Carpark *cp = _carparks[indexPath.row];
    CarparkCell *cell = [[CarparkCell alloc] initWithCarpark:cp];
    return cell;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _currentLocation = [locations lastObject];
    
    [_loadingViewController performSelector:@selector(close) withObject:nil afterDelay:3.0];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    _loadingViewController = [[LoadingViewController alloc] init];
    [self presentViewController:_loadingViewController animated:NO completion:nil];
}

@end
