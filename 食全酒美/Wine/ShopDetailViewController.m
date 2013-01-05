//
//  ShopDetailViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-24.
//
//

#import "ShopDetailViewController.h"
#import "ActivityDetailViewController.h"
#import "AllWineForAShopViewController.h"
#import "ShopDetailOtherShopViewController.h"
#import "ShopDetailActivityViewController.h"
#import "ShopDetailFoodChooseWineViewController.h"
#import "SinaWeibo.h"
#import "TCWBEngine.h"
#import "AppDelegate.h"
@interface ShopDetailViewController ()

@end

@implementation ShopDetailViewController
@synthesize mShopId;
@synthesize mEventId;
@synthesize mShopDetailDic;
@synthesize mShopFoodWineArray;
@synthesize mDownLoadObjectArray;
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
    self.title =@"商家详情";
    mScrollView.contentSize = CGSizeMake(320, 700);
    isLoading = YES;
    self.mShopDetailDic = [NSDictionary dictionary];
    self.mShopFoodWineArray = [NSArray array];
    isRequestShopDetail = YES;
    [dataHandler ShopDetailRecord:mShopId :self];
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
-(void)refreshData
{
    int height = 11;
    self.title =[mShopDetailDic objectForKey:@"shop_name"];
    
    mShopIntroductionLabel.text = [mShopDetailDic objectForKey:@"shop_introduction"]?[mShopDetailDic objectForKey:@"shop_introduction"]:@"";
    CGSize size = [mShopIntroductionLabel.text sizeWithFont:mShopIntroductionLabel.font constrainedToSize:CGSizeMake(mShopIntroductionLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mShopIntroductionLabel.frame = [self ReSizeView:mShopIntroductionLabel :size :mShopIntroductionLabel.frame.origin.y];
    height+= mShopIntroductionLabel.frame.origin.y + mShopIntroductionLabel.frame.size.height;
    
    mSwitchView.frame = [self ReSizeView:mSwitchView :mSwitchView.frame.size :height];
    height+= mSwitchView.frame.size.height;
    
    //mContentView
    mContentView.hidden=NO;
    mContentView.frame = [self ReSizeView:mContentView :mContentView.frame.size :height-5];
    
    height = 54;
    
    mShopCharacteristicLabel.text =[mShopDetailDic objectForKey:@"shop_characteristic"]?[mShopDetailDic objectForKey:@"shop_characteristic"]:@"";//[@"餐厅特色：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_characteristic"]?[mShopDetailDic objectForKey:@"shop_characteristic"]:@""];
    size = [mShopCharacteristicLabel.text sizeWithFont:mShopCharacteristicLabel.font constrainedToSize:CGSizeMake(mShopCharacteristicLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mShopCharacteristicLabel.frame = [self ReSizeView:mShopCharacteristicLabel :size :height];
    
    height+= mShopCharacteristicLabel.frame.size.height+2;
    
    
    mShopBussinessTimeLabel.text = [mShopDetailDic objectForKey:@"shop_businesstime"]?[mShopDetailDic objectForKey:@"shop_businesstime"]:@"";//[@"营业时间：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_businesstime"]?[mShopDetailDic objectForKey:@"shop_businesstime"]:@""];
    size = [mShopBussinessTimeLabel.text sizeWithFont:mShopBussinessTimeLabel.font constrainedToSize:CGSizeMake(mShopBussinessTimeLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mShopBussinessTimeLabel.frame = [self ReSizeView:mShopBussinessTimeLabel :size :height];
    mDot1.frame = CGRectMake(mDot1.frame.origin.x, mShopBussinessTimeLabel.frame.origin.y+2, mDot1.frame.size.width, mDot1.frame.size.height);
    
    height+=mShopBussinessTimeLabel.frame.size.height+2;
    
    mShopWineLabel.text = [mShopDetailDic objectForKey:@"shop_wine"]?[mShopDetailDic objectForKey:@"shop_wine"]:@"";//[@"推荐：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_wine"]?[mShopDetailDic objectForKey:@"shop_wine"]:@""];
    size = [mShopWineLabel.text sizeWithFont:mShopWineLabel.font constrainedToSize:CGSizeMake(mShopWineLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mShopWineLabel.frame = [self ReSizeView:mShopWineLabel :size :height];
    mDot2.frame = CGRectMake(mDot2.frame.origin.x, mShopWineLabel.frame.origin.y+2, mDot2.frame.size.width, mDot2.frame.size.height);
    
    height+=mShopWineLabel.frame.size.height+2;
    
    mShopPurposeLabel.text = [mShopDetailDic objectForKey:@"shop_purpose"]?[mShopDetailDic objectForKey:@"shop_purpose"]:@"";//[@"心情：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_purpose"]?[mShopDetailDic objectForKey:@"shop_purpose"]:@""];
    size = [mShopPurposeLabel.text sizeWithFont:mShopPurposeLabel.font constrainedToSize:CGSizeMake(mShopPurposeLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mShopPurposeLabel.frame = [self ReSizeView:mShopPurposeLabel :size :height];
    mDot3.frame = CGRectMake(mDot3.frame.origin.x, mShopPurposeLabel.frame.origin.y+2, mDot3.frame.size.width, mDot3.frame.size.height);
    
    height+=mShopPurposeLabel.frame.size.height+2;
    
    mShopCuisinessLabel.text = [mShopDetailDic objectForKey:@"shop_cuisines"]?[mShopDetailDic objectForKey:@"shop_cuisines"]:@"";//[@"菜系：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_cuisines"]?[mShopDetailDic objectForKey:@"shop_cuisines"]:@""];
    size = [mShopCuisinessLabel.text sizeWithFont:mShopCuisinessLabel.font constrainedToSize:CGSizeMake(mShopCuisinessLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mShopCuisinessLabel.frame = [self ReSizeView:mShopCuisinessLabel :size :height];
    mDot4.frame = CGRectMake(mDot4.frame.origin.x, mShopCuisinessLabel.frame.origin.y+2, mDot4.frame.size.width, mDot4.frame.size.height);
    
    
    height+= mShopCuisinessLabel.frame.size.height+2;
    
    mShopTelephoneLabel.text = [mShopDetailDic objectForKey:@"shop_telephone"]?[mShopDetailDic objectForKey:@"shop_telephone"]:@"";//[@"订餐电话：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_telephone"]?[mShopDetailDic objectForKey:@"shop_telephone"]:@""];
    size = [mShopTelephoneLabel.text sizeWithFont:mShopTelephoneLabel.font constrainedToSize:CGSizeMake(mShopTelephoneLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mShopTelephoneLabel.frame = [self ReSizeView:mShopTelephoneLabel :size :height];
    mDot5.frame = CGRectMake(mDot5.frame.origin.x, mShopTelephoneLabel.frame.origin.y+2, mDot5.frame.size.width, mDot5.frame.size.height);
    //mShopTelephoneBtn.frame=CGRectMake(mShopTelephoneLabel.frame.origin.x+mShopTelephoneLabel.frame.size.width+5, mDot5.frame.origin.y+mDot5.frame.size.height/2-mShopTelephoneBtn.frame.size.height/2, mShopTelephoneBtn.frame.size.width, mShopTelephoneBtn.frame.size.height);
    mShopTelephoneBtn.frame=mShopTelephoneLabel.frame;
    
    height+=mShopTelephoneLabel.frame.size.height;
    
    //mBusview
    height+=10;
    mBusview.frame=CGRectMake(mBusview.frame.origin.x, height, mBusview.frame.size.width, mBusview.frame.size.height);
    int BusViewHeight = 40;
    
    mShopAddressLabel.text = [mShopDetailDic objectForKey:@"shop_addr"]?[mShopDetailDic objectForKey:@"shop_addr"]:@"";//[@"地址：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_addr"]];
    if (mShopAddressLabel.text.length>0) {
        size = [mShopAddressLabel.text sizeWithFont:mShopAddressLabel.font constrainedToSize:CGSizeMake(mShopAddressLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        mShopAddressLabel.frame = [self ReSizeView:mShopAddressLabel :size :BusViewHeight];
        mBus1.frame = CGRectMake(mShopAddressLabel.frame.origin.x-20, mShopAddressLabel.frame.origin.y+1, mBus1.frame.size.width, mBus1.frame.size.height);
        mShopAddressBtn.frame=CGRectMake(mShopAddressLabel.frame.origin.x+mShopAddressLabel.frame.size.width, mShopAddressLabel.frame.origin.y+mShopAddressLabel.frame.size.height-mShopAddressBtn.frame.size.height-5, mShopAddressBtn.frame.size.width, mShopAddressBtn.frame.size.height);
        
        height+=mShopAddressLabel.frame.size.height+3;
        BusViewHeight+=mShopAddressLabel.frame.size.height+3;
        
        mBus1.hidden=NO;
        mShopAddressLabel.hidden=NO;
        mShopAddressBtn.hidden=NO;
    }
    else{
        mBus1.hidden=YES;
        mShopAddressLabel.hidden=YES;
        mShopAddressBtn.hidden=YES;
    }
    
    mShopMetro.text = [mShopDetailDic objectForKey:@"shop_metro"]?[mShopDetailDic objectForKey:@"shop_metro"]:@"";//[@"地铁：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_metro"]?[mShopDetailDic objectForKey:@"shop_metro"]:@""];
    if (mShopMetro.text.length>0) {
        size = [mShopMetro.text sizeWithFont:mShopMetro.font constrainedToSize:CGSizeMake(mShopMetro.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        mShopMetro.frame = [self ReSizeView:mShopMetro :size :BusViewHeight];
        mBus2.frame = CGRectMake(mShopMetro.frame.origin.x-20, mShopMetro.frame.origin.y, mBus2.frame.size.width, mBus2.frame.size.height);
        
        height+=mShopMetro.frame.size.height+3;
        BusViewHeight+=mShopMetro.frame.size.height+3;
        
        mBus2.hidden=NO;
        mShopMetro.hidden=NO;
    }
    else{
        mBus2.hidden=YES;
        mShopMetro.hidden=YES;
    }
    
    
    mShopBusLabel.text = [mShopDetailDic objectForKey:@"shop_bus"]?[mShopDetailDic objectForKey:@"shop_bus"]:@"";//[@"公交：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_bus"]?[mShopDetailDic objectForKey:@"shop_bus"]:@""];
    if (mShopBusLabel.text.length>0) {
        size = [mShopBusLabel.text sizeWithFont:mShopBusLabel.font constrainedToSize:CGSizeMake(mShopBusLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        mShopBusLabel.frame = [self ReSizeView:mShopBusLabel : size:BusViewHeight];
        mBus3.frame = CGRectMake(mShopBusLabel.frame.origin.x-20, mShopBusLabel.frame.origin.y+1.5, mBus3.frame.size.width, mBus3.frame.size.height);
        
        height+=mShopBusLabel.frame.size.height+3;
        BusViewHeight+=mShopBusLabel.frame.size.height+3;
        
        mBus3.hidden=NO;
        mShopBusLabel.hidden=NO;
    }
    else{
        mBus3.hidden=YES;
        mShopBusLabel.hidden=YES;
    }
    
    mShopParkLabel.text = [mShopDetailDic objectForKey:@"shop_park"]?[mShopDetailDic objectForKey:@"shop_park"]:@"";//[@"停车：" stringByAppendingString:[mShopDetailDic objectForKey:@"shop_park"]?[mShopDetailDic objectForKey:@"shop_park"]:@""];
    if (mShopParkLabel.text.length>0) {
        size = [mShopParkLabel.text sizeWithFont:mShopParkLabel.font constrainedToSize:CGSizeMake(mShopParkLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        mShopParkLabel.frame = [self ReSizeView:mShopParkLabel :size :BusViewHeight];
        mBus4.frame = CGRectMake(mShopParkLabel.frame.origin.x-20, mShopParkLabel.frame.origin.y+1, mBus4.frame.size.width, mBus4.frame.size.height);
        
        height += mShopParkLabel.frame.size.height;
        BusViewHeight +=mShopParkLabel.frame.size.height;
        
        mBus4.hidden=NO;
        mShopParkLabel.hidden=NO;
    }
    else{
        mBus4.hidden=YES;
        mShopParkLabel.hidden=YES;
    }
    height +=10;
    BusViewHeight +=10;
    
    mOthershopButton.frame = CGRectMake(mOthershopButton.frame.origin.x, BusViewHeight, mOthershopButton.frame.size.width, mOthershopButton.frame.size.height);
    
    height += mOthershopButton.frame.size.height;
    BusViewHeight +=mOthershopButton.frame.size.height;
    
    mBusview.frame=CGRectMake(mBusview.frame.origin.x, mBusview.frame.origin.y, mBusview.frame.size.width, BusViewHeight);
    mBackGroundColorView.frame = CGRectMake(mBackGroundColorView.frame.origin.x, mBackGroundColorView.frame.origin.y, mBackGroundColorView.frame.size.width, height+30);
    mContentView.frame=CGRectMake(mContentView.frame.origin.x,mContentView.frame.origin.y,mBackGroundColorView.frame.size.width,height+40);
    
    mScrollView.contentSize = CGSizeMake(320, mContentView.frame.size.height+mContentView.frame.origin.y+20);
    [self initTheShopImageScrollView:[[mShopDetailDic objectForKey:@"shop_logos" ] count]];
    
    if (mContentView.hidden) {
        mScrollView.contentSize = CGSizeMake(320, mContentView.frame.origin.y);
    }
    else{
        mScrollView.contentSize = CGSizeMake(320, mContentView.frame.size.height+mContentView.frame.origin.y+20);
    }
    
    
}
-(CGRect)ReSizeView:(UIView *)view:(CGSize)size:(int)locationY
{
    return CGRectMake(view.frame.origin.x,locationY, size.width, size.height);
}
-(IBAction)mTabButton1Clicked:(id)sender
{
    [self refreshButton:YES :NO :NO :NO];
    ShopDetailActivityViewController * temp = [[ShopDetailActivityViewController alloc]init];
    temp.mShopId = mShopId;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)mTabButton2Clicked:(id)sender
{
    [self refreshButton:NO :YES :NO :NO];
    AllWineForAShopViewController * temp = [[AllWineForAShopViewController alloc]init];
    temp.mShopId = mShopId;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)mTabButton3Clicked:(id)sender
{
    [self refreshButton:NO :NO :YES :NO];
    
    ShopDetailFoodChooseWineViewController * temp = [[ShopDetailFoodChooseWineViewController alloc]init];
    temp.mShopId = mShopId;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)mTabButton4Clicked:(id)sender
{
    NSString *shareText=[NSString stringWithFormat:@"我在@M9M10食全酒美 寻觅到%@%@,餐酒搭配超好，特地分享http://www.m9m10.cn/appdown/app.html",[mShopDetailDic objectForKey:@"shop_name"],[mShopDetailDic objectForKey:@"shop_introduction"]];
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        [self refreshButton:NO :NO :NO :YES];
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
                alert.tag=104;
                [alert show];
                [alert release];
            }
                break;
        }
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请用微博登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=104;
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
-(IBAction)telShopTelephone:(id)sender
{
    if (![CallViewController canCallPhone]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"您的设备不支持\r\n拨打电话服务"];
        return;
    }
    NSString *string = [NSString stringWithFormat:@"tel://%@",[mShopDetailDic objectForKey:@"shop_telephone"]?[mShopDetailDic objectForKey:@"shop_telephone"]:@""];
    [CallViewController CallPhone:string];
}
-(IBAction)showShopAddress:(id)sender
{
    NSString *mShopAddress=[mShopDetailDic objectForKey:@"shop_addr"];
    if (mShopAddress.length<1) {
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:nil message:@"地址为空!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认",nil];
        [av show];
        [av release];
        return;
    }
    
    MapViewController *map = [[MapViewController alloc] init];
    map.enableEditLocation = NO;
    map.showSelfLocation = YES;
    
    MKUserLocation *userLocation=[[[MKUserLocation alloc] init] autorelease];
    userLocation.title=@"商家地址";//@"已放置的大头针";
    userLocation.subtitle=mShopAddress;
    CLLocationCoordinate2D coord;
    double latitude=[[mShopDetailDic objectForKey:@"shop_lat"] doubleValue];
    double longitude=[[mShopDetailDic objectForKey:@"shop_long"] doubleValue];
    if (latitude>0.0 && longitude>0.0) {
        coord.latitude = latitude;
        coord.longitude = longitude;
    }
    else{
        coord.latitude = 31.230271;
        coord.longitude = 121.538658;
    }
    [userLocation setCoordinate:coord];
    map.location=userLocation;
    
    [self.navigationController pushViewController:map animated:YES];
    //UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:map];
    //map.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//UIModalTransitionStyleFlipHorizontal;
    //[self presentModalViewController:nc animated:YES];
    map.title=@"商家地址";
    [map release];
    //[nc release];
}
-(IBAction)OtherShop:(id)sender
{
    ShopDetailOtherShopViewController * temp = [[ShopDetailOtherShopViewController alloc]init];
    temp.mShopId = self.mShopId;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)switchView:(id)sender{
    mContentView.hidden=!mContentView.hidden;
    
    [UIView animateWithDuration:0.5f animations:^{
        if(mContentView.hidden){
            [mScrollView setContentOffset:CGPointMake(0, 0)];
        }
        else{
            [mScrollView setContentOffset:CGPointMake(0, mSwitchView.frame.origin.y-11)];
        }
    }completion:^(BOOL finished) {
        if (finished) {
            if (mContentView.hidden) {
                mScrollView.contentSize = CGSizeMake(320, mContentView.frame.origin.y);
            }
            else{
                mScrollView.contentSize = CGSizeMake(320, mContentView.frame.size.height+mContentView.frame.origin.y+20);
            }
        }
    }];
}
     
-(void)refreshButton:(BOOL)isButton1Selected:(BOOL)isButton2Selected:(BOOL)isButton3Selected:(BOOL)isButton4Selected
{
    mTabButton1.selected = isButton1Selected;
    mTabButton2.selected = isButton2Selected;
    mTabButton3.selected = isButton3Selected;
    mTabButton4.selected = isButton4Selected;
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
    if (!isRequestShopDetail) {
        self.mShopFoodWineArray = (NSArray*)[dic objectForKey:@"data"];
    }
    else
    {
       self.mShopDetailDic = (NSMutableDictionary*)[dic objectForKey:@"data"];
    }
    
    isLoading = NO;
    
    [self refreshData];
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
}
-(void)initTheShopImageScrollView:(int)pagenum
{
    mLogoScrollView.contentSize = CGSizeMake(pagenum*300,123 );
    mLogoScrollView.pagingEnabled = YES;
    mLogoScrollView.showsHorizontalScrollIndicator = NO;
    mLogoScrollView.delegate = self;
    pageControl.numberOfPages = pagenum;
    pageControl.currentPage = 0;
    
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    self.mDownLoadObjectArray = [NSMutableArray arrayWithCapacity:pagenum];
    for (int i = 0; i<pagenum; i++)
    {
        SDWebDownLoadObject * downobject = [[SDWebDownLoadObject alloc]init];
        downobject.delegate = self;
        downobject.index = i;
        [self.mDownLoadObjectArray addObject:downobject];
        [tempDownLoader downloadWithURL:[NSURL URLWithString:[[[mShopDetailDic objectForKey:@"shop_logos" ]objectAtIndex:i] objectForKey:@"shop_logo"]] delegate:downobject];
    }
}
-(void)ImagefromWebAtIndex:(NSData*)imageDate index:(int)index
{
    UIImageView *tempimageView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:imageDate]];
    [mLogoScrollView addSubview:tempimageView];
    tempimageView.frame = CGRectMake(index*300, 0, 300, 123);
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    // update the scroll view to the appropriate page
    CGRect frame = mLogoScrollView.frame;
    frame.origin.x = frame.size.width * page;
    [mLogoScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark UIScrollViewDelegate
//滚动中
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = mLogoScrollView.frame.size.width;
    int curentScrollPage = floor((mLogoScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = curentScrollPage;
}

//滚动开始
// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender{

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
