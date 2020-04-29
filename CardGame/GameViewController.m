//
//  GameViewController.m
//  CardGame
//
//  Created by Никита Плахин on 4/26/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

// TODO: исправить баг с карточками(при выборе двух разных карточек и последующем выборе правильной карточки 2 раза пропадают карточки нужные), сделать чтобы карточки не пропадли сразу

#import "GameViewController.h"
#import "Card.h"

@interface GameViewController ()

@property (nonatomic, strong) NSArray<Card *> *cards;
@property (nonatomic, strong) UIStackView *containerStackView;
@property (nonatomic, assign) int numberOfTapped;
@property (nonatomic, assign) NSUInteger matchID;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.systemIndigoColor;
    [self setupCards];
}

#pragma mark - Setup cards

- (void)setupCards {
    [self initCards];
    
    NSMutableArray<UIStackView *> *stackViewsArray = [NSMutableArray new];
    
    // MARK: filling stack view array with stack views
    NSMutableArray<Card *> *cards = [NSMutableArray new];
    for (Card *card in self.cards) {
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
    

    
    for (Card *card in self.cards) {
        [card addTarget:self
                 action:@selector(cardTapped:)
       forControlEvents:UIControlEventTouchUpInside];
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
    
    // MARK: Card size constraints
//
//    for (Card *card in cards) {
//        card.translatesAutoresizingMaskIntoConstraints = NO;
//        [NSLayoutConstraint activateConstraints:@[
//            [card.heightAnchor constraintEqualToConstant:100.0],
//            [card.widthAnchor constraintEqualToConstant:80.0]
//        ]];
//    }
    
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

#pragma mark - handlers


// TODO: rewrite this method – works incorrectly
- (void)cardTapped:(Card *)obj {
    if (obj.isOpened) {
        self.numberOfTapped--;
    } else {
        self.numberOfTapped++;
    }
    [obj revertCard];
    if (self.numberOfTapped == 1) {
        self.matchID = obj.ID;
    } else if (self.numberOfTapped == 2) {
        if (self.matchID == obj.ID) {
            [self performSelector:@selector(hideCardWithId:andWithId:) withObject:nil afterDelay:0.6];
//            [NSThread sleepForTimeInterval:0.6];
            [self hideCardWithId:self.matchID andWithId:obj.ID];
            self.numberOfTapped = 0;
        } else {
//            [NSThread sleepForTimeInterval:0.6];
            [self closeAllCards];
            self.numberOfTapped = 0;
        }
    }
    
    
//    if (obj.isOpened) {
//        self.numberOfTapped--;
//    } else {
//        self.numberOfTapped++;
//    }
//    [obj revertCard];
//
//    if (self.numberOfTapped == 1) {
//        self.matchID = obj.ID;
//    } else if (self.numberOfTapped == 2 && self.matchID == obj.ID) {
//        self.numberOfTapped = 0;
////        [obj revertCard];
////        sleep(1);
//        [self closeCardWithId:self.matchID andWithId:obj.ID];
//    } else if (self.numberOfTapped == 3) {
//        [self closeAllCards];
//        self.numberOfTapped = 1;
//        self.matchID = obj.ID;
//    }
    
}

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
