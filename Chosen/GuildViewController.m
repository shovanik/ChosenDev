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
#import "Context.h"

@interface GuildViewController (){
    UIPageControl *pageControl;
    CGFloat _offset;


}
@property (nonatomic, strong) NSArray *guildArray;

@end

@implementation GuildViewController
@synthesize guildArray;
@synthesize nextButton, previousButton, nabImgView, gNameLabel, cNameLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _offset = 50;
    //self.guildArray = [[NSMutableArray alloc] initWithObjects:@"One", @"Two", nil];


    InfinitePagingView *pagingView = [[InfinitePagingView alloc] init];
    // pagingView
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        pagingView.frame = CGRectMake(0.f, 50, self.view.frame.size.width, 150.f);
        pagingView.pageSize = CGSizeMake(320.f, self.view.frame.size.height);
        self.gNameLabel.font = [UIFont fontWithName:@"Garamond" size:20];


        // NSLog(@"iPhone4");
    }else{
        pagingView.frame = CGRectMake(0.f, 50, self.view.frame.size.width, 260.f);
        pagingView.pageSize = CGSizeMake(375.f, self.view.frame.size.height);
        self.gNameLabel.font = [UIFont fontWithName:@"Garamond" size:24];

        //  NSLog(@"iPhone6");
        
    }
    pagingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pagingView];
    //[self.view bringSubviewToFront:nabImgView];
    // Page controller
    pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:60.0f/255.0f green:59.0f/255.0f blue:57.0f/255.0f alpha:1.0f];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:110.0f/255.0f green:207.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    
        for (NSUInteger i = 1; i <= 6; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
        UIImageView *page = [[UIImageView alloc] initWithImage:image];
        //page.backgroundColor = [UIColor whiteColor];
        page.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, pagingView.frame.size.height);
        page.contentMode = UIViewContentModeScaleAspectFit;
        [pagingView addPageView:page];

    }
    

    [previousButton addTarget:pagingView action:@selector(scrollToPreviousPage) forControlEvents:UIControlEventTouchUpInside];

     [nextButton addTarget:pagingView action:@selector(scrollToNextPage) forControlEvents:UIControlEventTouchUpInside];
    // pagingView
    if ([[Context getInstance] screenPhysicalSizeForIPhoneClassic]) {
        //For Iphone4
        pageControl.center = CGPointMake(self.view.center.x, 192);
        // NSLog(@"iPhone4");
    }else{
        pageControl.center = CGPointMake(self.view.center.x, 280);
        
        //  NSLog(@"iPhone6");
        
    }
    
    // pageControl.center = CGPointMake(self.view.center.x, pagingView.frame.size.height - 30.f);
    pageControl.numberOfPages = 6;
    //pageControl.currentPage = 3;
    
    [self.view addSubview:pageControl];
    
    
    // for ios 7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
#pragma mark - InfinitePagingViewDelegate

- (void)pagingView:(InfinitePagingView *)pagingView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex
{
    pageControl.currentPage = pageIndex;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(IBAction)backButtonTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
