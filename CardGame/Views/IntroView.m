//
//  IntroView.m
//  CardGame
//
//  Created by Никита Плахин on 4/26/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

#import "IntroView.h"

@interface IntroView()

@property (nonatomic, strong) UILabel *labelChoose;
@property (nonatomic, strong) UITextField *textFieldChoose;

@property (nonatomic, strong) UIButton *buttonSubmit;

@end

@implementation IntroView

- (UIView*)setupIntroView {
    UIView *view = [[UIView alloc] init];
    
    self.labelChoose = [UILabel new];
    self.labelChoose.text = @"Enter number of cards";
        
    self.labelChoose.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:self.labelChoose];
    [NSLayoutConstraint activateConstraints:@[
        [self.labelChoose.centerYAnchor constraintEqualToAnchor:view.centerYAnchor constant:-50.0],
        [self.labelChoose.centerXAnchor constraintEqualToAnchor:view.centerXAnchor]
    ]];
        
    self.textFieldChoose = [UITextField new];
    self.textFieldChoose.placeholder = @"4..10";
    self.textFieldChoose.layer.borderColor = UIColor.grayColor.CGColor;
    self.textFieldChoose.layer.borderWidth = 1.0;
    self.textFieldChoose.layer.cornerRadius = 5.0;
//    self.textFieldChoose inset
        
    self.textFieldChoose.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:self.textFieldChoose];
    [NSLayoutConstraint activateConstraints:@[
        [self.textFieldChoose.centerYAnchor constraintEqualToAnchor:view.centerYAnchor constant:-25.0],
        [self.textFieldChoose.centerXAnchor constraintEqualToAnchor:view.centerXAnchor],
        [self.textFieldChoose.widthAnchor constraintEqualToConstant:150.0]
    ]];
        
    self.buttonSubmit = [[UIButton alloc] init];
    [self.buttonSubmit setTitle:@"Submit" forState:UIControlStateNormal];
    [self.buttonSubmit setTitleColor:UIColor.systemPinkColor forState:UIControlStateNormal];
    self.buttonSubmit.translatesAutoresizingMaskIntoConstraints = NO;
        
    [view addSubview:self.buttonSubmit];
    [NSLayoutConstraint activateConstraints: @[
        [self.buttonSubmit.centerYAnchor constraintEqualToAnchor:view.centerYAnchor constant:0.0],
        [self.buttonSubmit.centerXAnchor constraintEqualToAnchor:view.centerXAnchor]
    ]];
    
    return view;
}

@end
