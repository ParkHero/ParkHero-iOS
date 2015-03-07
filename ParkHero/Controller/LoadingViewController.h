//
//  LoadingViewController.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingViewController : UIViewController

- (instancetype)initWithMessage:(NSString *)message;
- (void)closeWithCompletion:(void (^)(void))completion;

@end
