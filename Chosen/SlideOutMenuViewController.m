//
//  SlideOutMenuViewController.m
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "SlideOutMenuViewController.h"
#import "WorldMapViewController.h"
#import "SettingsViewController.h"
#import "TournamentViewController.h"
#import "LandingViewController.h"
#import "SelectRadiusViewController.h"
#import "STTwitter.h"
NSUserDefaults *pref;
@interface SlideOutMenuViewController ()
@property (nonatomic, strong) STTwitterAPI *twitter;

@end

@implementation SlideOutMenuViewController
@synthesize trainingTimeLeftLabel, trainingTimeLeftValueLabel, lastBatttleLabel, lastBatttValueleLabel;
@synthesize worldButton, guildButton, contractButton, tournamentButton, settingsButton, loggedInUser;
FBLoginView *fbLoginView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.guildButton.selected = NO;
    pref = [NSUserDefaults standardUserDefaults];


    // Do any additional setup after loading the view from its nib.
    self.trainingTimeLeftLabel.font = [UIFont fontWithName:@"Garamond" size:11];
    self.trainingTimeLeftValueLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    self.lastBatttleLabel.font = [UIFont fontWithName:@"Garamond" size:12];
    self.lastBatttValueleLabel.font = [UIFont fontWithName:@"Garamond" size:13];

}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (IBAction)logoutButtonTapped:(id)sender {
    
    NSInteger loginFromStatus = [[pref valueForKey:@"LoggedInState"] intValue];
    NSLog(@"Status %ld", (long)loginFromStatus);
    [pref setBool:NO forKey:@"isLogedin"];
    [pref setValue:@"" forKey:@"UserName"];
    [pref setValue:@"" forKey:@"EmailId"];
    [pref setValue:@"" forKey:@"Gender"];
    [pref setValue:@"" forKey:@"DateOfBirth"];
    [pref synchronize];
    if (loginFromStatus == 1) {
       
        LandingViewController *lVC  = [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];
        [self.revealSideViewController popViewControllerWithNewCenterController:lVC  animated:YES];
        [pref setInteger:0 forKey:@"LoggedInState"];
        
        
    }else if (loginFromStatus == 2){
        [fbLoginView.subviews[0] sendActionsForControlEvents:UIControlEventTouchUpInside];
        self.loggedInUser = nil;
        
        [FBSession.activeSession closeAndClearTokenInformation];
        [FBSession.activeSession close];
        [FBSession setActiveSession:nil];
        
        if(FBSession.activeSession.isOpen)
        {
            
        }
        else
        {

            [pref setInteger:0 forKey:@"LoggedInState"];
            [pref synchronize];

            LandingViewController *lVC  = [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];
            [self.revealSideViewController popViewControllerWithNewCenterController:lVC  animated:YES];
            
            
        }
        
    }else{
        [pref setInteger:0 forKey:@"LoggedInState"];
        self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:nil
                                                     consumerSecret:nil];
        
        LandingViewController *lVC  = [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];
        [self.revealSideViewController popViewControllerWithNewCenterController:lVC  animated:YES];

    }
    
    

}

-(IBAction)backButtonTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)menuButtonTapped:(id)sender{
    
    self.worldButton.selected = NO;
    self.guildButton.selected = NO;
    self.contractButton.selected = NO;
    self.tournamentButton.selected = NO;
    self.settingsButton.selected = NO;
    UIButton *button=(UIButton*)sender;
    button.selected = YES;
    if (button.tag == 1)
    {
        WorldMapViewController *wMVC  = [[WorldMapViewController alloc] initWithNibName:@"WorldMapViewController" bundle:nil];
        [self.revealSideViewController popViewControllerWithNewCenterController:wMVC  animated:YES];

        
    }else if (button.tag == 2)
    {
        GuildViewController *gVC  = [[GuildViewController alloc] initWithNibName:@"GuildViewController" bundle:nil];
    [self.revealSideViewController popViewControllerWithNewCenterController:gVC  animated:YES];
        
        
    }
    else if (button.tag == 4)
    {
       /* TournamentViewController *tVC  = nil;
        if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
            //For Iphone4
            tVC = [[TournamentViewController alloc] initWithNibName:@"TournamentViewController_iPhone4" bundle:nil];
            // NSLog(@"iPhone4");
        }else{
            tVC =  [[TournamentViewController alloc] initWithNibName:@"TournamentViewController" bundle:nil];
            
            //  NSLog(@"iPhone6");
            
        }
        [self.revealSideViewController popViewControllerWithNewCenterController:tVC  animated:YES];*/
        
        SelectRadiusViewController *tdVC  = [[SelectRadiusViewController alloc] initWithNibName:@"SelectRadiusViewController" bundle:nil];
        [self.revealSideViewController popViewControllerWithNewCenterController:tdVC  animated:YES];
        

        
        
    }else if (button.tag == 5)
    {
        SettingsViewController *sVC  = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];;
        [self.revealSideViewController popViewControllerWithNewCenterController:sVC  animated:YES];
        
        
    }



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
