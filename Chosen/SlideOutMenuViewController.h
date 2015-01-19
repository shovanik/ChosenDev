//
//  SlideOutMenuViewController.h
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuildViewController.h"
#import "Context.h"
@interface SlideOutMenuViewController : UIViewController//<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel *trainingTimeLeftLabel;
@property (nonatomic, strong) IBOutlet UILabel *trainingTimeLeftValueLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastBatttleLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastBatttValueleLabel;
@property (nonatomic, strong) IBOutlet UIButton *worldButton;
@property (nonatomic, strong) IBOutlet UIButton *guildButton;
@property (nonatomic, strong) IBOutlet UIButton *contractButton;
@property (nonatomic, strong) IBOutlet UIButton *tournamentButton;
@property (nonatomic, strong) IBOutlet UIButton *settingsButton;
@property (nonatomic, strong) IBOutlet UITableView *menuTableviewTableView;

-(IBAction)backButtonTapped:(id)sender;

@end
