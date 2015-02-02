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

@end

@implementation LoginViewController
@synthesize userNameTextField, passwordTextField, lgncontentView, navTitle;

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
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        self.navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];

    }else{
        self.navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
        
        //  NSLog(@"iPhone6");
        
    }

    self.userNameTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.userNameTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    
    UIColor *color = [UIColor colorWithRed:202.0f/255.0f green:230.0f/255.0f blue:233.0f/255.0f alpha:1.0f];
    self.userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    self.userNameTextField.textColor = color;
    self.passwordTextField.textColor = color;
    
    userNameTextField.text = @"chinu.sahu4";
    passwordTextField.text = @"password123";

}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 180;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[[textField textInputTraits] setValue:[UIColor greenColor] forKey:@"insertionPointColor"];
    CGRect textFieldRect = [lgncontentView.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [lgncontentView.window convertRect:lgncontentView.bounds fromView:lgncontentView];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = lgncontentView.frame;
    viewFrame.origin.y -= animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [lgncontentView setFrame:viewFrame];
    [UIView commitAnimations];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = lgncontentView.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [lgncontentView setFrame:viewFrame];
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
    DataClass *commonData = [[DataClass alloc] init];
    commonData.isLoginButtonClicked=YES;
    [pref setInteger:1 forKey:@"LoggedInState"];

    
    NSDictionary *params = @{@"user_name" : userNameTextField.text,
                             @"password" : passwordTextField.text};
    
    
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
                 NSDictionary *userInfoDic = [response objectForKey:@"response"];
                 NSString *uName = [userInfoDic objectForKey:@"user_name"];
                 NSString *eMail = [userInfoDic objectForKey:@"email"];
                 NSString *gender = [userInfoDic objectForKey:@"gender"];
                 NSString *dob = [userInfoDic objectForKey:@"date_of_birth"];
                 [pref setValue:uName forKey:@"UserName"];
                 [pref setValue:eMail forKey:@"EmailId"];
                 [pref setValue:gender forKey:@"Gender"];
                 [pref setValue:dob forKey:@"DateOfBirth"];
                 [pref synchronize];

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
