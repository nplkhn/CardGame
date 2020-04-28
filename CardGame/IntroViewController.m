//
//  ViewController.m
//  CardGame
//
//  Created by Никита Плахин on 4/26/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

#import "IntroViewController.h"
#import "GameViewController.h"

@interface IntroViewController ()

@property (nonatomic, strong) UILabel *labelChoose;
@property (nonatomic, strong) UITextField *textFieldChoose;

@property (nonatomic, strong) UIButton *buttonSubmit;

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    [self.buttonSubmit addTarget:self
                           action:@selector(handleButtonTap)
                 forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - setupView

- (void)setupView {
    self.view.layer.backgroundColor = UIColor.systemBackgroundColor.CGColor;
    
    self.labelChoose = [UILabel new];
    self.labelChoose.text = @"Enter number of cards";
    self.labelChoose.font = [UIFont fontWithName:@"Helvetica" size:30.0];
    
    self.labelChoose.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.labelChoose];
    [NSLayoutConstraint activateConstraints:@[
        [self.labelChoose.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-100.0],
        [self.labelChoose.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
    
    self.textFieldChoose = [UITextField new];
    self.textFieldChoose.placeholder = @"4..10";
    self.textFieldChoose.layer.borderColor = UIColor.grayColor.CGColor;
    self.textFieldChoose.layer.borderWidth = 1.0;
    self.textFieldChoose.layer.cornerRadius = 10.0;
//    self.textFieldChoose.keyboardType = UIKeyboardTypePhonePad;
    self.textFieldChoose.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.textFieldChoose.delegate = self;
    
    self.textFieldChoose.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.textFieldChoose];
    [NSLayoutConstraint activateConstraints:@[
        [self.textFieldChoose.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-40.0],
        [self.textFieldChoose.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.textFieldChoose.widthAnchor constraintEqualToConstant:250.0],
        [self.textFieldChoose.heightAnchor constraintEqualToConstant:40.0]
    ]];
    
    self.buttonSubmit = [[UIButton alloc] init];
    [self.buttonSubmit setTitle:@"Submit" forState:UIControlStateNormal];
    [self.buttonSubmit setTitleColor:UIColor.systemPinkColor forState:UIControlStateNormal];
    self.buttonSubmit.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:25.0];
    self.buttonSubmit.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.buttonSubmit];
    [NSLayoutConstraint activateConstraints: @[
        [self.buttonSubmit.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:50.0],
        [self.buttonSubmit.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}

#pragma mark - Handlers

- (void)handleButtonTap {
    NSLog(@"Transition to gameVC");
    if (![self.textFieldChoose.text isEqualToString:@""]) {
        GameViewController *gameVC = [GameViewController new];
        gameVC.numberOfCards = self.textFieldChoose.text.intValue;
        [self.navigationController pushViewController:gameVC animated:YES];
    } else {
        self.labelChoose.textColor = UIColor.systemRedColor;
    }
    
}

#pragma mark - delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    [self handleButtonTap];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSArray *arrayOfNumber = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    
    if (([arrayOfNumber containsObject:string] && [NSString stringWithFormat:@"%@%@", textField.text, string].intValue <= 40) || [string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

@end
