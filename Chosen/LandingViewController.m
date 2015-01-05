//
//  LandingViewController.m
//  Chosen
//
//  Created by appsbee on 15/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "LandingViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Context.h"

@interface LandingViewController ()

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(IBAction)loginButtonTapped:(id)sender
{
    LoginViewController *lVC  = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
       lVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone4" bundle:nil];
       // NSLog(@"iPhone4");
    }else{
        lVC =  [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];;
        
      //  NSLog(@"iPhone6");
        
    }
    [self.navigationController pushViewController:lVC animated:YES];

    
}
-(IBAction)registerButtonTapped:(id)sender
{
    RegisterViewController *rVC  = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        rVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController_iPhone4" bundle:nil];
        // NSLog(@"iPhone4");
    }else{
        rVC =  [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];;
        
        //  NSLog(@"iPhone6");
        
    }
    [self.navigationController pushViewController:rVC animated:YES];

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
