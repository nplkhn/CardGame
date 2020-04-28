//
//  GameViewController.m
//  CardGame
//
//  Created by Никита Плахин on 4/26/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//



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
    
    NSMutableArray<Card *> *cards = [NSMutableArray new];
    for (Card *card in self.cards) {
        [cards addObject:card];
        if (cards.count == 4 || [self.cards indexOfObject:card] == self.cards.count - 1) {
            [stackViewsArray addObject:[self addStackViewWithCards:cards]];
            [cards removeAllObjects];
        }
    }

    UIStackView *containerStackView = [UIStackView new];
    containerStackView.axis = UILayoutConstraintAxisVertical;
    containerStackView.alignment = UIStackViewAlignmentFill;
    containerStackView.distribution = UIStackViewDistributionEqualSpacing;
    containerStackView.spacing = 30.0;
    
    containerStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:containerStackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [containerStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10.0],
        [containerStackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100.0],
        [containerStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10.0],
        [containerStackView.heightAnchor constraintEqualToConstant:110.0 * stackViewsArray.count + 30.0 * (stackViewsArray.count - 1)]
    ]];
    
    
    for (UIStackView *stackView in stackViewsArray) {
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [containerStackView addArrangedSubview:stackView];
        
        [NSLayoutConstraint activateConstraints:@[
            [stackView.leadingAnchor constraintEqualToAnchor:containerStackView.leadingAnchor],
            [stackView.trailingAnchor constraintEqualToAnchor:containerStackView.trailingAnchor],
            [stackView.heightAnchor constraintEqualToConstant:110.0]
        ]];
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
    self.cards = cards;
}

- (UIStackView*)addStackViewWithCards:(NSArray<Card *>*)cards {
    UIStackView *stackView = [UIStackView new];
    
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.spacing = 10.0;
    
    for (Card *card in cards) {
        card.translatesAutoresizingMaskIntoConstraints = NO;
        [stackView addArrangedSubview:card];
        
        [NSLayoutConstraint activateConstraints:@[
            [card.widthAnchor constraintEqualToConstant:75.0],
            [card.heightAnchor constraintEqualToConstant:110.0]
        ]];
    }
    
    return stackView;
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
        self.numberOfTapped = 0;
//        [obj revertCard];
//        sleep(1);
        [self closeCardWithId:self.matchID andWithId:obj.ID];
    } else if (self.numberOfTapped == 3) {
        [self closeAllCards];
        self.numberOfTapped = 1;
        self.matchID = obj.ID;
    }
    
}

- (void)closeAllCards {
    for (Card *card in self.cards) {
        [card closeCard];
    }
}

- (void)closeCardWithId:(NSUInteger)id1 andWithId:(NSUInteger)id2 {
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
