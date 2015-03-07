//
//  RequestHelper.h
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestHelperCompletionBlock)(BOOL success, NSData *data, NSError *error);

@interface RequestHelper : NSObject

+ (void)startRequest:(NSMutableURLRequest *)request completion:(RequestHelperCompletionBlock)completion;

@end