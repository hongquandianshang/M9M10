//
//  SplashViewController.m
//  CardBump
//
//  Created by 香成 李 on 11-12-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SplashViewController.h"
#import "AppDelegate.h"

@interface SplashViewController (Private)
- (void)fadeScreen;
- (void)finishedFading;
@end

@implementation SplashViewController

@synthesize scrollView,pageControl;

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return [self retain];//class中如果没有执行过[self retain];的方法,那就永远不要在他的内部使用[self release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    curentScrollPage=1;
	[super dealloc];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	//	if ( [[[UIDevice currentDevice] systemVersion] intValue] >= 4 )
	//		[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	UIView* view = [[UIView alloc] initWithFrame: appFrame];
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.view = view;
	[view release];
	
	scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320,480)];
    scrollView.bounces = NO;
    scrollView.bouncesZoom = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    
    scrollView.userInteractionEnabled = YES;
    scrollView.delegate = self;
    
    NSInteger cx = 0;
    int totalGuid=5;
    NSInteger height = scrollView.frame.size.height;
    {
        for (int i = 0; i < totalGuid; i++) {
            
            UIImageView *guideIV = [[UIImageView alloc] init];
            guideIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d.jpg",i + 1]];
            guideIV.contentMode = UIViewContentModeScaleAspectFit;
            //guideIV.frame = CGRectMake(74,156,172,260);
            
            CGRect frame = guideIV.frame;
            frame.size.height = 480;
            frame.origin.x = cx;
            frame.origin.y = 0;
            frame.size.width = 320;
            guideIV.frame = frame;
            
            [scrollView addSubview:guideIV];
            [guideIV release];
            
            cx += scrollView.frame.size.width;
        }
    }
    
    [scrollView setContentSize:CGSizeMake(320 * totalGuid, height)];
    [self.view addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,450,320,30)];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.numberOfPages = totalGuid;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
}

#pragma mark Action

- (void)fadeScreen
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25]; 
	[UIView setAnimationDelegate:self]; 
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];
	self.view.alpha = 0.0;
	[UIView commitAnimations];
}

- (void)finishedFading
{
    [(AppDelegate*)[UIApplication sharedApplication].delegate performSelector:@selector(afterApplicationStart) withObject:nil afterDelay:0.0];
    
	//	if ( [[[UIDevice currentDevice] systemVersion] intValue] >= 4 )
	//		[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [scrollView release];
    [pageControl release];
    
    [self.view removeFromSuperview];
    [self release];
    self = nil; 
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark UIScrollViewDelegate
//滚动中
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    curentScrollPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = curentScrollPage;
}

//滚动开始
// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender{
	if (curentScrollPage == 4) {
        [self fadeScreen];
	}
}

@end
