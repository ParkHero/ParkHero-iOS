//
//  LoginView.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kLoginViewModeRegister,
    kLoginViewModeLogin
} LoginViewMode;

@protocol LoginViewDelegate
- (void)performedLoginWithEmail:(NSString *)email password:(NSString *)password;
- (void)performedRegistrationWithName: (NSString *)name email:(NSString *)email password:(NSString *)password;
@end

@interface LoginView : UIView

@property (nonatomic) LoginViewMode mode;
@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end
