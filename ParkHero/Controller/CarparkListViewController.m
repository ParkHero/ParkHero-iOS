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
#import "User.h"

@interface CarparkListViewController () <CLLocationManagerDelegate>
@end

@implementation CarparkListViewController {
    LoadingViewController *_loadingViewController;
    CLLocationManager* _locationManager;
    CLLocation* _currentLocation;
    NSArray *_carparks;
    BOOL _first;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ParkHero";
    _first = YES;
    
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
    // TODO maybe check why we're calling this many many times
    NSString *url = [NSString stringWithFormat:@"%@?token=%@&latitude=%f&longitude=%f", [API carparkListUrl], [UserDefaults instance].currentUser.token, _currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [RequestHelper startRequest:request completion:^(BOOL success, NSData *data, NSError *error) {
        if (success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *jsonCarparks = json[@"carparks"];
            NSMutableArray *carparks = [NSMutableArray array];
            for (NSDictionary *jsonCarpark in jsonCarparks) {
                Carpark *carpark = [[Carpark alloc] init];
                carpark.identifier = jsonCarpark[@"id"];
                carpark.name = jsonCarpark[@"name"];
                carpark.type = [jsonCarpark[@"type"] integerValue];
                carpark.address = jsonCarpark[@"address"];
                carpark.free = [jsonCarpark[@"free"] integerValue];
                carpark.capacity = [jsonCarpark[@"capacity"] integerValue];
                carpark.cost = [jsonCarpark[@"cost"] integerValue];
                carpark.distance = [jsonCarpark[@"distance"] integerValue];
                [carpark downloadImage:jsonCarpark[@"image"]];
                CLLocation *loc = [[CLLocation alloc] initWithLatitude:[jsonCarpark[@"latitude"] doubleValue] longitude:[jsonCarpark[@"longitude"] doubleValue]];
                carpark.location = loc;
                [carparks addObject:carpark];
            }
            _carparks = [NSArray arrayWithArray:carparks];
        } else {
            
        }
        [self.tableView reloadData];
        [_loadingViewController closeWithCompletion:nil];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _carparks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Carpark *cp = _carparks[indexPath.row];
    CarparkCell *cell = [[CarparkCell alloc] initWithCarpark:cp];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = locations.lastObject;
    if ([_currentLocation distanceFromLocation:newLocation] != 0 || _first) {
        _currentLocation = newLocation;
        _first = NO;
        [self fetchData];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        _loadingViewController = [[LoadingViewController alloc] initWithMessage:@"We're searching for\ncar parks near you."];
        [self presentViewController:_loadingViewController animated:NO completion:nil];
    }
}

@end
