//
//  SelectRadiusViewController.h
//  Chosen
//
//  Created by AppsbeeTechnology on 14/01/15.
//  Copyright (c) 2015 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectRadiusViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *navTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *playeNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UIButton *radiousButton;
-(IBAction)slideMenuButtonTapped:(id)sender;
-(IBAction)backButtonTapped:(id)sender;

@end
