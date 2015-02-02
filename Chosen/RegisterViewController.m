//
//  RegisterViewController.m
//  Chosen
//
//  Created by appsbee on 17/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "RegisterViewController.h"
#import "Context.h"
#import "StepOneViewController.h"
#import "LandingViewController.h"
#import "DataClass.h"
NSUserDefaults *pref;

@interface RegisterViewController (){
    
       CGFloat animatedDistance;
    CGFloat duration;
    CGRect keyboardBounds;
    CGRect actuallRect ;


}
@property (nonatomic, strong) NSString *genderString;
@property (nonatomic, strong) UIDatePicker *dateatePickerView;
@property (nonatomic, strong) UIView *datePickerEditView;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * regContentViewVerticalyCenter;


@end

@implementation RegisterViewController
@synthesize regContentView, userNameTextField, passwordTextField, conformPasswordTextField,dobTextField,emailTextField, maleButton, femaleButton, navTitle, genderString, regContentViewVerticalyCenter;
int UserID, registrationStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    pref = [NSUserDefaults standardUserDefaults];

    self.maleButton.selected = YES;
    self.genderString = @"1";
    self.userNameTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.passwordTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.conformPasswordTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.dobTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.emailTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        self.navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        
    }else{
        self.navTitle.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
        
        //  NSLog(@"iPhone6");
        
    }

    
    UIColor *color = [UIColor colorWithRed:202.0f/255.0f green:230.0f/255.0f blue:233.0f/255.0f alpha:1.0f];
    self.userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    self.conformPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"conform Password" attributes:@{NSForegroundColorAttributeName: color}];
    self.dobTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Dat of Birth" attributes:@{NSForegroundColorAttributeName: color}];
    self.emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName: color}];
    self.userNameTextField.textColor = color;
    self.passwordTextField.textColor = color;
    self.conformPasswordTextField.textColor = color;
    self.dobTextField.textColor = color;
    self.emailTextField.textColor = color;
    if (self.dateatePickerView == nil) {
        UIDatePicker * aPick = nil;
        if (![[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
            // Iphone 6
            aPick  = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 451, 320, 216)];
        } else {
            // Iphone 4
            aPick  = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 264, 320, 216)];
            aPick.backgroundColor = [UIColor grayColor];
        }
        
        [aPick setDatePickerMode:UIDatePickerModeDate];
        [aPick addTarget:self action:@selector(dateLabelChanged:) forControlEvents:UIControlEventValueChanged];
        self.dateatePickerView = aPick;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];


    

    
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(IBAction)backButtonTapped:(id)sender{
    LandingViewController *lVC  = [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];
    [self.revealSideViewController popViewControllerWithNewCenterController:lVC  animated:YES];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
- (void) keyboardWillShow:(NSNotification *)note {
    // get keyboard size and loctaion
    
    
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    //NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    duration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    NSLog(@"%f",keyboardBounds.size.height);
    
    // get a rect for the textView frame
    CGRect containerFrame = self.regContentView.frame;
    actuallRect = self.regContentView.frame;
    NSLog(@"login content view frame = %f  %f",containerFrame.origin.y , containerFrame.size.height);
    
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + self.regContentView.frame.size.height);
    
    NSLog(@"login content view frame = %f  %f",containerFrame.origin.y , containerFrame.size.height);
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        regContentViewVerticalyCenter.constant = 100;
    }else{
        regContentViewVerticalyCenter.constant = 130;
    }

    self.regContentView.frame = containerFrame;
    
    
    // commit animations
    [UIView commitAnimations];
}

- (void) keyboardWillHide:(NSNotification *)note {
    duration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    double hdDuration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    int curve = [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    // slide view down
    [UIView beginAnimations:@"foo" context:nil];
    [UIView setAnimationDuration:hdDuration];
    [UIView setAnimationCurve:curve];
    self.regContentView.frame = actuallRect ;
    regContentViewVerticalyCenter.constant = 0;

    [UIView commitAnimations];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)maleFemaleButtonTapped:(id)sender{
    
    if (sender == maleButton)
    {
        maleButton.selected = YES;
        femaleButton.selected = NO;
        self.genderString = @"1";
    }else if (sender == femaleButton){
        maleButton.selected = NO;
        femaleButton.selected = YES;
        self.genderString = @"2";

    }
   // NSLog(@"Gender = %@", genderString);
    
    
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
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
-(BOOL) NSStringIsValidPassword:(NSString *)checkString
{
    BOOL digit = false;
    if([checkString length] >= 8)
    {
        
        for (int i = 0; i < [checkString length]; i++)
        {
            unichar c = [checkString characterAtIndex:i];
            if(!digit)
            {
                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
            }

        }
        if (digit) {
            return YES;

        }else{
            [self alertStatus:@"Your password must contain at least one number and one upper or lowercase letter" :@"Registration Failed!"];

        }
        /*NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
        if ([checkString rangeOfCharacterFromSet:set].location == NSNotFound && !digit)
        {
            NSLog(@"NO SPECIAL CHARACTER");
            [self alertStatus:@"Your password must contain at least one number and one upper or lowercase letter" :@"Registration Failed!"];

        }
        else
        {
            NSLog(@"HAS SPECIAL CHARACTER");
            return YES;
            
        }*/
        
    }
    else
    {
        [self alertStatus:@"Your password must be 8 characters long." :@"Registration Failed!"];
    }
    
    return NO;
}


-(IBAction)submitButtonTapped:(id)sender
{
    if (self.userNameTextField.text.length == 0 || self.passwordTextField.text.length == 0 || self.genderString.length == 0 || dobTextField == 0 || emailTextField.text.length == 0 )
    {
        [self alertStatus:@"All Fields are mandatory." :@"Registration Failed!"];
        
    }
    else
    {
        if(![self NSStringIsValidPassword:[self.passwordTextField text]])
        {
            //[self alertStatus:@"Your password must contain at least one numeric number or one special character." :@"Registration Failed!"];
        }else if (![self.passwordTextField.text isEqualToString:self.conformPasswordTextField.text]) {
            [self alertStatus:@"The password entered does not match the confirmation password." :@"Registration Failed!"];

        }else if(![self NSStringIsValidEmail:[self.emailTextField text]])
        {
            [self alertStatus:@"Please enter valid Email ID" :@"Registration Failed!"];
        }
        else
        {

            StepOneViewController *sVC  = [[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];;
            DataClass *commonData = [[DataClass alloc] init];

            commonData.isLoginButtonClicked =NO;
            [pref setInteger:1 forKey:@"LoggedInState"];

            NSDictionary *params = @{@"user_name" : userNameTextField.text,
                                     @"password" : passwordTextField.text,
                                     @"gender" : genderString,
                                     @"email" : emailTextField.text,
                                     @"date_of_birth" : dobTextField.text};
            
            
            //[self.activityIndicatorView startAnimating];
            
        
        [commonData apiCall:params method:@"POST" completionHandler:^(id response, NSError *error)
         {
             
             
             if (error) {
                 NSLog(@"API Error : %@", error);
             }
             
             else
             {
                 NSLog(@"Register API Response : %@", response);
                  registrationStatus =[[response valueForKey:@"status"] intValue];
                 
                 if (registrationStatus==1)
                 {
                     [self alertStatus:@"Registration Successful." :nil];
                     
                     commonData.isLoginButtonClicked=YES;
                     [pref setInteger:1 forKey:@"LoggedInState"];
                     
                     
                     NSDictionary *params2 = @{@"user_name" : userNameTextField.text,
                                               @"password" : passwordTextField.text};
                     
                     
                     [commonData apiCall:params2 method:@"POST" completionHandler:^(id response, NSError *error)
                      {
                          if (error)
                          {
                              NSLog(@"API Error : %@", error);
                          }
                          
                          else
                          {
                              NSLog(@"Login API Response : %@", response);
                              int status2 =[[response valueForKey:@"status"] intValue];
                              
                              if (status2==1)
                              {
                                  [pref setBool:YES forKey:@"isLogedin"];

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
                                  
                                  commonData.isLoginButtonClicked=NO;
                                  [self.revealSideViewController popViewControllerWithNewCenterController:sVC  animated:YES];
                              }
                          }
                          
                      }];


                     //[self.revealSideViewController popViewControllerWithNewCenterController:sVC  animated:YES];
                 }
                 else if ([[response valueForKey:@"error"] isEqualToString:@"Username already exists."]){
                     [self alertStatus:@"User name already exists." :@"Registration Failed!"];

                 }else if ([[response valueForKey:@"error"] isEqualToString:@"Email address already exists"]){
                     [self alertStatus:@"User name already exists." :@"Registration Failed!"];
                     
                 }
                 else
                 {
                     
                     UIAlertView *alert = [[UIAlertView alloc]
                                           initWithTitle:@"Registration Failed!"
                                           message:@"OOPS! Something went wrong. Please try again!"
                                           delegate:self
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles:nil];
                     [alert show];
                 }
             }
             
         }];

        
    }
}
    
    
}
-(IBAction)dobButtonClicked:(id)sender;
{
    //[self.currentTextFieldResponder resignFirstResponder];
    
  //  self.seletedDateButtonString = START_DATE_BUTTON_CLICKED_KEY;
    
    [self launchDatePicker];
    
    if ((self.dobTextField.text == nil) || ([self.dobTextField.text length] <= 0)) {
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM-dd-yyyy"];
        
        NSString *formattedDateString  = [df stringFromDate:[NSDate date]];
        self.dobTextField.text = formattedDateString;
    }
    
}
-(void)launchDatePicker
{
    
    if (self.datePickerEditView == nil) {
        NSLog(@"viewFrame:%f,%f",self.view.frame.origin.x, self.view.frame.origin.y);
        UIView * uv = [[UIView alloc] initWithFrame:self.view.frame];
        NSLog(@"ed vi y:%f, h = %f",uv.frame.origin.y,uv.frame.size.height);

        uv.backgroundColor = [UIColor clearColor];
        self.datePickerEditView = uv;
        
        UIToolbar *assignmentStartToolBar =  nil;
        if (![[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
            // Iphone 5
            assignmentStartToolBar  = [[UIToolbar alloc] initWithFrame:CGRectMake(0,407,375,44)];
        } else {
            // Iphone 4
            assignmentStartToolBar  = [[UIToolbar alloc] initWithFrame:CGRectMake(0,220,320,44)];
        }
        //        if ([assignmentStartToolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        //            UIImage *aImage = [[UIImage imageNamed:@"NavigationBar_BgImage"] stretchableImageWithLeftCapWidth:6 topCapHeight:6];
        //            [[UIToolbar appearance] setBackgroundImage:aImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        //        }
        
        [assignmentStartToolBar setBarStyle:UIBarStyleBlackOpaque];
        assignmentStartToolBar.tintColor = [UIColor blackColor];
        self.dateatePickerView.backgroundColor = [UIColor whiteColor];
        
        
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(assignmentStartDateDoneButtonTapped)];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        assignmentStartToolBar.items = [NSArray arrayWithObjects:flex, barButtonDone,nil];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        barButtonDone.tintColor=[UIColor whiteColor];
#endif
        
        [self.datePickerEditView addSubview:self.dateatePickerView];
        [self.datePickerEditView addSubview:assignmentStartToolBar];
        NSLog(@"ed vi y:%f, h = %f",self.dateatePickerView.frame.origin.y,self.dateatePickerView.frame.size.height);

        
    }
    
    [self.view addSubview:self.datePickerEditView];
    
}
-(void)dateLabelChanged:(id)sender{
    NSDate *date = self.dateatePickerView.date;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    NSString *formattedDateString = [df stringFromDate:date];
    self.dobTextField.text = formattedDateString;
    
    NSLog(@"Dob = %@", self.dobTextField.text);
    
}
-(void)assignmentStartDateDoneButtonTapped{
    
    [self.datePickerEditView removeFromSuperview];
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
