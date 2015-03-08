//
//  IndoorMapViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "IndoorMapViewController.h"
#import "AppDelegate.h"

@implementation IndoorMapViewController {
    UIView *_position;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1.00];
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(close:)];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 150, 94, 300, 512)];
    bg.image = [UIImage imageNamed:@"IndoorMap"];
    [self.view addSubview:bg];
    
    _position = [[UIView alloc] initWithFrame:CGRectMake(165 + bg.frame.origin.x, 572, 30, 30)];
    _position.layer.cornerRadius = 15;
    _position.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_position];
    
    [self beat];
}

- (void)beat {
    [UIView animateWithDuration:0.25 animations:^{
        _position.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.2 options:0 animations:^{
            _position.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [self performSelector:@selector(beat) withObject:nil afterDelay:0.8];
        }];
    }];
}

- (void)close:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate freeCheckIn];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
