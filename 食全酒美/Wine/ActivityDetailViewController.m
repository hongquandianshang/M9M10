//
//  ActivityDetailViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-25.
//
//

#import "ActivityDetailViewController.h"
#import "ShopDetailViewController.h"
#import "CommentForActivityViewController.h"
#import "AppDelegate.h"
@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController
@synthesize mShopId;
@synthesize mEventId;
@synthesize mActivityDetailDic;
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
    mScrollView.contentSize = CGSizeMake(320, 586);
    self.title = @"活动详情";
    self.mActivityDetailDic = [NSDictionary dictionary];
    isLoading = YES;
    [dataHandler EventDetailRequestRecord:mEventId :mShopId :self];
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
-(IBAction)mTabButton1Clicked:(id)sender
{
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        [dataHandler DownloadCouponRequestRecord: mEventId:mShopId :self];
        [self refreshButton:YES :NO :NO :NO];
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=101;
        [av show];
        [av release];
    }
}
-(IBAction)mTabButton2Clicked:(id)sender
{
    [self refreshButton:NO :YES :NO :NO];
    ShopDetailViewController * temp = [[ShopDetailViewController alloc]init];
    temp.mShopId = mShopId;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}
- (TCWBEngine *)tencentweibo
{
    AppDelegate * delegate = (AppDelegate * )[UIApplication sharedApplication].delegate;
    return delegate.tencentweibo;
}
-(IBAction)mTabButton3Clicked:(id)sender
{
    NSString *shareText=[NSString stringWithFormat:@"号外啦！我在@M9M10食全酒美 限时优惠活动,%@%@，如此优惠速速分享，http://www.m9m10.cn/appdown/app.html",[mActivityDetailDic objectForKey:@"event_title"],[mActivityDetailDic objectForKey:@"event_introduce"]];
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        [self refreshButton:NO :NO :YES :NO];
        switch ([[dataHandler.userInfoDic objectForKey:@"usersource"]intValue])
        {
            case 1:
            {
                SinaWeibo *sinaweibo = [self sinaweibo];
                [sinaweibo requestWithURL:@"statuses/update.json"
                                   params:[NSMutableDictionary dictionaryWithObjectsAndKeys:shareText, @"status", nil]
                               httpMethod:@"POST"
                                 delegate:self];
            }
                break;
            case 2:
            {
                [[self tencentweibo] setRootViewController:self];
                [[self tencentweibo] postTextTweetWithFormat:@"json"
                                                     content:shareText
                                                    clientIP:@"10.10.1.31"
                                                   longitude:nil
                                                 andLatitude:nil
                                                 parReserved:nil
                                                    delegate:self
                                                   onSuccess:@selector(successCallBack:)
                                                   onFailure:@selector(failureCallBack:)];
            }
                break;
            default:
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"不能分享" message:@"非微博账号，请用微博登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
                alert.delegate = self;
                alert.tag=102;
                [alert show];
                [alert release];
            }
                break;
        }
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请用微博登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=103;
        [av show];
        [av release];
    }
    
}
-(IBAction)mTabButton4Clicked:(id)sender
{
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        [self refreshButton:NO :NO :NO :YES];
        CommentForActivityViewController * temp = [[CommentForActivityViewController alloc]init];
        temp.mShopId = mShopId;
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=101;
        [av show];
        [av release];
    }
}
- (void)successCallBack:(id)result
{
    UIAlertView * malertView = [[UIAlertView alloc]initWithTitle:@"发送成功" message:@"恭喜您，您已经成功分享了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [malertView show];
    [malertView release];
}
- (void)failureCallBack:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送失败"
                                                        message:[NSString stringWithFormat:@"发送失败了!"]
                                                       delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:[NSString stringWithFormat:@"您已经分享过了!"]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
    }
    NSLog(@"Post status failed with error : %@", error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                            message:@"分享成功"
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
    }
}
-(void)refreshButton:(BOOL)isButton1Selected:(BOOL)isButton2Selected:(BOOL)isButton3Selected:(BOOL)isButton4Selected
{
    mTabButton1.selected = isButton1Selected;
    mTabButton2.selected = isButton2Selected;
    mTabButton3.selected = isButton3Selected;
    mTabButton4.selected = isButton4Selected;
}
-(void)refreshData
{
    NSString *flag=[mActivityDetailDic objectForKey:@"flag"];
    if (flag && flag.length>0) {
         [[TKAlertCenter defaultCenter] postAlertWithMessage:@"优惠券已保存到“我的优惠券”"];
        return;
    }
    self.title =[NSString stringWithFormat:@"商家活动--%@",[mActivityDetailDic objectForKey:@"shop_name"]];
    int height = 37;
    mEventRulesLabel.text = [mActivityDetailDic objectForKey:@"event_rules"];
    CGSize size = [mEventRulesLabel.text sizeWithFont:mEventRulesLabel.font constrainedToSize:CGSizeMake(mEventRulesLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mEventRulesLabel.frame = [self ReSizeView:mEventRulesLabel :size :height];
    
    height+= mEventRulesLabel.frame.size.height;
    
    mMatchTitleView.frame = [self ReSizeView:mMatchTitleView :mMatchTitleView.frame.size :height];
    
    height += mMatchTitleView.frame.size.height;
    
    mEventIntroduceLabel.text = [mActivityDetailDic objectForKey:@"event_introduce"];
    size = [mEventIntroduceLabel.text sizeWithFont:mEventIntroduceLabel.font constrainedToSize:CGSizeMake(mEventIntroduceLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mEventIntroduceLabel.frame = [self ReSizeView:mEventIntroduceLabel :size :height];
    
    height+= mEventIntroduceLabel.frame.size.height;
    
    mAddressTitleView.frame = [self ReSizeView:mAddressTitleView :mAddressTitleView.frame.size :height];
    
    height += mAddressTitleView.frame.size.height;
    
    mEventAddressLabel.text = [mActivityDetailDic objectForKey:@"event_address"];
    size = [mEventAddressLabel.text sizeWithFont:mEventAddressLabel.font constrainedToSize:CGSizeMake(mEventAddressLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mEventAddressLabel.frame = [self ReSizeView:mEventAddressLabel :size :height];
    
    height += mEventAddressLabel.frame.size.height;
    
    mScrollView.contentSize = CGSizeMake(320, height+134);
    
    mEventTimeLabel.text = [NSString stringWithFormat:@"活动时间：%@",[mActivityDetailDic objectForKey:@"event_time"]];
    mEventCommentCountLabel.text = [mActivityDetailDic objectForKey:@"comment_count"];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mActivityDetailDic objectForKey:@"event_url"]] delegate:self];
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
    
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络出错" message:@"网络无响应，请检查网络并稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
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
    self.mActivityDetailDic = (NSDictionary*)[dic objectForKey:@"data"];
    isLoading = NO;
    [self refreshData];
    
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    mImageView.image = [UIImage imageWithData:aData];
}
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
	}
    
    LoginViewController * temp = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
@end
