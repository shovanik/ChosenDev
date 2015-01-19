//
//  SelectRadiusViewController.m
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import "SelectRadiusViewController.h"
#import "Context.h"
#import "SlideOutMenuViewController.h"
#import "AddTournamentViewController.h"

@interface SelectRadiusViewController (){
    CGFloat _offset;

}

@end

@implementation SelectRadiusViewController
@synthesize navTitleLabel, playeNameLabel, addressLabel, radiousButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _offset = 50;

    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        // NSLog(@"iPhone4");
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:17];
        self.playeNameLabel.font = [UIFont fontWithName:@"Garamond" size:19];
        self.addressLabel.font = [UIFont fontWithName:@"Garamond" size:15];
        self.radiousButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:18];

    }else{
        
        //  NSLog(@"iPhone6");
        self.navTitleLabel.font = [UIFont fontWithName:@"LithosPro-Regular" size:30];
        self.playeNameLabel.font = [UIFont fontWithName:@"Garamond" size:19];
        self.addressLabel.font = [UIFont fontWithName:@"Garamond" size:15];
        self.radiousButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:21];
        
    }

    
}
-(IBAction)backButtonTapped:(id)sender{
    AddTournamentViewController *tdVC  = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        tdVC = [[AddTournamentViewController alloc] initWithNibName:@"AddTournamentViewController_iPhone4" bundle:nil];
        // NSLog(@"iPhone4");
    }else{
        tdVC =  [[AddTournamentViewController alloc] initWithNibName:@"AddTournamentViewController" bundle:nil];
        
        //  NSLog(@"iPhone6");
        
    }
    [self.revealSideViewController popViewControllerWithNewCenterController:tdVC  animated:YES];
    
}

-(IBAction)slideMenuButtonTapped:(id)sender{
    SlideOutMenuViewController *mVC = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController_iPhone4" bundle:nil ];
    }else{
        mVC = [[SlideOutMenuViewController alloc] initWithNibName:@"SlideOutMenuViewController" bundle:nil ];
        
    }
    mVC.guildButton.selected = YES;
    [self.revealSideViewController pushViewController:mVC onDirection:PPRevealSideDirectionLeft withOffset:_offset animated:YES completion:^{
        PPRSLog(@"This is the end!");
    }];
    PP_RELEASE(mVC);
    
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
