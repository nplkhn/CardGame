//
//  GameViewController.m
//  CardGame
//
//  Created by Никита Плахин on 4/26/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

// TODO: сделать задержку перед скрытием карточек

#import "GameViewController.h"
#import "Card.h"

@interface GameViewController ()

@property (nonatomic, strong) NSArray<Card *> *cards;
@property (nonatomic, strong) Card *choosedCard;
@property (nonatomic, strong) UIStackView *containerStackView;
@property (nonatomic, assign) int numberOfTapped;
@property (nonatomic, assign) NSUInteger matchID;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemIndigoColor;
    [self setupNavigationBar];
    [self setupCards];
}

#pragma mark - Setup views

- (void)setupCards {
    [self initCards];
    
    NSMutableArray<UIStackView *> *stackViewsArray = [NSMutableArray new];
    
    // MARK: add target-action to card, filling stack view array with stack views
    NSMutableArray<Card *> *cards = [NSMutableArray new];
    for (Card *card in self.cards) {
        [card addTarget:self
                  action:@selector(cardTapped:)
        forControlEvents:UIControlEventTouchUpInside];
        [cards addObject:card];
        if (cards.count == 4 || [self.cards indexOfObject:card] == self.cards.count - 1) {
            [stackViewsArray addObject:[self addStackViewWithCards:cards]];
            [cards removeAllObjects];
        }
    }

    // MARK: setup container stack view
    UIStackView *containerStackView = [UIStackView new];
    containerStackView.axis = UILayoutConstraintAxisVertical;
    containerStackView.alignment = UIStackViewAlignmentFill;
    containerStackView.distribution = UIStackViewDistributionFillEqually;
    containerStackView.spacing = 10.0;
    
    containerStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:containerStackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [containerStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16.0],
        [containerStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:16.0],
        [containerStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16.0],
        [containerStackView.heightAnchor constraintEqualToConstant:125.0*stackViewsArray.count]
    ]];
    
    
    for (UIStackView *stackView in stackViewsArray) {
        [containerStackView addArrangedSubview:stackView];
    }
}

- (void)initCards {
    NSMutableArray<Card *> *cards = [NSMutableArray new];
    
    NSMutableArray<NSString *> *emojiArray = [NSMutableArray arrayWithArray:@[@"😀", @"👽", @"😇", @"🤯", @"🤢", @"😈", @"🤡", @"👻", @"🎃", @"🤖"]];
    
    for (int idx = 0; idx < self.numberOfCards; idx++) {
        NSString *emoji = emojiArray[arc4random_uniform((uint32_t)emojiArray.count)];
        Card *card1 = [[Card alloc] initWithBackgroundColor: UIColor.systemOrangeColor andEmoji:emoji andID:[emoji hash]];
        Card *card2 = [[Card alloc] initWithBackgroundColor: UIColor.systemOrangeColor andEmoji:emoji andID:[emoji hash]];
        [emojiArray removeObject:emoji];
        
        [cards addObjectsFromArray:@[card1, card2]];
    }
    
    // MARK: Shuffling the cards:
    NSUInteger count = cards.count;
    for (NSUInteger i = 0; i < count; ++i) {
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [cards exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    self.cards = cards;
}

- (UIStackView*)addStackViewWithCards:(NSArray<Card *>*)cards {
    UIStackView *stackView = [UIStackView new];
    
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 10.0;
    
    for (Card *card in cards) {
        [stackView addArrangedSubview:card];
    }
    
    return stackView;
}

- (void)setupNavigationBar {
    [UIView animateWithDuration:0.3 animations:^{
        [self.navigationController setNavigationBarHidden:NO];
        self.navigationController.navigationBar.alpha = 0.25;
        self.navigationController.navigationBar.tintColor = UIColor.blackColor;
    }];

}

#pragma mark - handlers

- (void)cardTapped:(Card *)obj {
    if (obj.isOpened) {
        self.numberOfTapped--;
    } else {
        self.numberOfTapped++;
    }
    [obj revertCard];
    
    if (self.numberOfTapped == 1) {
        self.matchID = obj.ID;
    } else if (self.numberOfTapped == 2 && self.matchID == obj.ID) {
        [UIView animateWithDuration:0.5 animations:^{
            [self hideCardWithId:self.matchID andWithId:obj.ID];
        }];
        self.matchID = 0;
        self.numberOfTapped = 0;
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            [self closeAllCards];
        }];
        self.matchID = 0;
        self.numberOfTapped = 0;
    }
    
}

#pragma mark - helpers

- (void)closeAllCards {
    for (Card *card in self.cards) {
        [card closeCard];
    }
}

- (void)hideCardWithId:(NSUInteger)id1 andWithId:(NSUInteger)id2 {
    for (Card *card in self.cards) {
        if (card.ID == id1 || card.ID == id2) {
            [card hideCard];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
