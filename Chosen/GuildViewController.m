//
//  GuildViewController.m
//  Chosen
//
//  Created by appsbee on 18/12/14.
//  Copyright (c) 2014 appsbee. All rights reserved.
//

#import "GuildViewController.h"
#import "PPRevealSideViewController.h"
#import "SlideOutMenuViewController.h"
#import "LandingViewController.h"
#import "Context.h"
#import "Guilds.h"

@interface GuildViewController (){
    UIPageControl *pageControl;
    CGFloat _offset;


}
@property (nonatomic, strong) NSMutableDictionary *guildDictionary;
@property (nonatomic, strong) NSArray *guildImageArray;
@property (nonatomic, strong) NSArray *guildsArray;

@end

@implementation GuildViewController
@synthesize guildDictionary, guildImageArray, guildsArray, damageSlider, accurancySlider;
@synthesize nextButton, previousButton, nabImgView, gNameLabel, cNameLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _offset = 50;
    [accurancySlider setMinimumTrackImage: [UIImage imageNamed:@"steps2_progress_bar_iph6.png"] forState: UIControlStateNormal];
    [accurancySlider setMaximumTrackImage: [UIImage imageNamed:@"steps_nav_bg_iphn6.png"] forState: UIControlStateNormal];
   // self.accurancySlider.thumbTintColor = [UIColor redColor];
   // [self.accurancySlider setThumbTintColor:[UIColor redColor]];
    self.guildImageArray = [NSArray arrayWithObjects:@"image1",@"image2", @"image3", @"image4", @"image5",@"image6", nil];

    Guilds *guild1 = [Guilds new];
    guild1.image = @"image1";
    guild1.name = @"MEDIEVAL";
    guild1.star = @"starOne";
    Guilds *guild2 = [Guilds new];
    guild2.image = @"image2";
    guild2.name = @"REBELLION";
    guild2.star = @"starTwo";
    Guilds *guild3 = [Guilds new];
    guild3.image = @"image3";
    guild3.name = @"ABSURDITY";
    guild3.star = @"starThree";
    Guilds *guild4 = [Guilds new];
    guild4.image = @"image4";
    guild4.name = @"TIME KNIGHT";
    guild4.star = @"starTwo";
    Guilds *guild5 = [Guilds new];
    guild5.image = @"image5";
    guild5.name = @"BEL FRONT";
    guild5.star = @"starOne";
    Guilds *guild6 = [Guilds new];
    guild6.image = @"image6";
    guild6.name = @"UNDEAD";
    guild6.star = @"starFour";
    self.guildsArray = [NSArray arrayWithObjects:guild1, guild2, guild3, guild4, guild5, guild6, nil];
    
    // pagingView
    InfinitePagingView *pagingView = [[InfinitePagingView alloc] init];
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        pagingView.frame = CGRectMake(0.f, 50, self.view.frame.size.width, 150.f);
        pagingView.pageSize = CGSizeMake(320.f, self.view.frame.size.height);
        self.gNameLabel.font = [UIFont fontWithName:@"Garamond" size:20];
    }else{
        pagingView.frame = CGRectMake(0.f, 50, self.view.frame.size.width, 260.f);
        pagingView.pageSize = CGSizeMake(375.f, self.view.frame.size.height);
        self.gNameLabel.font = [UIFont fontWithName:@"Garamond" size:24];
        
    }
    pagingView.delegate = self;
    pagingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pagingView];
    
    for (Guilds *gObj in guildsArray) {
        //NSLog (@"%@: %@", key, [guildDictionary objectForKey: key]);
        UIImage *image = [UIImage imageNamed:gObj.image];
        UIImageView *page = [[UIImageView alloc] initWithImage:image];
        page.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, pagingView.frame.size.height);
        page.contentMode = UIViewContentModeScaleAspectFit;
        [pagingView addPageView:page];
    }
   // [pagingView addPageViewDic:guildDictionary];

    

    [previousButton addTarget:pagingView action:@selector(scrollToPreviousPage) forControlEvents:UIControlEventTouchUpInside];

     [nextButton addTarget:pagingView action:@selector(scrollToNextPage) forControlEvents:UIControlEventTouchUpInside];

    // Page controller
    pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:60.0f/255.0f green:59.0f/255.0f blue:57.0f/255.0f alpha:1.0f];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:110.0f/255.0f green:207.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        pageControl.center = CGPointMake(self.view.center.x, 192);
    }else{
        pageControl.center = CGPointMake(self.view.center.x, 280);
        
    }
    pageControl.numberOfPages = 6;
    
    [self.view addSubview:pageControl];
    
    
    // for ios 7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
#pragma mark - InfinitePagingViewDelegate

- (void)pagingView:(InfinitePagingView *)pagingView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex
{
    Guilds *guild = [guildsArray objectAtIndex:pageIndex];
    pageControl.currentPage = pageIndex;
    gNameLabel.text = guild.name;
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(IBAction)backButtonTapped:(id)sender{
    //[self.navigationController popViewControllerAnimated:YES];
    LandingViewController *sVC  = nil;
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        sVC = [[LandingViewController alloc] initWithNibName:@"LandingViewController_iPhone4" bundle:nil];
        // NSLog(@"iPhone4");
    }else{
        sVC =  [[LandingViewController alloc] initWithNibName:@"LandingViewController" bundle:nil];;
        
        //  NSLog(@"iPhone6");
        
    }
    [self.navigationController pushViewController:sVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
