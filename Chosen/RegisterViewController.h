//
//  RegisterViewController.h
//  Chosen
//
//  Created by appsbee on 17/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface RegisterViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, strong) IBOutlet UIView *regContentView;
@property (nonatomic, strong) IBOutlet UILabel *navTitle;

@property (nonatomic, strong) IBOutlet UITextField *userNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UITextField *conformPasswordTextField;
@property (nonatomic, strong) IBOutlet UITextField *dobTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UIButton *maleButton;
@property (nonatomic, strong) IBOutlet UIButton *femaleButton;
-(IBAction)maleFemaleButtonTapped:(id)sender;
-(IBAction)backButtonTapped:(id)sender;
-(IBAction)submitButtonTapped:(id)sender;
-(IBAction)dobButtonClicked:(id)sender;
@end
