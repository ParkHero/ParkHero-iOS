//
//  RequestHelper.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "RequestHelper.h"

@implementation RequestHelper

+ (void)startRequest:(NSMutableURLRequest *)request completion:(RequestHelperCompletionBlock)completion {
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"Calling: %@", request.URL);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response,
                                               NSData* data,
                                               NSError* error) {
                               NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                               if (!error && httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 && data) {
                                   NSLog(@"Response: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   completion(YES, data, nil);
                               } else {
                                   NSLog(@"Request failed.");
                                   completion(NO, data, error);
                               }
                           }];
}

@end
