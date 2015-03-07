//
//  DirectionsViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "DirectionsViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Carpark.h"
#import "TargetAnnotation.h"

static float maxLat = FLT_MIN;
static float maxLon = FLT_MIN;
static float minLat = FLT_MAX;
static float minLon = FLT_MAX;

@interface DirectionsViewController () <MKMapViewDelegate>
@end

@implementation DirectionsViewController {
    Carpark *_carpark;
    CLLocation *_currentLocation;
    MKMapView *_mapView;
    MKPointAnnotation *_targetAnnotation;
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
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
    [self zoomAndFit:@[_currentLocation, _carpark.location]];
    
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
        MKRoute *rout = arrRoutes[0];
        
        MKPolyline *line = [rout polyline];
        [_mapView addOverlay:line];
        NSLog(@"Rout Name : %@",rout.name);
        NSLog(@"Total Distance (in Meters) :%f",rout.distance);
        
        NSArray *steps = [rout steps];
        
        NSLog(@"Total Steps : %d", [steps count]);
        
        [steps enumerateObjectsUsingBlock:^(MKRouteStep *obj, NSUInteger idx, BOOL *stop) {
            NSLog(@"Rout Instruction : %@",[obj instructions]);
            NSLog(@"Rout Distance : %f",[obj distance]);
        }];
    }];
    
    _targetAnnotation = [[MKPointAnnotation alloc] init];
    [_targetAnnotation setCoordinate:_carpark.location.coordinate];
    [_mapView addAnnotation:_targetAnnotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if (annotation != _targetAnnotation) {
        return nil;
    }
    static NSString *AnnotationViewID = @"annotationViewID";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    annotationView.image = [UIImage imageNamed:@"Annotation"];
    annotationView.annotation = annotation;
    
    return annotationView;
}

- (void)zoomAndFit:(NSArray *)locations {
    for(int i = 0; i < [locations count]; i++) {
        CLLocation *loc = locations[i];
        CLLocationCoordinate2D cord = loc.coordinate;
        minLat = MIN(minLat, cord.latitude);
        minLon = MIN(minLon, cord.longitude);
        maxLat = MAX(maxLat, cord.latitude);
        maxLon = MAX(maxLon, cord.longitude);
    }
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 2.0*(maxLat - minLat);
    span.longitudeDelta = 2.0*(maxLon - minLon);
    
    CLLocationCoordinate2D location;
    location.latitude = (minLat + maxLat)/2;
    location.longitude = (minLon + maxLon)/2;
    
    region.span=span;
    region.center=location;
    [_mapView setRegion:region animated:NO];
    [_mapView regionThatFits:region];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView* aView = [[MKPolylineView alloc]initWithPolyline:(MKPolyline*)overlay] ;
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        aView.lineWidth = 10;
        return aView;
    }
    return nil;
}

@end
