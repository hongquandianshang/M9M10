//
//  LoginViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-28.
//
//

#import "LoginViewController.h"
#import "ManagerAccountViewController.h"
#import "AppDelegate.h"
#import "TCWBEngine.h"
#define TencentOAuthAppId @"100312778" //this need to be changed;

#define kOAuthConsumerKey @"1734209638" //this need to be changed;
#define kOAuthConsumerSecret @"e64143d2cdc1a639ec9a6ceb6e0d45ca" //this need to be changed;
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize mUserName;
@synthesize mNickName;
@synthesize mUserImage;
@synthesize mCocode;
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
    //init the sina engine
    self.title = @"管理账户";
//    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kOAuthConsumerKey appSecret:kOAuthConsumerSecret];
//    [engine setRootViewController:self];
//    [engine setDelegate:self];
//    [engine setRedirectURI:@"http://"];
//    [engine setIsUserExclusive:NO];
//    self.sinaOAuth = engine;
//    [engine release];
    //sina engine init end
    
    //init the tencent engine
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:TencentOAuthAppId
											andDelegate:self];
	_tencentOAuth.redirectURI = @"www.qq.com";
    _permissions =  [[NSArray arrayWithObjects:
					  @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
					  @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
    //tencent engine init end
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

-(IBAction)GetmypasswordClicked:(id)sender{
    //打开safari浏览器
    NSString* urlPath = @"http://www.m9m10.cn/getmypassword.aspx";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

-(IBAction)SineLoginClicked:(id)sender
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%@", [keyWindow subviews]);
    
    
    [userInfo release], userInfo = nil;
    [statuses release], statuses = nil;
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    sinaweibo.delegate = self;
    [sinaweibo logIn];
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
-(IBAction)TecentLoginClicked:(id)sender
{
    //[_tencentOAuth authorize:_permissions inSafari:NO];
    [[self tencentweibo] setRootViewController:self];
    [[self tencentweibo] logInWithDelegate:self onSuccess:@selector(onSuccessLogin) onFailure:nil];
}
-(IBAction)WebSiteLoginClicked:(id)sender
{
    [mWebSiteUserNameTextField resignFirstResponder];
    [mWebSiteUserPassWordTextField resignFirstResponder];
    [dataHandler LoginRequestRecord:mWebSiteUserNameTextField.text :mWebSiteUserPassWordTextField.text :3 :@"" :@"" :@"" :self];
}
-(IBAction)RegisterClicked:(id)sender
{
    [mWebSiteUserNameTextField resignFirstResponder];
    [mWebSiteUserPassWordTextField resignFirstResponder];
    
    ManagerAccountViewController * temp = [[ManagerAccountViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(void)logInWithSourceType:(int)type
{
    [dataHandler LoginRequestRecord:@"" :@"" :type :mUserName :mNickName :mUserImage:self];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
#pragma mark tencentsuccess
- (void)onSuccessLogin
{
    [[self tencentweibo] getUserInfoWithFormat:@"json"
                        parReserved:nil
                           delegate:self
                          onSuccess:@selector(successCallBack:)
                          onFailure:@selector(failureCallBack:)];
}
-(void)successCallBack:(id)result
{
    if (mUserName !=nil)
    {
        [mUserName release];
    }
    self.mUserName = [[result objectForKey:@"data"] objectForKey:@"openid"];
    if (mNickName !=nil) {
        [mNickName release];
    }
    self.mNickName =[[result objectForKey:@"data"] objectForKey:@"nick"];
    if (mUserImage!=nil)
    {
        [mUserImage release];
    }
    self.mUserImage = [[result objectForKey:@"data"] objectForKey:@"head"];
    self.mUserImage=[self.mUserImage stringByReplacingOccurrencesOfString:@"\\/" withString:@"\\"];
    self.mUserImage=[self.mUserImage stringByAppendingString:@"/100"];
    if (mCocode!=nil) {
        [mCocode release];
    }
    mCocode=[[NSString alloc] initWithString:@"tencent"];
    NSLog(@"username is %@,nickname is %@,mUserImage is %@",mUserName,mNickName,mUserImage);
    [self logInWithSourceType:2];
}
#pragma mark - sineloginsuccess
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
//    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
//    
//    [self resetButtons];
    NSMutableDictionary *sinaweiboInfo=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"SinaWeiboAuthData"]];
    [sinaweiboInfo setValue:sinaweibo.accessToken forKey:@"AccessTokenKey"];
    [sinaweiboInfo setValue:sinaweibo.expirationDate forKey:@"ExpirationDateKey"];
    [sinaweiboInfo setValue:sinaweibo.userID forKey:@"UserIDKey"];
    
    [[NSUserDefaults standardUserDefaults] setObject:sinaweiboInfo forKey:@"SinaWeiboAuthData"];
    //如果程序意外退出，NSUserDefaults standardUserDefaults数据不会被系统写入到该文件，不过可以使用［[NSUserDefaults standardUserDefaults] synchronize］命令直接同步到文件里，来避免数据的丢失
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [self storeAuthData];
    SinaWeibo * tempsinaweibo = [self sinaweibo];
    [tempsinaweibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"%@",result);
        [userInfo release];
        userInfo = [result retain];
        if (mUserName !=nil)
        {
            [mUserName release];
        }
        self.mUserName = [userInfo objectForKey:@"id"];
        if (mNickName !=nil) {
            [mNickName release];
        }
        self.mNickName =[userInfo objectForKey:@"name"];
        if (mUserImage!=nil)
        {
            [mUserImage release];
        }
        self.mUserImage = [userInfo objectForKey:@"avatar_large"];
        if (mCocode!=nil) {
            [mCocode release];
        }
        NSLog(@"username is %@,nickname is %@,",mUserName,mNickName);
        mCocode=[[NSString alloc] initWithString:@"sina"];
        [self logInWithSourceType:1];
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
    dataHandler.userInfoDic = (NSMutableDictionary*)[dic objectForKey:@"data"];
    NSLog(@"%@",dic);
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    
    if ([dataHandler.userInfoDic objectForKey:@"userid"])
    {
        //保存
        [[NSUserDefaults standardUserDefaults] setObject:dataHandler.userInfoDic forKey:@"userInfoDic"];// 保存到本地 //Library/Preferences/com.jishike.mppp.plist
        //如果程序意外退出，NSUserDefaults standardUserDefaults数据不会被系统写入到该文件，不过可以使用［[NSUserDefaults standardUserDefaults] synchronize］命令直接同步到文件里，来避免数据的丢失
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登录成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag=101;
        [alert show];
        [alert release];
    }
    else{
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[dic objectForKey:@"errorMessage"]];
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case 101:
        {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        default:
        {
            if (buttonIndex == alertView.cancelButtonIndex) {
                return;
            }
            break;
        } 
    }
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
        [self logInWithSourceType:2];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
        [alert release];
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
//- (void)logInAlertView:(WBLogInAlertView *)alertView logInWithUserID:(NSString *)userID password:(NSString *)password
//{
//    [_sinaOAuth logInUsingUserID:userID password:password];
//}
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
        [self logInWithSourceType:1];
    }
}
@end
