//
//  CouponDetailViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-29.
//
//

#import "CouponDetailViewController.h"

@interface CouponDetailViewController ()

@end

@implementation CouponDetailViewController
@synthesize mCouponId;
@synthesize mCouponInfo;
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
    self.title = @"优惠券详情";
    self.mCouponInfo =[NSMutableDictionary dictionaryWithCapacity:0];
    [dataHandler MyCouponDetailRequestRecord:mCouponId :self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(IBAction)ShareClicked:(id)sender
{
    
}
-(IBAction)CommentClicked:(id)sender
{
    
}
-(void)refreshData
{
    mContentLabel.text = [mCouponInfo objectForKey:@"coupon_content"];
    mShopNameLabel.text = [mCouponInfo objectForKey:@"shop_name"];
    mTitleLabel.text = [mCouponInfo objectForKey:@"event_title"];
    mDownLoadCodeLabel.text = [mCouponInfo objectForKey:@"download_code"];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mCouponInfo  objectForKey:@"coupon_url"]]delegate:self];
    
    int height = 37;
    CGSize size = [mContentLabel.text sizeWithFont:mContentLabel.font constrainedToSize:CGSizeMake(mContentLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mContentLabel.frame = [self ReSizeView:mContentLabel :size :height];
    
    height+= mContentLabel.frame.size.height+10;
    
    shopNameLabel.frame = [self ReSizeView:shopNameLabel :shopNameLabel.frame.size :height];
    
    height+= shopNameLabel.frame.size.height+6;
    
    size = [mShopNameLabel.text sizeWithFont:mShopNameLabel.font constrainedToSize:CGSizeMake(mShopNameLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mShopNameLabel.frame = [self ReSizeView:mShopNameLabel :size :height];
    
    height+= mShopNameLabel.frame.size.height+10;
    
    titleLabel.frame = [self ReSizeView:titleLabel :titleLabel.frame.size :height];
    
    height+= titleLabel.frame.size.height+6;
    
    size = [mTitleLabel.text sizeWithFont:mTitleLabel.font constrainedToSize:CGSizeMake(mTitleLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mTitleLabel.frame = [self ReSizeView:mTitleLabel :size :height];
    
    height+= mTitleLabel.frame.size.height;
    
    mScrollView.contentSize = CGSizeMake(320, height+143);
}
-(CGRect)ReSizeView:(UIView *)view:(CGSize)size:(int)locationY
{
    return CGRectMake(view.frame.origin.x,locationY, size.width, size.height);
}
#pragma mark -
#pragma mark NSURLConnection Delegate
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    isLoading = NO;
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    
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
    mCouponInfo = (NSMutableDictionary*)[dic objectForKey:@"data"];
    isLoading = NO;
    [self refreshData];
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mCouponImageView.image = [UIImage imageWithData:aData];
    }
}
@end
