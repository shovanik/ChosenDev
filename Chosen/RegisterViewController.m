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

@interface RegisterViewController (){
    
       CGFloat animatedDistance;

}
@property (nonatomic, retain) UIDatePicker *dateatePickerView;
@property (nonatomic, retain) UIView *datePickerEditView;


@end

@implementation RegisterViewController
@synthesize regContentView, userNameTextField, passwordTextField, conformPasswordTextField,dobTextField,emailTextField, maleButton, femaleButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userNameTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.passwordTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.conformPasswordTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.dobTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    self.emailTextField.font = [UIFont fontWithName:@"Garamond" size:17];
    
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


    

    
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(IBAction)backButtonTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 180;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[[textField textInputTraits] setValue:[UIColor greenColor] forKey:@"insertionPointColor"];
    CGRect textFieldRect = [regContentView.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [regContentView.window convertRect:regContentView.bounds fromView:regContentView];
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
    CGRect viewFrame = regContentView.frame;
    viewFrame.origin.y -= animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [regContentView setFrame:viewFrame];
    [UIView commitAnimations];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = regContentView.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [regContentView setFrame:viewFrame];
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)maleFemaleButtonTapped:(id)sender{
    
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)submitButtonTapped:(id)sender
{
    StepOneViewController *sVC  = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        sVC = [[StepOneViewController alloc] initWithNibName:@"StepOneViewController_iPhone4" bundle:nil];
        // NSLog(@"iPhone4");
    }else{
        sVC =  [[StepOneViewController alloc] initWithNibName:@"StepOneViewController" bundle:nil];;
        
        //  NSLog(@"iPhone6");
        
    }
    [self.navigationController pushViewController:sVC animated:YES];
    
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
    [df setDateFormat:@"MM-dd-yyyy"];
    NSString *formattedDateString = [df stringFromDate:date];
    self.dobTextField.text = formattedDateString;
    /*if (([self.seletedDateButtonString caseInsensitiveCompare:START_DATE_BUTTON_CLICKED_KEY]) == NSOrderedSame) {
        self.assignmentStartDateTextField.text = formattedDateString;
    } else if (([self.seletedDateButtonString caseInsensitiveCompare:END_DATE_BUTTON_CLICKED_KEY]) == NSOrderedSame) {
        self.assignmentProjectEndDateTextField.text = formattedDateString;
    }*/
    
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
