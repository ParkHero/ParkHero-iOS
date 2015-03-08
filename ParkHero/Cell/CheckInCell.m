//
//  CheckInCell.m
//  ParkHero
//
//  Created by Dylan Marriott on 08/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "CheckInCell.h"
#import "CheckIn.h"
#import "Carpark.h"

@implementation CheckInCell {
    CheckIn *_checkIn;
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_dateLabel;
    UILabel *_costLabel;
}

- (instancetype)initWithCheckIn:(CheckIn *)checkIn {
    if (self = [super init]) {
        _checkIn = checkIn;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageView = [[UIImageView alloc] initWithImage:_checkIn.carpark.image];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = _checkIn.carpark.name;
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:27];
        _titleLabel.textColor = [UIColor colorWithWhite:0.15 alpha:1.0];
        [self.contentView addSubview:_titleLabel];
        
        _dateLabel = [[UILabel alloc] init];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        _dateLabel.text = [formatter stringFromDate:_checkIn.checkinDate];
        _dateLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:16];
        _dateLabel.textColor = [UIColor colorWithWhite:0.45 alpha:1.0];
        [self.contentView addSubview:_dateLabel];
        
        _costLabel = [[UILabel alloc] init];
        _costLabel.text = [NSString stringWithFormat:@"%.0f Sfr.", _checkIn.cost / 100.];
        _costLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25];
        _costLabel.textColor = [UIColor colorWithWhite:0.15 alpha:1.0];
        _costLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_costLabel];
        
        [_checkIn.carpark addObserver:self forKeyPath:@"image" options:0 context:nil];
    }
    return self;
}

- (void)dealloc {
    [_checkIn.carpark removeObserver:self forKeyPath:@"image"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (_imageView.image == nil) {
        _imageView.alpha = 0.0;
        _imageView.image = _checkIn.carpark.image;
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.alpha = 1.0;
        }];
    } else {
        _imageView.image = _checkIn.carpark.image;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(20, 20, 60, 60);
    _imageView.layer.cornerRadius = 30;
    _titleLabel.frame = CGRectMake(100, 20, self.contentView.frame.size.width - 120, 30);
    _dateLabel.frame = CGRectMake(100, 55, self.contentView.frame.size.width - 120, 30);
    _costLabel.frame = CGRectMake(self.contentView.frame.size.width - 100, 34, 80, 30);
}

@end
