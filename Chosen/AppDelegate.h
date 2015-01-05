//
//  AppDelegate.h
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, PPRevealSideViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationcontroller;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;



@end

