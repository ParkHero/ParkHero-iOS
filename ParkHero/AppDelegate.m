//
//  AppDelegate.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "User.h"
#import "MainNavigationController.h"
#import <EstimoteSDK/ESTBeaconManager.h>
#import <CoreLocation/CoreLocation.h>
#import "CheckInViewController.h"
#import "CheckOutViewController.h"
#import "Carpark.h"

@interface AppDelegate () <ESTBeaconManagerDelegate, CLLocationManagerDelegate>

@end

@implementation AppDelegate {
    ESTBeaconManager *_beaconManager;
    CLLocationManager *_locationManager;
    CLBeaconRegion *_region;
    BOOL _checkinLocked;
    BOOL _checkinPending;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestAlwaysAuthorization];
    _locationManager.delegate = self;
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    _region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"com.dylanmarriott.ParkHero"];
    [_locationManager startMonitoringForRegion:_region];
    [_locationManager startRangingBeaconsInRegion:_region];
    
    
    if ([UserDefaults instance].currentUser) {
        MainNavigationController *mainNavigationController = [[MainNavigationController alloc] init];
        self.window.rootViewController = mainNavigationController;
    } else {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        self.window.rootViewController = loginViewController;
    }
    
    return YES;
}

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region {
    [_locationManager startRangingBeaconsInRegion:_region];
}

- (void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region {
    [_locationManager stopRangingBeaconsInRegion:_region];
}

-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region {
    CLBeacon *foundBeacon = [beacons firstObject];
    NSLog(@"distance: %ld", (long)foundBeacon.rssi);
    if(foundBeacon.rssi > -60 && foundBeacon.rssi < 0 && !_checkinLocked && [UserDefaults instance].currentUser) {
        if (_checkinPending) {
            [self openCheckOut];
        } else {
            [self openCheckIn];
        }
    }
}

- (void)openCheckIn {
    _checkinLocked = YES;
    _checkinPending = YES;
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    [jsonDict setObject:[UserDefaults instance].currentUser.token forKey:@"token"];
    NSData *json = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[API checkInWithUUID:@"19"]]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:json];
    
    [RequestHelper startRequest:request completion:^(BOOL success, NSData *data, NSError *error) {
        if (success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            Carpark *cp = [[Carpark alloc] initWithJson:json[@"carpark"]];
            CheckInViewController *vc = [[CheckInViewController alloc] initWithCarpark:cp];
            self.window.rootViewController = vc;
        } else {
            
        }
    }];
}

- (void)openCheckOut {
    _checkinLocked = YES;
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    [jsonDict setObject:[UserDefaults instance].currentUser.token forKey:@"token"];
    NSData *json = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[API checkOutWithUUID:@"19"]]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:json];
    
    [RequestHelper startRequest:request completion:^(BOOL success, NSData *data, NSError *error) {
        if (success) {
            _checkinPending = NO;
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            Carpark *cp = [[Carpark alloc] initWithJson:json[@"carpark"]];
            CheckOutViewController *vc = [[CheckOutViewController alloc] initWithCarpark:cp cost:[json[@"cost"] integerValue]];
            self.window.rootViewController = vc;
        } else {
            
        }
    }];
}

- (void)freeCheckIn {
    _checkinLocked = NO;
}

@end
