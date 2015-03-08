//
//  CheckInViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "CheckInViewController.h"
#import "Carpark.h"
#import "IndoorMapNavigationController.h"

@implementation CheckInViewController {
    Carpark *_carpark;
    UIImageView *_imageView;
}

- (instancetype)initWithCarpark:(Carpark *)carpark {
    if (self = [super init]) {
        _carpark = carpark;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170)];
    [headerBg setBackgroundColor:[UIColor colorWithRed:0.21 green:0.45 blue:0.55 alpha:1.00]];
    [self.view addSubview:headerBg];
    
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, 40, 200, 200)];
    circle.backgroundColor = [UIColor whiteColor];
    circle.layer.cornerRadius = 100;
    [self.view addSubview:circle];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, circle.frame.size.width - 20, circle.frame.size.height - 20)];
    _imageView.image = _carpark.image;
    _imageView.layer.cornerRadius = _imageView.frame.size.width / 2;
    _imageView.clipsToBounds = YES;
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMap:)]];
    [circle addSubview:_imageView];
    
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 235, self.view.frame.size.width, 140)];
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:46];
    welcomeLabel.textColor = [UIColor colorWithWhite:0.15 alpha:1.0];
    welcomeLabel.text = [NSString stringWithFormat:@"Welcome to\n%@", _carpark.name];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.numberOfLines = 2;
    [self.view addSubview:welcomeLabel];
    
    UIView *d1 = [[UIView alloc] initWithFrame:CGRectMake(40, 385, self.view.frame.size.width - 80, 0.5)];
    d1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.view addSubview:d1];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 405, self.view.frame.size.width, 40)];
    priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:28];
    priceLabel.textColor = [UIColor colorWithWhite:0.55 alpha:1.0];
    priceLabel.text = [NSString stringWithFormat:@"%.0f Sfr. / Hour", _carpark.cost / 100.];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:priceLabel];
    
    UIView *d2 = [[UIView alloc] initWithFrame:CGRectMake(40, 465, self.view.frame.size.width - 80, 0.5)];
    d2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.view addSubview:d2];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 488, self.view.frame.size.width, 40)];
    timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:28];
    timeLabel.textColor = [UIColor colorWithRed:0.21 green:0.45 blue:0.55 alpha:1.00];
    timeLabel.text = [NSString stringWithFormat:@"Your Stay: 0:01"];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel];
    
    [_carpark addObserver:self forKeyPath:@"image" options:0 context:nil];
}

- (void)dealloc {
    [_carpark removeObserver:self forKeyPath:@"image"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (_imageView.image == nil) {
        _imageView.alpha = 0.0;
        _imageView.image = _carpark.image;
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.alpha = 1.0;
        }];
    } else {
        _imageView.image = _carpark.image;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)openMap:(id)sender {
    IndoorMapNavigationController *nv = [[IndoorMapNavigationController alloc] init];
    [self presentViewController:nv animated:YES completion:nil];
}

@end
