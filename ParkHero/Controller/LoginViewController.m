//
//  LoginViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController () <LoginViewDelegate>
@end

@implementation LoginViewController {
    LoginView *_loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
}

#pragma mark - LoginViewDelegate
- (void)performedLoginWithEmail:(NSString *)email password:(NSString *)password {

}

- (void)performedRegistrationWithName:(NSString *)name email:(NSString *)email password:(NSString *)password {

}

@end
