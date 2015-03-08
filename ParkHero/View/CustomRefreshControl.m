//
//  CustomRefreshControl.m
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "CustomRefreshControl.h"

@implementation CustomRefreshControl {
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginLogo"]];
        _imageView.frame = CGRectMake(self.frame.size.width / 2 - 100, 10, 200, 60);
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat minOffsetToTriggerRefresh = 100.0f;
    if (scrollView.contentOffset.y + 64 <= -minOffsetToTriggerRefresh) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat n = -(scrollView.contentOffset.y + 64);
    _imageView.alpha = 1. / 80. * n;
    [UIView animateWithDuration:0.2 animations:^{
        if (n > 100) {
            _imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        } else {
            _imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
    }];
}

@end
