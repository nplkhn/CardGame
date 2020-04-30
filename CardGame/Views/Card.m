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
    self.titleLabel.textColor = UIColor.blackColor;
}

- (void)revertCard {
    self.titleLabel.layer.opacity ? [self closeCard] : [self openCard];
}

- (void)openCard {
    self.titleLabel.layer.opacity = 1;
    self.isOpened = YES;
}

- (void)closeCard {
    self.titleLabel.layer.opacity = 0;
    self.isOpened = NO;
}

- (void)hideCard {
    self.layer.opacity = 0;
    self.isMatched = YES;
}



@end
