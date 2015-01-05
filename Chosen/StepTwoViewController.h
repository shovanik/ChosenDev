//
//  StepOneViewController.h
//  Chosen
//
//  Created by appsbee on 17/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepTwoViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *helpLabel;
@property (nonatomic, strong) IBOutlet UIButton *cancelbutton;
@property (nonatomic, strong) IBOutlet UIButton *playButton;
-(IBAction)backButtonTapped:(id)sender;
-(IBAction)playButtonTapped:(id)sender;

@end
