//
//  AddShopViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-20.
//
//

#import "AddShopViewController.h"
#import "ShopCircleViewController.h"
@interface AddShopViewController ()

@end

@implementation AddShopViewController

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
    self.title = @"添加商户";
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem =nil;
    self.navigationItem.leftBarButtonItem =nil;
    
    UIButton *CancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 51.0, 31.0)];
    
    [CancelBtn setImage:[UIImage imageNamed:@"CancelUnClicked.png"] forState:UIControlStateNormal];
    [CancelBtn setImage:[UIImage imageNamed:@"CancelClicked.png"] forState:UIControlStateHighlighted];
    [CancelBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *CancelBarBtn = [[UIBarButtonItem alloc] initWithCustomView:CancelBtn];
    CancelBarBtn.style=UIBarButtonItemStyleBordered;
    
    self.navigationItem.leftBarButtonItem = CancelBarBtn;
    [CancelBtn release];
    [CancelBarBtn release];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 51.0, 31.0)];
    
    [rightBtn setImage:[UIImage imageNamed:@"AddUnClicked.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"AddClicked.png"] forState:UIControlStateHighlighted];
    //[rightBtn addTarget:self action:@selector(AddShop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBarBtn.style=UIBarButtonItemStyleBordered;
    
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [rightBtn release];
    [rightBarBtn release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)ShopCirleClicked:(id)sender
{
    ShopCircleViewController * temp = [[ShopCircleViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
@end
