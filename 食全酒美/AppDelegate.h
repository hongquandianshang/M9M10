//
//  AppDelegate.h
//  食全酒美
//
//  Created by dev dev on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CustomTabbar.h"
#import "SCGIFImageView.h"
#import "SplashViewController.h"

//sinaweibo app
#define kAppKey             @"1979815672"
#define kAppSecret          @"951e18174074ee976f744b8dc727a91c"
#define kAppRedirectURI     @"http://www.m9m10.cn"

@class SinaWeibo;
@class TCWBEngine;
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    MBProgressHUD *HUD;
    SinaWeibo * sinaweibo;
    TCWBEngine * tencentweibo;
    CustomTabbar * mtabBarController;
    UINavigationController * nav;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly,nonatomic) SinaWeibo *sinaweibo;
@property(readonly,nonatomic) TCWBEngine * tencentweibo;
@property (retain, nonatomic) CustomTabbar *mtabBarController;
@property (nonatomic,retain)UINavigationController * nav;

+ (AppDelegate *)sharedAppDelegate;
- (void)afterApplicationStart;
- (void)showWaitView:(NSString *)waitText;//显示等待
- (void)hiddenWaitView;//隐藏等待

@end
