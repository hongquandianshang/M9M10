//
//  LoginViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-28.
//
//

#import "BaseNetworkViewController.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "TencentOAuth.h"
//#import "WBEngine.h"
//#import "WBSendView.h"
//#import "WBLogInAlertView.h"
//#import "WBSDKTimelineViewController.h"
@interface LoginViewController : BaseNetworkViewController<TencentSessionDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate>
{
    //TencentLogin
    TencentOAuth* _tencentOAuth;
    NSMutableArray* _permissions;
    //TencentLogin
    
//    //SinaLogin
//    WBEngine * _sinaOAuth;
//    WBSDKTimelineViewController* _timeLineViewController;
    NSDictionary *userInfo;
    NSArray *statuses;
//    //SinaLogin
    
    
    IBOutlet UITextField * mWebSiteUserNameTextField;
    IBOutlet UITextField * mWebSiteUserPassWordTextField;
    NSString * mUserName;
    NSString * mNickName;
    NSString * mUserImage;
    NSString * mCocode;
}
@property(nonatomic,copy)NSString * mUserName;
@property(nonatomic,copy)NSString * mNickName;
@property(nonatomic,copy)NSString * mUserImage;
@property(nonatomic,copy)NSString * mCocode;
-(IBAction)SineLoginClicked:(id)sender;
-(IBAction)TecentLoginClicked:(id)sender;
-(IBAction)WebSiteLoginClicked:(id)sender;
-(IBAction)RegisterClicked:(id)sender;
-(IBAction)GetmypasswordClicked:(id)sender;
@end
