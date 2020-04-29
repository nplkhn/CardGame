//
//  Game.h
//  CardGame
//
//  Created by Никита Плахин on 4/29/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Game : NSObject

@property (nonatomic, strong) NSArray<Card *> *cards;
- (void)chooseCardAtIndex:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
