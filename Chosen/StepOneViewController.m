//
//  StepOneViewController.m
//  Chosen
//
//  Created by appsbee on 17/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "StepOneViewController.h"
#import "Context.h"
#import "StepTwoViewController.h"
#import "SlideOutMenuViewController.h"
#import "GuildViewController.h"
#import "Context.h"


@interface StepOneViewController ()
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * contentWidth;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * contentHeight;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * contentTopBgHeight;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * contentButtomBgHeight;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * bodyTextWidth;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * bodyTextHeight;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * progressButConsHeight;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * skipButtonWidth;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * skipButtonHeight;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * nextButtonWidth;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * nextButtonHeight;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * nextButtonTralingCons;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * skipButtonLead;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * titleLabelLead;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * titleLabelTop;
@property (nonatomic,strong)IBOutlet NSLayoutConstraint * progressWidthCons;

@end

@implementation StepOneViewController

@synthesize title, helpLabel, contentWidth, contentHeight, bodyTextWidth, contentButtomBgHeight, contentTopBgHeight, bodyTextHeight, progressButConsHeight, skipButtonWidth, skipButtonHeight, nextButtonWidth, nextButtonHeight, nextButtonTralingCons, skipButtonLead, stepLabel, titleLabelLead, progressWidthCons, titleLabelTop;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.titleLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:14];
    //self.helpLabel.font = [UIFont fontWithName:@"Garamond" size:16];
  
    if (IsIphone6 ) {
        contentWidth.constant = 315;
        contentHeight.constant = 542;
        bodyTextWidth.constant = 272;
        bodyTextHeight.constant = 300;
        titleLabelLead.constant = 20;
        titleLabelTop.constant = 29;
        self.helpLabel.font = [UIFont fontWithName:@"Garamond" size:18];
        self.stepLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:23];
        self.titleLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:15];


        contentTopBgHeight.constant = 71;
        contentButtomBgHeight.constant = 71;
        progressButConsHeight.constant = 17;
        progressWidthCons.constant = 280;
        
        skipButtonWidth.constant = 131;
        skipButtonHeight.constant = 42;
        skipButtonLead.constant = 18;
        
        nextButtonWidth.constant = 131;
        nextButtonHeight.constant = 42;
        nextButtonTralingCons.constant = 18;

    }
    else if (IsIphone6Plus )
    {
        contentWidth.constant = 348;
        contentHeight.constant = 598;
        bodyTextWidth.constant = 300;
        bodyTextHeight.constant = 331;
        titleLabelLead.constant = 22;
        titleLabelTop.constant = 32;
        self.helpLabel.font = [UIFont fontWithName:@"Garamond" size:20];
        self.stepLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:25];
        self.titleLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:17];
        
        
        contentTopBgHeight.constant = 78;
        contentButtomBgHeight.constant = 78;
        progressButConsHeight.constant = 19;
        progressWidthCons.constant = 309;
        
        skipButtonWidth.constant = 145;
        skipButtonHeight.constant = 46;
        skipButtonLead.constant = 20;
        
        nextButtonWidth.constant = 145;
        nextButtonHeight.constant = 46;
        nextButtonTralingCons.constant = 20;
    }
    else{
        self.helpLabel.font = [UIFont fontWithName:@"Garamond" size:14];
    }
      
}
-(IBAction)nextButtonTapped:(id)sender{
        StepTwoViewController *sVC  = [[StepTwoViewController alloc] initWithNibName:@"StepTwoViewController" bundle:nil];
        [self.revealSideViewController popViewControllerWithNewCenterController:sVC  animated:YES];

}
-(IBAction)skipButtonTapped:(id)sender{
    GuildViewController *gVC  = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        gVC = [[GuildViewController alloc] initWithNibName:@"GuildViewController_iPhone4" bundle:nil];
    }else{
        gVC =  [[GuildViewController alloc] initWithNibName:@"GuildViewController" bundle:nil];
            
    }
    [self.revealSideViewController popViewControllerWithNewCenterController:gVC  animated:YES];

}
- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backButtonTapped:(id)sender{
    //[self.navigationController popViewControllerAnimated:YES];
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
