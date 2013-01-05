//
//  SomeAShopViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-12.
//
//

#import "SomeAShopViewController.h"
#import "ShopDetailViewController.h"
@interface SomeAShopViewController ()

@end

@implementation SomeAShopViewController
@synthesize mDictionary;
@synthesize mShopId;
@synthesize mEventId;
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
    [dataHandler ShopDetailRecord:mShopId:self ];
    // Do any additional setup after loading the view from its nib.
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
-(IBAction)SeeTheShopClicked:(id)sender
{
    ShopDetailViewController * temp = [[ShopDetailViewController alloc]init];
    temp.mShopId = mShopId;
    temp.mEventId = mEventId;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
#pragma mark -
#pragma mark NSURLConnection Delegate
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络出错" message:@"网络无响应，请检查网络并稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    NSString *results = [[NSString alloc]
                         initWithBytes:[receivedData bytes]
                         length:[receivedData length]
                         encoding:NSUTF8StringEncoding];
    NSLog(@"%@",results);
    [receivedData release];
    receivedData=nil;
    self.receivedData=[NSMutableData dataWithCapacity:512];
    NSDictionary *dic=(NSDictionary *)[results JSONValue] ;
    NSDictionary * result = (NSDictionary*)[dic objectForKey:@"data"];
    //NSArray * result = (NSArray*)[dic objectForKey:@"data"];
    mlabel.text = [result objectForKey:@"shop_name"];
//    [mWineArray addObjectsFromArray:result];
//    isLoading = NO;
//    [mTableView reloadData];
    [results release];
}
@end
