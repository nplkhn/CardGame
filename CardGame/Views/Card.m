//
//  CardView.m
//  CardGame
//
//  Created by Никита Плахин on 4/26/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

#import "Card.h"

@interface Card()

@property (nonatomic, strong) UILabel *emoji;

@end

@implementation Card


- (instancetype)initWithBackgroundColor:(UIColor *)color andEmoji:(NSString *)emoji andID:(NSUInteger)ID{
    self = [super init];
    if (self) {
        _ID = ID;
        _isMatched = NO;
        _isOpened = NO;
        _emoji = [UILabel new];
        _emoji.text = emoji;
        _emoji.layer.opacity = 0;
        self.backgroundColor = color;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.emoji.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.emoji];
    
    self.emoji.font = [UIFont systemFontOfSize:40.0];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.emoji.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.emoji.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];
    
//    [self addTarget:nil action:@selector(revertCard:) forControlEvents:UIControlEventValueChanged];
}

- (void)revertCard {
    if (self.emoji.layer.opacity) {
        [self closeCard];
    } else {
        [self openCard];
    }
}

- (void)openCard {
    self.emoji.layer.opacity = 1;
    self.isOpened = YES;
}

- (void)closeCard {
    self.emoji.layer.opacity = 0;
    self.isOpened = NO;
}

- (void)hideCard {
    self.layer.opacity = 0;
    self.isMatched = YES;
}



@end
