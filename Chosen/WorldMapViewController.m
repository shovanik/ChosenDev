//
//  WorldMapViewController.m
//  Chosen
//
//  Created by AppsbeeTechnology on 09/02/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "WorldMapViewController.h"
#import "SlideOutMenuViewController.h"
NSUserDefaults *pref;

@interface WorldMapViewController (){
    CGFloat _offset;
    CGFloat distancePerMile;
}
//@property (nonatomic, strong) NSString *mapRadious;

@end

@implementation WorldMapViewController
@synthesize wrldMapView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   _offset = 50;
    distancePerMile = 5.0;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *appDg =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    appDg.locManager=nil;
    [appDg localnotification];
    
    //Map CoordinateRegion
    MKCoordinateRegion region;
    region.center.latitude = appDg.locManager.location.coordinate.latitude;
    region.center.longitude = appDg.locManager.location.coordinate.longitude;
    
    NSLog(@"Location Details: %@ %@ \n%@ ",appDg.placemarkL.locality,appDg.placemarkL.postalCode,appDg.placemarkL.country);
    NSLog(@"Location's Latitude = %f,and longitude = %f",region.center.latitude,region.center.longitude);
    
    //one degree of latitude is always approximately 111 kilometers (69 miles).
    
    double scalingFactor = ABS((cos(2 * M_PI * region.center.latitude / 360.0) ));
    
    MKCoordinateSpan span;
    span.latitudeDelta = 5/14.0;
    span.longitudeDelta = 5/(scalingFactor * 14.0);
    region.span = span;
    
    [wrldMapView regionThatFits:region ];
    [wrldMapView setRegion:region animated:YES];
    
    //Create overlay of 5  kms on the map
    int distance = appDg.selectedRadious;
    int meter = distance*1000*1.60934;
    MKCircle *circle= [[MKCircle alloc]init];
    circle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(appDg.locManager.location.coordinate.latitude,appDg.locManager.location.coordinate.longitude) radius:meter];
    
    [wrldMapView addOverlay:circle];
    
    //Make Annotation pin
    CLLocationCoordinate2D annotationCoord;
    MKPointAnnotation *annotationPoint=nil;
    for (NSDictionary *usersDic in appDg.nearByUserArray) {
        annotationPoint = [[MKPointAnnotation alloc] init] ;
        annotationCoord.latitude =[[usersDic objectForKey:@"lat" ] doubleValue];
        annotationCoord.longitude = [[usersDic objectForKey:@"lon" ] doubleValue];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.title = [usersDic objectForKey:@"user_name" ];
        annotationPoint.subtitle = [NSString stringWithFormat:@"%@ %@",[usersDic objectForKey:@"country_id"],[usersDic objectForKey:@"city_id"]];
        
        [wrldMapView addAnnotation:annotationPoint];
    }
    
}
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKCircle class]])
    {
        MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
        circleView.fillColor = [UIColor colorWithRed:4/255.0f green:86/255.0f blue:163/255.0f alpha:0.5];
        circleView.strokeColor =[UIColor colorWithRed:4/255.0f green:86/255.0f blue:136/255.0f alpha:0.3];
        circleView.lineWidth = 100;
        return circleView;
    }
    else
        return nil;
}

/*- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];

    
    
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"location_icon"];
            pinView.calloutOffset = CGPointMake(0, 32);
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
        
    }
    
    // Handle any custom annotations.
   if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        //MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.frame = CGRectMake(0.00, 0.00, 200.0, 200.0);
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"location_icon"];
            pinView.calloutOffset = CGPointMake(0, 0);
            
            
            // Add a detail disclosure button to the callout.
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = rightButton;
            
            // Add an image to the left callout.
            UIView *accView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, 200, 200)];
            accView.backgroundColor = [UIColor redColor];
            pinView.leftCalloutAccessoryView = accView;
            
            UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic.png"]];
            [accView addSubview:iconView];
            
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)slideMenuButtonTapped:(id)sender
{
    SlideOutMenuViewController *mVC = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController_iPhone4" bundle:nil ];
    }else{
        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController" bundle:nil ];
        
    }
    mVC.guildButton.selected = YES;
    [self.revealSideViewController pushViewController:mVC onDirection:PPRevealSideDirectionLeft withOffset:_offset animated:YES completion:^{
        PPRSLog(@"This is the end!");
    }];
    PP_RELEASE(mVC);
    
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
