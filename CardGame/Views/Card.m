//
//  CardView.m
//  CardGame
//
//  Created by Никита Плахин on 4/26/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

#import "Card.h"


@implementation Card


- (instancetype)initWithBackgroundColor:(UIColor *)color andEmoji:(NSString *)emoji andID:(NSUInteger)ID{
    self = [super init];
    if (self) {
        _ID = ID;
        _isMatched = NO;
        _isOpened = NO;
        [self setTitle:emoji forState:UIControlStateNormal];
        self.backgroundColor = color;
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.titleLabel.layer.opacity = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:50.0];
    self.titleLabel.text = @"Button";
}

- (void)revertCard {
    self.titleLabel.layer.opacity ? [self closeCard] : [self openCard];
}

- (void)openCard {
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.layer.opacity = 1;
        self.layer.backgroundColor = UIColor.whiteColor.CGColor;
    }];
    self.isOpened = YES;
}

- (void)closeCard {
    [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^{
        self.titleLabel.layer.opacity = 0;
        self.layer.backgroundColor = UIColor.systemOrangeColor.CGColor;
    } completion:nil];

    self.isOpened = NO;
}

- (void)hideCard {
    [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^{
        self.layer.opacity = 0;
    } completion:nil];
    self.isMatched = YES;
}



@end
