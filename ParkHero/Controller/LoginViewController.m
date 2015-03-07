//
//  LoginViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "User.h"
#import "MainNavigationController.h"
#import "LoadingViewController.h"

@interface LoginViewController () <LoginViewDelegate>
@end

@implementation LoginViewController {
    LoginView *_loginView;
    LoadingViewController *_loadingViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
}

#pragma mark - LoginViewDelegate
- (void)performedRegistrationWithName:(NSString *)name email:(NSString *)email password:(NSString *)password {
    _loadingViewController = [[LoadingViewController alloc] initWithMessage:@"Your registration is beeing\nprocessed, please wait."];
    [self presentViewController:_loadingViewController animated:NO completion:nil];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    [jsonDict setObject:name forKey:@"name"];
    [jsonDict setObject:email forKey:@"email"];
    [jsonDict setObject:password forKey:@"password"];
    [jsonDict setObject:@"super secret credit card token" forKey:@"creditcard"];
    NSData *json = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[API registerUrl]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:json];
    
    [RequestHelper startRequest:request completion:^(BOOL success, NSData *data, NSError *error) {
        if (success) {
            [self storeUserAndStartApp:data];
        } else {
            // TODO handle error
        }
    }];
}

- (void)performedLoginWithEmail:(NSString *)email password:(NSString *)password {
    _loadingViewController = [[LoadingViewController alloc] initWithMessage:@"We're logging you in,\nplease wait."];
    [self presentViewController:_loadingViewController animated:NO completion:nil];
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    [jsonDict setObject:email forKey:@"email"];
    [jsonDict setObject:password forKey:@"password"];
    NSData *json = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[API loginUrl]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:json];
    
    [RequestHelper startRequest:request completion:^(BOOL success, NSData *data, NSError *error) {
        if (success) {
            [self storeUserAndStartApp:data];
        } else {
            // TODO handle error
        }
    }];
}

- (void)storeUserAndStartApp:(NSData *)data {
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    overlay.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:overlay];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *jsonUser = json[@"user"];
    User *user = [[User alloc] init];
    user.email = jsonUser[@"email"];
    user.identifier = jsonUser[@"id"];
    user.name = jsonUser[@"name"];
    user.token = jsonUser[@"token"];
    
    [UserDefaults instance].currentUser = user;
    
    [_loadingViewController closeWithCompletion:^{
        MainNavigationController *mainNavigationController = [[MainNavigationController alloc] init];
        self.view.window.rootViewController = mainNavigationController;
    }];
}
@end
