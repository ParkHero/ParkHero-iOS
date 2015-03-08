//
//  CheckOutViewController.m
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "CheckOutViewController.h"
#import "Carpark.h"
#import "AppDelegate.h"
#import "MainNavigationController.h"

@implementation CheckOutViewController {
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *headerBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170)];
    [headerBg setBackgroundColor:[UIColor colorWithRed:0.29 green:0.55 blue:0.09 alpha:1.00]];
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
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reset:)]];
    [circle addSubview:_imageView];
    
    UILabel *thanksLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 242, self.view.frame.size.width, 60)];
    thanksLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:46];
    thanksLabel.textColor = [UIColor colorWithWhite:0.15 alpha:1.0];
    thanksLabel.text = [NSString stringWithFormat:@"Thank you!"];
    thanksLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thanksLabel];
    
    UIView *d1 = [[UIView alloc] initWithFrame:CGRectMake(40, 320, self.view.frame.size.width - 80, 0.5)];
    d1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.view addSubview:d1];
    
    UILabel *stayLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 340, self.view.frame.size.width - 80, 40)];
    stayLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:24];
    stayLabel.textColor = [UIColor colorWithWhite:0.55 alpha:1.0];
    stayLabel.text = [NSString stringWithFormat:@"Your Stay: 0:01"];
    [self.view addSubview:stayLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 340, self.view.frame.size.width - 80, 40)];
    timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    timeLabel.textColor = [UIColor colorWithWhite:0.15 alpha:1.0];
    timeLabel.text = [NSString stringWithFormat:@"%.0f Sfr.", 2.];
    timeLabel.textAlignment = NSTextAlignmentRight;
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

- (void)reset:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate freeCheckIn];
    self.view.window.rootViewController = [[MainNavigationController alloc] init];
}

@end
