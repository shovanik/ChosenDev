//
//  LoginViewController.m
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "LoginViewController.h"
#import "StepOneViewController.h"
#import "LandingViewController.h"
#import "Context.h"
#import "DataClass.h"
NSUserDefaults *pref;

@interface LoginViewController (){
    CGFloat animatedDistance;

}
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * logContentViewVerticalyCenter;

@end

@implementation LoginViewController
@synthesize userNameTextField, passwordTextField, lgncontentView, navTitle, logContentViewVerticalyCenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    pref = [NSUserDefaults standardUserDefaults];
    // Do any additional setup after loading the view from its nib.
   /* for(NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        for(NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }*/
    
    if (IsIphone4) {
        self.navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        //logContentViewVerticalyCenter.constant = 50;
    }else{
        self.navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];


    self.userNameTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.userNameTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    
    UIColor *color = [UIColor colorWithRed:202.0f/255.0f green:230.0f/255.0f blue:233.0f/255.0f alpha:1.0f];
    self.userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    self.userNameTextField.textColor = color;
    self.passwordTextField.textColor = color;
    
    userNameTextField.text = @"usermap1";
    passwordTextField.text = @"password123";

}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void) keyboardWillShow:(NSNotification *)note {
    
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGFloat duration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        logContentViewVerticalyCenter.constant = 50;
    }else{
        logContentViewVerticalyCenter.constant = -12;
    }
    // commit animations
    [UIView commitAnimations];
}

- (void) keyboardWillHide:(NSNotification *)note {
    //CGFloat duration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    double hdDuration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    int curve = [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    // slide view down
    [UIView beginAnimations:@"foo" context:nil];
    [UIView setAnimationDuration:hdDuration];
    [UIView setAnimationCurve:curve];
    logContentViewVerticalyCenter.constant = -12;
    
    [UIView commitAnimations];
    
    
}


-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}
- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

-(IBAction)loginButtonTapped:(id)sender
{
    AppDelegate *appDg =(AppDelegate *) [[UIApplication sharedApplication] delegate];

    DataClass *commonData = [[DataClass alloc] init];
    commonData.isApiCalled=1;
    [pref setInteger:1 forKey:@"LoggedInState"];
    NSLog(@"Latitude %f, Longitude %f",appDg.locManager.location.coordinate.latitude, appDg.locManager.location.coordinate.longitude );
//    NSString *latitude = [NSNumber numberWithFloat:appDg.locManager.location.coordinate.latitude].stringValue;
//    NSString *longitude = [NSNumber numberWithFloat:appDg.locManager.location.coordinate.longitude].stringValue;
    NSString *latitude = [NSString stringWithFormat: @"%f", appDg.locManager.location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat: @"%f", appDg.locManager.location.coordinate.longitude];

   // NSLog(@"Latitude %@, Longitude %@",latitude, longitude );

    NSDictionary *params = @{@"user_name" : userNameTextField.text,
                             @"password" : passwordTextField.text,
                             @"lat":latitude,
                             @"lon" : longitude};
    
    
    [commonData apiCall:params method:@"POST" completionHandler:^(id response, NSError *error)
     {
         if (error)
         {
             NSLog(@"API Error : %@", error);
         }
         
         else
         {
             NSLog(@"API Response : %@", response);
             int status =[[response valueForKey:@"status"] intValue];
             
             if (status==1)
             {
                 [pref setBool:YES forKey:@"isLogedin"];
                 [self alertStatus:@"Login Successful." :nil];

                 
                 NSDictionary *responceFromSvr = [response objectForKey:@"response"];
                 //NSLog(@"All User info = %@",[responceFromSvr objectForKey:@"all_user_info"]);
                // NSLog(@"User info = %@",[responceFromSvr objectForKey:@"user_info"]);
                 NSDictionary *userInfo = [responceFromSvr objectForKey:@"user_info"];
                 appDg.nearByUserArray = [responceFromSvr objectForKey:@"all_user_info"];
                // NSLog(@"nearByUserArray = %@",appDg.nearByUserArray);

                 
                 NSString *uName = [userInfo objectForKey:@"user_name"];
                 NSString *eMail = [userInfo objectForKey:@"email"];
                 NSString *gender = [userInfo objectForKey:@"gender"];
                 NSString *dob = [userInfo objectForKey:@"date_of_birth"];
                 [pref setValue:uName forKey:@"UserName"];
                 [pref setValue:eMail forKey:@"EmailId"];
                 [pref setValue:gender forKey:@"Gender"];
                 [pref setValue:dob forKey:@"DateOfBirth"];
                 [pref setValue:@"5" forKey:@"MapRadious"];
                 [pref synchronize];
                 commonData.isApiCalled=1;

                 StepOneViewController *sVC  = [[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];
                
                 [self.revealSideViewController popViewControllerWithNewCenterController:sVC  animated:YES];
             }
             else
             {
                 
                 UIAlertView *alert = [[UIAlertView alloc]
                                       initWithTitle:@"Login Failed!"
                                       message:@"Wrong user name or password."
                                       delegate:self
                                       cancelButtonTitle:@"Ok"
                                       otherButtonTitles:nil];
                 [alert show];
             }
         }
         
     }];

    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backButtonTapped:(id)sender{
    //[self.navigationController popViewControllerAnimated:YES];
    LandingViewController *lVC  = [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];
    [self.revealSideViewController popViewControllerWithNewCenterController:lVC  animated:YES];

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
