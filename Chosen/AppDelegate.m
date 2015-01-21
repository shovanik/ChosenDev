//
//  AppDelegate.m
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "AppDelegate.h"
#import "LandingViewController.h"
#import "Context.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize navigationcontroller;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    LandingViewController *landingViewController =  [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];
       /* if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
            //For Iphone4
            landingViewController =  [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];
            NSLog(@"iPhone4");
        }else{
            landingViewController =  [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];

            NSLog(@"iPhone6");

        }*/

    navigationcontroller = [[UINavigationController alloc]initWithRootViewController:landingViewController];
    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:navigationcontroller];
    
    _revealSideViewController.delegate = self;
    
    self.window.rootViewController = _revealSideViewController;
    
    PP_RELEASE(landingViewController);
    PP_RELEASE(navigationcontroller);
    navigationcontroller.navigationBarHidden = YES;
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark - PPRevealSideViewController delegate

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller willPushController:(UIViewController *)pushedController {
    //PPRSLog(@"%@", pushedController);
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller didPushController:(UIViewController *)pushedController {
    // PPRSLog(@"%@", pushedController);
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller willPopToController:(UIViewController *)centerController {
    // PPRSLog(@"%@", centerController);
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller didPopToController:(UIViewController *)centerController {
    // PPRSLog(@"%@", centerController);
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller didChangeCenterController:(UIViewController *)newCenterController {
    //PPRSLog(@"%@", newCenterController);
}

- (BOOL)pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateDirectionGesture:(UIGestureRecognizer *)gesture forView:(UIView *)view {
    return NO;
}

- (PPRevealSideDirection)pprevealSideViewController:(PPRevealSideViewController *)controller directionsAllowedForPanningOnView:(UIView *)view {
    if ([view isKindOfClass:NSClassFromString(@"UIWebBrowserView")]) return PPRevealSideDirectionLeft | PPRevealSideDirectionRight;
    
    return PPRevealSideDirectionLeft | PPRevealSideDirectionRight | PPRevealSideDirectionTop | PPRevealSideDirectionBottom;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
