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
    
    userNameTextField.text = @"chinu.sahu4";
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
