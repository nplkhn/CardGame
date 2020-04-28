//
//  AppDelegate.m
//  CardGame
//
//  Created by Никита Плахин on 4/26/20.
//  Copyright © 2020 Никита Плахин. All rights reserved.
//

#import "AppDelegate.h"
#import "IntroViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    IntroViewController *introVC = [IntroViewController new];
//    introVC.view.frame = UIScreen.mainScreen.bounds;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:introVC];
    
    navVC.navigationBar.translucent = YES;
    
    [self.window setRootViewController:navVC];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
