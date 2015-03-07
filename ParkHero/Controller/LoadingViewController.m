//
//  LoadingViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "LoadingViewController.h"

@implementation LoadingViewController {
    UIView *_container;
    UIImageView *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _container = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height / 2, self.view.frame.size.width - 40, 0)];
    _container.backgroundColor = [UIColor whiteColor];
    _container.layer.cornerRadius = 6;
    _container.clipsToBounds = YES;
    [self.view addSubview:_container];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginLogo"]];
    CGFloat size = _container.frame.size.width - 40;
    [_imageView setFrame:CGRectMake(_container.frame.size.width / 2 - size / 2, 20, size, 180)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_container addSubview:_imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, _container.frame.size.width, 60)];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    label.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"We're searching for\ncar parks near you.";
    label.numberOfLines = 2;
    [_container addSubview:label];
}

- (void)beat {
    [UIView animateWithDuration:0.25 animations:^{
        _imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.2 options:0 animations:^{
            _imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [self performSelector:@selector(beat) withObject:nil afterDelay:0.8];
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    }];
    
    [UIView animateWithDuration:0.2 delay:0.1 options:0 animations:^{
        _container.frame = CGRectMake(_container.frame.origin.x, self.view.frame.size.height / 2 - _container.frame.size.width / 2, _container.frame.size.width, _container.frame.size.width);
    } completion:^(BOOL finished) {
        [self beat];
    }];
}

- (void)close {
    [UIView animateWithDuration:0.3 animations:^{
        _container.frame = CGRectMake(_container.frame.origin.x, self.view.frame.size.height, _container.frame.size.width, _container.frame.size.height);
    }];
    
    [UIView animateWithDuration:0.3 delay:0.2 options:0 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end
