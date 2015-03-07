//
//  StepCell.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "StepCell.h"
#import <MapKit/MapKit.h>

@implementation StepCell {
    MKRouteStep *_step;
    UIView *_container;
    UILabel *_distanceLabel;
    UILabel *_instructionLabel;
}

- (instancetype)initWithStep:(MKRouteStep *)step {
    if (self = [super init]) {
        _step = step;
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.cornerRadius = 6;
        _container.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:1.0].CGColor;
        _container.layer.borderWidth = 0.5;
        [self.contentView addSubview:_container];
        
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = [UIFont systemFontOfSize:14];
        _distanceLabel.textColor = [UIColor colorWithWhite:0.45 alpha:1.0];
        _distanceLabel.text = [NSString stringWithFormat:@"%.0fm", _step.distance];
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        [_container addSubview:_distanceLabel];
        
        _instructionLabel = [[UILabel alloc] init];
        _instructionLabel.font = [UIFont systemFontOfSize:16];
        _instructionLabel.textColor = [UIColor colorWithWhite:0.15 alpha:1.0];
        _instructionLabel.text = _step.instructions;
        [_container addSubview:_instructionLabel];
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    _container.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 20);
    _distanceLabel.frame = CGRectMake(_container.frame.size.width - 70, 20, 50, 20);
    _instructionLabel.frame = CGRectMake(20, 20, _container.frame.size.width - 110, 20);
}

@end
