//
//  AppDelegate.m
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import "AppDelegate.h"
#import "LandingViewController.h"
#import "Context.h"
#import <Social/Social.h>
#import "LandingViewController.h"
#import "StepOneViewController.h"
#import "STTwitter.h"


@interface AppDelegate ()
{
    
}

@end

@implementation AppDelegate
@synthesize navigationcontroller, locManager, placemarkL, nearByUserArray, selectedRadious;


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //NSLog(@"%@",url);
    
    if ([ [url absoluteString] rangeOfString:@"com.facebook.sdk_client_state"].location == NSNotFound) {
        
        if ([ [url absoluteString] rangeOfString:@"twitter_access_tokens"].location == NSNotFound)
        {}
        else
        {
            NSLog(@"Twitter Loop");
            if ([[url scheme] isEqualToString:@"myapp"] == NO) return NO;
            
            NSDictionary *d = [self parametersDictionaryFromQueryString:[url query]];
            NSString *token = d[@"oauth_token"];
            NSString *verifier = d[@"oauth_verifier"];
            
            LandingViewController *landingViewController =  (LandingViewController *)[_revealSideViewController rootViewController];
            [landingViewController setOAuthToken:token oauthVerifier:verifier];
        }
        return YES;
    }
    else
    {
        NSLog(@"Facebook Loop");
        // attempt to extract a token from the url
        return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call)
        {
            NSLog(@"In fallback handler");
        
        }];
    }
}


- (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString {
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    NSArray *queryComponents = [queryString componentsSeparatedByString:@"&"];
    
    for(NSString *s in queryComponents) {
        NSArray *pair = [s componentsSeparatedByString:@"="];
        if([pair count] != 2) continue;
        
        NSString *key = pair[0];
        NSString *value = pair[1];
        
        md[key] = value;
    }
    
    return md;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Allocate a reachability object
    
    nearByUserArray = [[NSArray alloc] init];
    selectedRadious = 5;
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"UNREACHABLE!");
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
    

    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self localnotification];

    LandingViewController *landingViewController =  [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];

    //navigationcontroller = [[UINavigationController alloc]initWithRootViewController:landingViewController];
    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:landingViewController];
        
    _revealSideViewController.delegate = self;
    
    self.window.rootViewController = _revealSideViewController;
    
    PP_RELEASE(landingViewController);
    PP_RELEASE(navigationcontroller);
    navigationcontroller.navigationBarHidden = YES;
    [self.window makeKeyAndVisible];
    
    
    [FBLoginView class];
    [FBProfilePictureView class];
    
    return YES;
}

-(void)localnotification
{
    if(locManager==nil)
        locManager = [[CLLocationManager alloc] init];
    
    locManager.delegate = self;
    locManager.distanceFilter = kCLDistanceFilterNone;
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if(IS_OS_8_OR_LATER)
    {
        [locManager requestAlwaysAuthorization];
    }
    
    //[locationManager startMonitoringSignificantLocationChanges];
    [locManager startUpdatingLocation];
}

#pragma mark - Locationmanager Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [locManager stopUpdatingLocation];
    NSLog(@"Current Location: %@", [locations lastObject]);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(error==nil &&[placemarks count]>0)
         {
             placemarkL=[placemarks lastObject] ;
             
            // NSLog(@"Place mark %@", placemarkL);
             NSLog(@"Location Details:Locality =%@ Postal code = %@  Country = %@ ",placemarkL.locality,placemarkL.postalCode,placemarkL.country);
             NSLog(@"Location's Latitude = %f,and longitude = %f",locManager.location.coordinate.latitude,locManager.location.coordinate.longitude);
             
                          
         }
         else
         {
             NSLog(@"error");
         }
         
     }];
         
             
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
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
    [FBSession setActiveSession:nil];
}

@end
