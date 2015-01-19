//
//  SettingsViewController.m
//  Chosen
//
//  Created by appsbee on 19/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "SettingsViewController.h"
#import "SlideOutMenuViewController.h"
#import "Context.h"

@interface SettingsViewController (){
    CGFloat _offset;

}

@end

@implementation SettingsViewController
@synthesize proSetButton, abtButton, priPoliButton, termsOfUseButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _offset = 50;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)setMenuButtonTapped:(id)sender{
    
    self.proSetButton.selected = NO;
    self.abtButton.selected = NO;
    self.priPoliButton.selected = NO;
    self.termsOfUseButton.selected = NO;
    UIButton *button=(UIButton*)sender;
    button.selected = YES;
    if (button.tag == 1) {
        
    }else if (button.tag == 2){
                
        
    }
    
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
