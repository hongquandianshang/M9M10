//
//  FirstViewController.m
//  食全酒美
//
//  Created by dev dev on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "WineViewController.h"
#import "NearByViewController.h"
#import "CouponViewController.h"
#import "MoreViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize mTabbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
        
}
-(IBAction)Clicked:(id)sender
{
    UIViewController *viewController1 = [[WineViewController alloc] initWithNibName:@"WineViewController" bundle:nil];
    UINavigationController* navController1 = [[UINavigationController alloc]initWithRootViewController:viewController1];
    navController1.navigationBarHidden = YES;
    
    UIViewController *viewController2 = [[NearByViewController alloc] initWithNibName:@"NearByViewController" bundle:nil];
    UINavigationController* navController2 = [[UINavigationController alloc]initWithRootViewController:viewController2];
    
    UIViewController *viewController3 = [[CouponViewController alloc] initWithNibName:@"CouponViewController" bundle:nil];
    UINavigationController* navController3 = [[UINavigationController alloc]initWithRootViewController:viewController3];
    
    
    UIViewController * viewConroller4= [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    UINavigationController* navController4 = [[UINavigationController alloc]initWithRootViewController:viewConroller4];
    
    self.mTabbar = [[CustomTabbar alloc]init];
    self.mTabbar.viewControllers = [NSArray arrayWithObjects:navController1, navController2,navController3,navController4,nil];
    [self.navigationController pushViewController:mTabbar animated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
