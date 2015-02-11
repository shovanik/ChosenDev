//
//  AppDelegate.h
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, PPRevealSideViewControllerDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationcontroller;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;
@property (strong, nonatomic) CLLocationManager *locManager;
@property (strong, nonatomic) CLPlacemark *placemarkL;
@property (nonatomic, strong) NSArray *nearByUserArray;
@property (assign) int selectedRadious;
-(void)localnotification;
@end

