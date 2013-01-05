//
//  SecondViewController.m
//  食全酒美
//
//  Created by dev dev on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#define TencentOAuthAppId @"100234077" //this need to be changed;

#define kOAuthConsumerKey @"356866357" //this need to be changed;
#define kOAuthConsumerSecret @"5905214414e9e8a5aa50cb17bd499210" //this need to be changed;
@interface SecondViewController ()
@end

@implementation SecondViewController
@synthesize sinaOAuth = _sinaOAuth;
@synthesize timeLineViewController = _timeLineViewController;
@synthesize mUserName;
@synthesize mNickName;
@synthesize mUserImage;
@synthesize mCocode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //init the sina engine
    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kOAuthConsumerKey appSecret:kOAuthConsumerSecret];
    [engine setRootViewController:self];
    [engine setDelegate:self];
    [engine setRedirectURI:@"http://"];
    [engine setIsUserExclusive:NO];
    self.sinaOAuth = engine;
    [engine release];
    //sina engine init end
    
    //init the tencent engine
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"100234077"
											andDelegate:self];
	_tencentOAuth.redirectURI = @"www.qq.com";
    _permissions =  [[NSArray arrayWithObjects:
					  @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album", 
					  @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
    //tencent engine init end
    
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
-(IBAction)SineLoginClicked:(id)sender
{
    [_sinaOAuth logIn];
}
-(IBAction)TecentLoginClicked:(id)sender
{
    [_tencentOAuth authorize:_permissions inSafari:NO];
}
#pragma mark - TencentSessionDelegate
- (void)tencentDidLogin
{
    NSLog(@"loginsuccess");
    [_tencentOAuth getUserInfo];
}
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	if (cancelled){
		NSLog(@"用户取消登录");
	}
	else {
		NSLog(@"登录失败");
	}
	
}
-(void)tencentDidNotNetWork
{
	NSLog(@"无网络连接，请设置网络");
}
- (void)getUserInfoResponse:(APIResponse*) response
{
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		if (mUserName !=nil)
        {
            [mUserName release];
        }
        self.mUserName = [[NSString alloc] initWithFormat:@"%@@tencent",[_tencentOAuth openId]];
        if (mNickName !=nil) {
            [mNickName release];
        }
        self.mNickName =[[NSString alloc] initWithFormat:@"%@",[response.jsonResponse objectForKey:@"nickname"]];
        if (mUserImage!=nil)
        {
            [mUserImage release];
        }
        mUserImage=[[NSString alloc] initWithFormat:@"%@",[response.jsonResponse objectForKey:@"figureurl_1"]];
        if (mCocode!=nil) {
            [mCocode release];
        }
        mCocode=[[NSString alloc] initWithString:@"tencent"];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	NSLog(@"获取个人信息完成");
}

#pragma mark - SinaWeiboDelegate
- (void)engineDidLogIn:(WBEngine *)engine
{
    NSDictionary *dict=[[[NSDictionary alloc] initWithObjectsAndKeys:[engine userID], @"uid", nil] autorelease];
    [engine loadRequestWithMethodName:@"users/show.json" httpMethod:@"GET" params:dict postDataType:kWBRequestPostDataTypeNone httpHeaderFields:nil];
}
-(void)engineAlreadyLoggedIn:(WBEngine *)engine
{
    //    NSDictionary *dict=[[[NSDictionary alloc] initWithObjectsAndKeys:[_sinaOAuth userID], @"uid", nil] autorelease];
    //    msinaLogedin = YES;
    //    [_sinaOAuth loadRequestWithMethodName:@"users/show.json" httpMethod:@"GET" params:dict postDataType:kWBRequestPostDataTypeNone httpHeaderFields:nil];
}
- (void)logInAlertView:(WBLogInAlertView *)alertView logInWithUserID:(NSString *)userID password:(NSString *)password
{
    [_sinaOAuth logInUsingUserID:userID password:password];
}
- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result
{
    if ([result isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = (NSDictionary *)result;
        NSLog(@"%@",dict);
        if (mUserName!=nil)
        {
            [mUserName release];
        }
        mUserName=[[NSString alloc] initWithFormat:@"%@@sina",[dict objectForKey:@"id"]];
        if (mNickName!=nil)
        {
            [mNickName release];
        }
        mNickName=[[NSString alloc] initWithFormat:@"%@",[dict objectForKey:@"name"]];
        if (mUserImage!=nil)
        {
            [mUserImage release];
        }
        mUserImage=[[NSString alloc] initWithFormat:@"%@",[dict objectForKey:@"profile_image_url"]];
        if (mCocode!=nil) {
            [mCocode release];
        }
        mCocode=[[NSString alloc] initWithString:@"sina"];
    }
}

@end
