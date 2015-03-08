//
//  AccountViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "AccountViewController.h"
#import "LoadingViewController.h"
#import "User.h"
#import "CheckIn.h"
#import "Carpark.h"
#import "CheckInCell.h"

@implementation AccountViewController {
    LoadingViewController *_loadingViewController;
    NSArray *_checkIns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"History";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(close:)];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    _loadingViewController = [[LoadingViewController alloc] initWithMessage:@"Please be patient while we load\nyour check-in history."];
    [self presentViewController:_loadingViewController animated:NO completion:nil];
    
    NSString *url = [NSString stringWithFormat:@"%@?token=%@", [API checkInsUrl], [UserDefaults instance].currentUser.token];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [RequestHelper startRequest:request completion:^(BOOL success, NSData *data, NSError *error) {
        if (success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *jsonCheckIns = json[@"checkins"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSS"];
            NSMutableArray *checkIns = [NSMutableArray array];
            for (NSDictionary *jsonCheckIn in jsonCheckIns) {
                CheckIn *checkIn = [[CheckIn alloc] init];
                checkIn.identifier = jsonCheckIn[@"id"];
                checkIn.checkinDate = [dateFormatter dateFromString:jsonCheckIn[@"checkin"]];
                checkIn.checkoutDate = [dateFormatter dateFromString:jsonCheckIn[@"checkout"]];
                checkIn.duration = [jsonCheckIn[@"duration"] integerValue];
                checkIn.cost = [jsonCheckIn[@"cost"] integerValue];
                checkIn.carpark = [[Carpark alloc] initWithJson:jsonCheckIn[@"carpark"]];
                [checkIns addObject:checkIn];
            }
            _checkIns = [NSArray arrayWithArray:checkIns];
        } else {
            
        }
        [self.tableView reloadData];
        [_loadingViewController closeWithCompletion:nil];
    }];

}

- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _checkIns.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckIn *checkIn = _checkIns[indexPath.row];
    CheckInCell *cell = [[CheckInCell alloc] initWithCheckIn:checkIn];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
