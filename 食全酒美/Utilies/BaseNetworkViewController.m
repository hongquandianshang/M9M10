//
//  BaseNetworkViewController.m
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseNetworkViewController.h"
#import "DataHandler.h"
@interface BaseNetworkViewController ()

@end

@implementation BaseNetworkViewController
@synthesize receivedData;
@synthesize mTabbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dataHandler = [DataHandler sharedDataHandler];
        self.receivedData = [NSMutableData dataWithCapacity:512];
        self.mTabbar = (CustomTabbar*)self.tabBarController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //create left back bar btn
    UIButton *BackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 51.0, 31.0)];
    [BackBtn setImage:[UIImage imageNamed:@"BackUnClicked.png"] forState:UIControlStateNormal];
    [BackBtn setImage:[UIImage imageNamed:@"BackClicked.png"] forState:UIControlStateHighlighted];
    [BackBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *BackBarBtn = [[UIBarButtonItem alloc] initWithCustomView:BackBtn];
    BackBarBtn.style=UIBarButtonItemStyleBordered;
    self.navigationItem.leftBarButtonItem = BackBarBtn;
    [BackBtn release];
    [BackBarBtn release];
    // Do any additional setup after loading the view from its nib.
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)setTitle:(NSString *)title{
    // Create a custom title lable
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(60,0,self.view.bounds.size.width-120, 44)];
    view.backgroundColor=[UIColor clearColor];
    
    CGSize size = [title sizeWithFont:[UIFont boldSystemFontOfSize:20] constrainedToSize:CGSizeMake(view.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    if (size.height>view.frame.size.height) {
        MarqueeLabel *rateLabel=[[MarqueeLabel alloc] initWithFrame:CGRectMake(0,0,view.frame.size.width, view.frame.size.height) rate:40.0f andFadeLength:10.0f];
        rateLabel.numberOfLines = 1;
        rateLabel.opaque = NO;
        rateLabel.enabled = YES;
        rateLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        rateLabel.textAlignment = UITextAlignmentLeft;//不会居中
        rateLabel.textColor = [UIColor whiteColor];
        rateLabel.backgroundColor = [UIColor clearColor];
        rateLabel.font = [UIFont boldSystemFontOfSize:20];
        rateLabel.text = title;
        [view addSubview:rateLabel];
        //[rateLabel release];
    }
    else{
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,view.frame.size.width, view.frame.size.height)];
        titleLabel.text = title;
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [view addSubview:titleLabel];
    }
    
    
    self.navigationItem.titleView = view;
}
- (void) hideTabBar:(BOOL) hidden
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
	//NSLog(@"self.tabbarcontroller %@",self.tabBarController);
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, 480-49, view.frame.size.width, view.frame.size.height)];
            }
        } 
        else 
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480-49)];
            }
        }
    }
    
    [UIView commitAnimations];
}
@end
