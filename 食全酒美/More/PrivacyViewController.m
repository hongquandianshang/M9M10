//
//  PrivacyViewController.m
//  食全酒美
//
//  Created by Li XiangCheng on 12-12-4.
//
//

#import "PrivacyViewController.h"

@implementation PrivacyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"服务条款";
    
    CGSize size = [detailLabel.text sizeWithFont:detailLabel.font constrainedToSize:CGSizeMake(detailLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame = detailLabel.frame;
    frame.size=size;
    detailLabel.frame = frame;
    mScrollView.contentSize = CGSizeMake(320, detailLabel.frame.origin.y+detailLabel.frame.size.height+44+15);
}

-(void)viewWillAppear:(BOOL)animated
{
    [self hideTabBar:YES];
    [(CustomTabbar*)self.tabBarController disablebuttons];
    [(CustomTabbar*)self.tabBarController disablebutton];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [(CustomTabbar*)self.tabBarController enablebuttons];
    [(CustomTabbar*)self.tabBarController enablebutton];
    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
