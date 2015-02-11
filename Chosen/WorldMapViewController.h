//
//  WorldMapViewController.h
//  Chosen
//
//  Created by AppsbeeTechnology on 09/02/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
@interface WorldMapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
-(IBAction)slideMenuButtonTapped:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *wrldMapView;

@end
