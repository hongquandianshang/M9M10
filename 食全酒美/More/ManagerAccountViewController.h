//
//  ManagerAccountViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-20.
//
//

#import "BaseNetworkViewController.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "TencentOAuth.h"
#import "WBEngine.h"
//#import "WBSendView.h"
//#import "WBLogInAlertView.h"
//#import "WBSDKTimelineViewController.h"
#import "TKAlertCenter.h"
@interface ManagerAccountViewController : BaseNetworkViewController<TencentSessionDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    //TencentLogin
    TencentOAuth* _tencentOAuth;
    NSMutableArray* _permissions;
    //TencentLogin
    
    //SinaLogin
//    WBEngine * _sinaOAuth;
//    WBSDKTimelineViewController* _timeLineViewController;
    NSDictionary *userInfo;
    NSArray *statuses;
    //SinaLogin
    
    NSString * mUserName;
    NSString * mNickName;
    NSString * mUserImage;
    NSString * mCocode;
    
    IBOutlet UIButton * mSelectedImageButton;
    IBOutlet UIButton * mSexBoyButton;
    IBOutlet UIButton * mSexGirlButton;
    IBOutlet UITextField * mUserNameTextField;
    IBOutlet UITextField * mNickNameTextField;
    IBOutlet UITextField * mAgeTextField;
    IBOutlet UITextField * mPasswordTextField;
    IBOutlet UITextField * mPasswordEnsureTextField;
    IBOutlet UITextField * mPhoneTextField;
    BOOL mSexIsGirl;
    NSData * mUserSelectedImageData;
    
    NSInteger _keyboardHeight;//键盘高度
}
//@property(nonatomic,retain)WBEngine * sinaOAuth;
//@property(nonatomic,retain)WBSDKTimelineViewController* timeLineViewController;
@property(nonatomic,retain)NSData * mUserSelectedImageData;
@property(nonatomic,copy)NSString * mUserName;
@property(nonatomic,copy)NSString * mNickName;
@property(nonatomic,copy)NSString * mUserImage;
@property(nonatomic,copy)NSString * mCocode;
-(IBAction)SineLoginClicked:(id)sender;
-(IBAction)TecentLoginClicked:(id)sender;
-(IBAction)SexBoyClicked:(id)sender;
-(IBAction)SexGirlClicked:(id)sender;
-(IBAction)PictureClicked:(id)sender;
-(IBAction)RegisterClicked:(id)sender;
-(IBAction)ResignClicked:(id)sender;
@end
