//
//  CardView.h
//  CardGame
//
//  Created by Никита Плахин on 4/26/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : UIButton

@property (nonatomic, assign) BOOL isOpened;
@property (nonatomic, assign) BOOL isMatched;
@property (nonatomic, assign) NSUInteger ID;

- (instancetype)initWithBackgroundColor:(UIColor *)color andEmoji:(NSString *)emoji andID:(NSUInteger)ID;

- (void)revertCard;
- (void)closeCard;
- (void)openCard;
- (void)hideCard;

@end

NS_ASSUME_NONNULL_END
