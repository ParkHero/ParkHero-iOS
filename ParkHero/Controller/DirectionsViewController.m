//
//  DirectionsViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "DirectionsViewController.h"
#import "Carpark.h"
#import <CoreLocation/CoreLocation.h>
#import "DirectionsMapViewController.h"
#import "DirectionsListViewController.h"
#import <MapKit/MapKit.h>

@implementation DirectionsViewController {
    Carpark *_carpark;
    CLLocation *_currentLocation;
    DirectionsMapViewController *_mapVC;
    DirectionsListViewController *_listVC;
    UIView *_mapView;
    UIView *_listView;
    UIBarButtonItem *_toggleButton;
    BOOL _toggle;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _carpark.name;
    
    _listVC = [[DirectionsListViewController alloc] initWithCarpark:_carpark currentLocation:_currentLocation];
    [self addChildViewController:_listVC];
    _listView = _listVC.view;
    [self.view addSubview:_listView];
    
    
    _mapVC = [[DirectionsMapViewController alloc] initWithCarpark:_carpark currentLocation:_currentLocation];
    [self addChildViewController:_mapVC];
    _mapView = _mapVC.view;
    [self.view addSubview:_mapView];
    
    _toggleButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"List"] style:UIBarButtonItemStylePlain target:self action:@selector(actionToggle:)];
    [self.navigationItem setRightBarButtonItem:_toggleButton animated:YES];
    
    
    
    MKPlacemark *source = [[MKPlacemark alloc]initWithCoordinate:_currentLocation.coordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    MKMapItem *srcMapItem = [[MKMapItem alloc]initWithPlacemark:source];
    [srcMapItem setName:@""];
    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:_carpark.location.coordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    MKMapItem *distMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:srcMapItem];
    [request setDestination:distMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        NSArray *arrRoutes = [response routes];
        MKRoute *route = arrRoutes[0];
        [_mapVC setRoute:route];
        [_listVC setSteps:route.steps];
    }];
}

- (void)actionToggle:(id)sender {
    _toggle = !_toggle;
    [UIView animateWithDuration:0.2 animations:^{
        if (_toggle) {
            _toggleButton.image = [UIImage imageNamed:@"Map"];
            _mapView.alpha = 0.0;
        } else {
            _toggleButton.image = [UIImage imageNamed:@"List"];
            _mapView.alpha = 1.0;
        }
    }];
}

@end
