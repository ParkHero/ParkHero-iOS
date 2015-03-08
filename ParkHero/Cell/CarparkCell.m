//
//  CarparkCell.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "CarparkCell.h"
#import "Carpark.h"

@implementation CarparkCell {
    Carpark *_carpark;
    UILabel *_titleLabel;
    UIImageView *_imageView;
    UILabel *_distanceLabel;
    UIView *_freeContainer;
    UILabel *_freeLabel;
    UILabel *_priceLabel;
}

- (instancetype)initWithCarpark:(Carpark *)carpark {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
        _carpark = carpark;
        [_carpark addObserver:self forKeyPath:@"image" options:0 context:nil];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = _carpark.name;
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        _titleLabel.textColor = [UIColor colorWithWhite:0.15 alpha:1.0];
        [self.contentView addSubview:_titleLabel];
        
        _imageView = [[UIImageView alloc] initWithImage:_carpark.image];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 6;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        _distanceLabel = [[UILabel alloc] init];
        if (_carpark.distance >= 1000) {
            _distanceLabel.text = [NSString stringWithFormat:@"%.1f km", _carpark.distance / 1000.];
        } else {
            _distanceLabel.text = [NSString stringWithFormat:@"%lu m", _carpark.distance];
        }
        _distanceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        _distanceLabel.textColor = [UIColor colorWithWhite:0.45 alpha:1.0];
        [self.contentView addSubview:_distanceLabel];
        
        
        _freeContainer = [[UIView alloc] init];
        _freeContainer.backgroundColor = [self colorForLabel];
        _freeContainer.layer.cornerRadius = 4;
        _freeLabel = [[UILabel alloc] init];
        _freeLabel.font = [UIFont boldSystemFontOfSize:12];
        _freeLabel.textColor = [UIColor whiteColor];
        _freeLabel.text = [NSString stringWithFormat:@"%lu", _carpark.free];
        [_freeContainer addSubview:_freeLabel];
        [self.contentView addSubview:_freeContainer];
        
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        _priceLabel.textColor = [UIColor colorWithWhite:0.45 alpha:1.0];
        NSString *price;
        if (_carpark.cost <= 100) {
            price = @"$";
        } else if (_carpark.cost <= 200) {
            price = @"$$";
        } else {
            price = @"$$$";
        }
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
        float spacing = 2.0f;
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(spacing)
                                 range:NSMakeRange(0, [price length])];
        
        _priceLabel.attributedText = attributedString;
        [self.contentView addSubview:_priceLabel];
    }
    return self;
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

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(20, 20, self.contentView.frame.size.width - 140, 28);
    _imageView.frame = CGRectMake(self.contentView.frame.size.width - 120, 20, 100, self.contentView.frame.size.height - 40);
    CGSize freeSize = [_freeLabel.text sizeWithAttributes:@{NSFontAttributeName: _freeLabel.font}];
    _freeContainer.frame  = CGRectMake(20, 60, freeSize.width + 16, freeSize.height + 10);
    _freeLabel.frame = CGRectMake(8, 5, freeSize.width, freeSize.height);
    CGSize distanceSize = [_distanceLabel.text sizeWithAttributes:@{NSFontAttributeName: _distanceLabel.font}];
    _distanceLabel.frame = CGRectMake(70, 59, distanceSize.width, 25);
    _priceLabel.frame = CGRectMake(135, 59, 60, 25);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _freeContainer.backgroundColor = [self colorForLabel];
    
}

- (UIColor *)colorForLabel {
    return _carpark.free > 0 ? [UIColor colorWithRed:0.13 green:0.37 blue:0.06 alpha:1.00] : [UIColor colorWithRed:0.37 green:0.00 blue:0.03 alpha:1.00];
}

@end
