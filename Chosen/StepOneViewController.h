//
//  StepOneViewController.h
//  Chosen
//
//  Created by appsbee on 17/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepOneViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *helpLabel;
@property (nonatomic, strong) IBOutlet UILabel *stepLabel;
-(IBAction)backButtonTapped:(id)sender;
-(IBAction)nextButtonTapped:(id)sender;
-(IBAction)skipButtonTapped:(id)sender;

@end
