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

@end

@implementation StepOneViewController
@synthesize title, helpLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleLabel.font = [UIFont fontWithName:@"Garamond-Bold" size:14];
    self.helpLabel.font = [UIFont fontWithName:@"Garamond" size:16];

}
-(IBAction)nextButtonTapped:(id)sender{
        StepTwoViewController *sVC  = nil;
        if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
            //For Iphone4
            sVC = [[StepTwoViewController alloc] initWithNibName:@"StepTwoViewController_iPhone4" bundle:nil];
            // NSLog(@"iPhone4");
        }else{
            sVC =  [[StepTwoViewController alloc] initWithNibName:@"StepTwoViewController" bundle:nil];;
            
            //  NSLog(@"iPhone6");
            
        }
        [self.navigationController pushViewController:sVC animated:YES];
    

}
-(IBAction)skipButtonTapped:(id)sender{
    GuildViewController *gVC  = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        gVC = [[GuildViewController alloc] initWithNibName:@"GuildViewController_iPhone4" bundle:nil];
        // NSLog(@"iPhone4");
    }else{
        gVC =  [[GuildViewController alloc] initWithNibName:@"GuildViewController" bundle:nil];
        
        //  NSLog(@"iPhone6");
        
    }
    [self.navigationController pushViewController:gVC animated:YES];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backButtonTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
