//
//  SlideOutMenuViewController.m
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "SlideOutMenuViewController.h"
#import "SettingsViewController.h"
#import "TournamentViewController.h"

@interface SlideOutMenuViewController ()

@end

@implementation SlideOutMenuViewController
@synthesize trainingTimeLeftLabel, trainingTimeLeftValueLabel, lastBatttleLabel, lastBatttValueleLabel;
@synthesize worldButton, guildButton, contractButton, tournamentButton, settingsButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.guildButton.selected = NO;

    // Do any additional setup after loading the view from its nib.
    self.trainingTimeLeftLabel.font = [UIFont fontWithName:@"Garamond" size:11];
    self.trainingTimeLeftValueLabel.font = [UIFont fontWithName:@"Garamond" size:13];
    self.lastBatttleLabel.font = [UIFont fontWithName:@"Garamond" size:12];
    self.lastBatttValueleLabel.font = [UIFont fontWithName:@"Garamond" size:13];

}
- (BOOL)prefersStatusBarHidden {
    return YES;
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
    if (button.tag == 1) {
        
    }else if (button.tag == 2){
        GuildViewController *gVC  = nil;
        if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
            //For Iphone4
            gVC = [[GuildViewController alloc] initWithNibName:@"GuildViewController_iPhone4" bundle:nil];
            // NSLog(@"iPhone4");
        }else{
            gVC =  [[GuildViewController alloc] initWithNibName:@"GuildViewController" bundle:nil];
            
            //  NSLog(@"iPhone6");
            
        }
        [self.revealSideViewController popViewControllerWithNewCenterController:gVC  animated:YES];
        
        
    }else if (button.tag == 4){
        TournamentViewController *tVC  = nil;
        if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
            //For Iphone4
            tVC = [[TournamentViewController alloc] initWithNibName:@"TournamentViewController_iPhone4" bundle:nil];
            // NSLog(@"iPhone4");
        }else{
            tVC =  [[TournamentViewController alloc] initWithNibName:@"TournamentViewController" bundle:nil];
            
            //  NSLog(@"iPhone6");
            
        }
        [self.revealSideViewController popViewControllerWithNewCenterController:tVC  animated:YES];
        
        
    }else if (button.tag == 5){
        SettingsViewController *sVC  = nil;
        if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
            //For Iphone4
            sVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPhone4" bundle:nil];
            // NSLog(@"iPhone4");
        }else{
            sVC =  [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
            
            //  NSLog(@"iPhone6");
            
        }
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
