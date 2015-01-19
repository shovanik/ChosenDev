//
//  SettingsViewController.h
//  Chosen
//
//  Created by appsbee on 19/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController{
    
    
}

@property (nonatomic, strong) IBOutlet UIButton *proSetButton;
@property (nonatomic, strong) IBOutlet UIButton *abtButton;
@property (nonatomic, strong) IBOutlet UIButton *priPoliButton;
@property (nonatomic, strong) IBOutlet UIButton *termsOfUseButton;
-(IBAction)setMenuButtonTapped:(id)sender;

@end
