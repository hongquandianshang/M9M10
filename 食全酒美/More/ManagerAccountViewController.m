//
//  ManagerAccountViewController.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-20.
//
//

#import "ManagerAccountViewController.h"
#import "AppDelegate.h"
#import "TCWBEngine.h"
#define TencentOAuthAppId @"100312778" //this need to be changed;

#define kOAuthConsumerKey @"1734209638" //this need to be changed;
#define kOAuthConsumerSecret @"e64143d2cdc1a639ec9a6ceb6e0d45ca" //this need to be changed;
@interface ManagerAccountViewController ()

@end

@implementation ManagerAccountViewController
//@synthesize sinaOAuth = _sinaOAuth;
//@synthesize timeLineViewController = _timeLineViewController;
@synthesize mUserName;
@synthesize mNickName;
@synthesize mUserImage;
@synthesize mCocode;
@synthesize mUserSelectedImageData;

#pragma mark - custom Notification

- (void)keyboardWillShow:(NSNotification *)notif {
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
	self.view.frame = CGRectMake(0, 0-50, 320, 336);
	[UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notif {
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
	self.view.frame = CGRectMake(0, 0, 320, 336);
	[UIView commitAnimations];
}

#pragma mark - UITextInputCurrentInputModeDidChangeNotification
-(void) changeMode:(NSNotification *)notification{
    NSLog(@"%@",[[UITextInputMode currentInputMode] primaryLanguage]);
    
    //    2011-07-18 14:32:48.565 UIFont[2447:207] zh-Hans //简体汉字拼音
    //    2011-07-18 14:32:50.784 UIFont[2447:207] en-US   //英文
    //    2011-07-18 14:32:51.344 UIFont[2447:207] zh-Hans //简体手写
    //    2011-07-18 14:32:51.807 UIFont[2447:207] zh-Hans //简体笔画
    //    2011-07-18 14:32:53.271 UIFont[2447:207] zh-Hant //繁体手写
    //    2011-07-18 14:32:54.062 UIFont[2447:207] zh-Hant //繁体仓颉
    //    2011-07-18 14:32:54.822 UIFont[2447:207] zh-Hant //繁体笔画
    
}

#pragma mark - UIKeyboardWillChangeFrameNotification
- (void)keyboardFrameWillChange:(NSNotification*)notification{
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight=keyboardRect.size.height;
    NSLog(@"keyboardFrameWillChange:True");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:self.view.window];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:self.view.window];
        NSString *versions = [[UIDevice currentDevice] systemVersion];
        if ([versions compare:@"5.0"] != NSOrderedAscending ) { // iOS5.0以降の判定
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMode:) name:UITextInputCurrentInputModeDidChangeNotification object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
            
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    mSexBoyButton.selected =YES;
    self.mUserSelectedImageData = [NSData data];
//    //init the sina engine
//    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kOAuthConsumerKey appSecret:kOAuthConsumerSecret];
//    [engine setRootViewController:self];
//    [engine setDelegate:self];
//    [engine setRedirectURI:@"http://"];
//    [engine setIsUserExclusive:NO];
//    self.sinaOAuth = engine;
//    [engine release];
//    //sina engine init end
    
    //init the tencent engine
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:TencentOAuthAppId andDelegate:self];
	_tencentOAuth.redirectURI = @"www.qq.com";
    _permissions =  [[NSArray arrayWithObjects:
					  @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
					  @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
    //tencent engine init end
    
    _keyboardHeight=216;
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
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    NSString *versions = [[UIDevice currentDevice] systemVersion];
    if ([versions compare:@"5.0"] != NSOrderedAscending ) { // iOS5.0以降の判定
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UITextInputCurrentInputModeDidChangeNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillChangeFrameNotification
                                                      object:nil];
        
    }
    
    _keyboardHeight=0;
    [super dealloc];
    [mNickName release];
    [mUserImage release];
    [mUserName release];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
-(IBAction)SexBoyClicked:(id)sender
{
    mSexBoyButton.selected = YES;
    mSexIsGirl = NO;
    mSexGirlButton.selected = NO;
}
-(IBAction)SexGirlClicked:(id)sender
{
    mSexBoyButton.selected = NO;
    mSexIsGirl = YES;
    mSexGirlButton.selected = YES;
}
-(IBAction)PictureClicked:(id)sender
{
    UIActionSheet * menu = [[UIActionSheet alloc]initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选择" otherButtonTitles:@"拍照", nil];
    [menu showInView:self.view];
    [menu release];
}
-(IBAction)RegisterClicked:(id)sender
{
    [dataHandler RegisterRequestRecord:mUserNameTextField.text Password:mPasswordTextField.text NickName:mNickNameTextField.text ImageData:mUserSelectedImageData Sex:mSexIsGirl?@"0":@"1" Age:mAgeTextField.text Phone:mPhoneTextField.text Delegate:self];
}
-(IBAction)ResignClicked:(id)sender
{
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
#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%i",buttonIndex);
    if (buttonIndex == 0) {
        UIImagePickerController * tempImagePicker = [[UIImagePickerController alloc]init];
        tempImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        tempImagePicker.delegate = self;
        [self presentModalViewController:tempImagePicker animated:YES];
        [tempImagePicker release];
    }
    else if (buttonIndex == 1)
    {
        UIImagePickerController * tempImagePicker = [[UIImagePickerController alloc]init];
        tempImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        tempImagePicker.delegate = self;
        [self presentModalViewController:tempImagePicker animated:YES];
        [tempImagePicker release];
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.mUserSelectedImageData = UIImageJPEGRepresentation(image, 1.0);
    [mSelectedImageButton setImage:[UIImage imageWithData:self.mUserSelectedImageData] forState:UIControlStateNormal];
    NSLog(@"%@",info);
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
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
    [results release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate hiddenWaitView];//隐藏
    
    NSDictionary *userInfoDic = (NSMutableDictionary*)[dic objectForKey:@"data"];
    if ([userInfoDic objectForKey:@"userid"])
    {
        dataHandler.userInfoDic = (NSMutableDictionary*)[dic objectForKey:@"data"];
        
        //保存
        [[NSUserDefaults standardUserDefaults] setObject:dataHandler.userInfoDic forKey:@"userInfoDic"];// 保存到本地 //Library/Preferences/com.jishike.mppp.plist
        //如果程序意外退出，NSUserDefaults standardUserDefaults数据不会被系统写入到该文件，不过可以使用［[NSUserDefaults standardUserDefaults] synchronize］命令直接同步到文件里，来避免数据的丢失
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
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
            //[self.navigationController popViewControllerAnimated:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
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
    self.mNickName =[[result objectForKey:@"data"] objectForKey:@"name"];
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
    NSLog(@"username is %@,nickname is %@,",mUserName,mNickName);
    [self logInWithSourceType:2];
}
-(void)logInWithSourceType:(int)type
{
    [dataHandler LoginRequestRecord:@"" :@"" :type :mUserName :mNickName :mUserImage:self];
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

@end
