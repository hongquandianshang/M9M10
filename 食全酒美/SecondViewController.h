//
//  SecondViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TencentOAuth.h"
#import "WBEngine.h"
#import "WBSendView.h"
#import "WBLogInAlertView.h"
#import "WBSDKTimelineViewController.h"
@interface SecondViewController : UIViewController<TencentSessionDelegate,WBEngineDelegate,WBLogInAlertViewDelegate>
{
    //TencentLogin
    TencentOAuth* _tencentOAuth;
    NSMutableArray* _permissions;
    //TencentLogin
    
    //SinaLogin
    WBEngine * _sinaOAuth;
    WBSDKTimelineViewController* _timeLineViewController;
    //SinaLogin
    
    NSString * mUserName;
    NSString * mNickName;
    NSString * mUserImage;
    NSString * mCocode;
}
@property(nonatomic,retain)WBEngine * sinaOAuth;
@property(nonatomic,retain)WBSDKTimelineViewController* timeLineViewController;
@property(nonatomic,copy)NSString * mUserName;
@property(nonatomic,copy)NSString * mNickName;
@property(nonatomic,copy)NSString * mUserImage;
@property(nonatomic,copy)NSString * mCocode;
-(IBAction)SineLoginClicked:(id)sender;
-(IBAction)TecentLoginClicked:(id)sender;
@end
