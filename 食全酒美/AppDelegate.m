//
//  AppDelegate.m
//  食全酒美
//
//  Created by dev dev on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "WineViewController.h"
#import "NearByViewController.h"
#import "CouponViewController.h"
#import "MoreViewController.h"
#import "SecondViewController.h"
#import "FirstViewController.h"
#import "SinaWeibo.h"
#import "TCWBEngine.h"

@implementation AppDelegate

@synthesize sinaweibo;
@synthesize tencentweibo;
@synthesize window = _window;
@synthesize mtabBarController;
@synthesize nav;

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (void)dealloc
{
    [HUD release];//释放
    [sinaweibo release];
    [tencentweibo release];
    [_window release];
    [mtabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.window setBackgroundColor:[[[UIColor alloc] initWithCGColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]] CGColor]] autorelease]];
    // Override point for customization after application launch.
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:HUD];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"titlebar.png"] forBarMetrics:UIBarStyleDefault];
    }
    
    BOOL bFirstRun = [[NSUserDefaults standardUserDefaults] boolForKey:@"bFirstRun"];
    if (bFirstRun) {
        [application setStatusBarHidden:NO withAnimation:YES];
        
        UIViewController *viewController1 = [[[WineViewController alloc] initWithNibName:@"WineViewController" bundle:nil] autorelease];
        UINavigationController* navController1 = [[[UINavigationController alloc]initWithRootViewController:viewController1]autorelease];
        
        UIViewController *viewController2 = [[[NearByViewController alloc] initWithNibName:@"NearByViewController" bundle:nil] autorelease];
        UINavigationController* navController2 = [[[UINavigationController alloc]initWithRootViewController:viewController2]autorelease];
        
        UIViewController *viewController3 = [[[CouponViewController alloc] initWithNibName:@"CouponViewController" bundle:nil] autorelease];
        UINavigationController* navController3 = [[[UINavigationController alloc]initWithRootViewController:viewController3]autorelease];
        
        
        UIViewController * viewConroller4= [[[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil]autorelease];
        UINavigationController* navController4 = [[[UINavigationController alloc]initWithRootViewController:viewConroller4]autorelease];
        
        //    UIViewController * viewController4 = [[[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil]autorelease];
        //    UINavigationController* navController4 = [[[UINavigationController alloc]initWithRootViewController:viewController4]autorelease];
        
        
        
        self.mtabBarController = [[CustomTabbar alloc] init];
        self.mtabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2,navController3,navController4,nil];
        
        mtabBarController.isneedSetOne = YES;
        self.window.rootViewController = mtabBarController;
    }
    else{
        [application setStatusBarHidden:YES withAnimation:YES];
        
        SplashViewController *vc = [[[SplashViewController alloc] init] autorelease];
        UINavigationController *nc=[[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
        nc.navigationBarHidden=YES;
        self.window.rootViewController = nc;
        
        BOOL bFirstRun=TRUE;
        [[NSUserDefaults standardUserDefaults] setBool:bFirstRun forKey:@"bFirstRun"];// 保存到本地 //Library/Preferences/com.jishike.mppp.plist
        //如果程序意外退出，NSUserDefaults standardUserDefaults数据不会被系统写入到该文件，不过可以使用［[NSUserDefaults standardUserDefaults] synchronize］命令直接同步到文件里，来避免数据的丢失
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self.window makeKeyAndVisible];
    
    //[self performSelector:@selector(afterApplicationStart) withObject:nil afterDelay:0.0];
    
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    tencentweibo= [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
    //[engine setRootViewController:self];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

- (void)afterApplicationStart {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    UIViewController *viewController1 = [[[WineViewController alloc] initWithNibName:@"WineViewController" bundle:nil] autorelease];
    UINavigationController* navController1 = [[[UINavigationController alloc]initWithRootViewController:viewController1]autorelease];
    
    UIViewController *viewController2 = [[[NearByViewController alloc] initWithNibName:@"NearByViewController" bundle:nil] autorelease];
    UINavigationController* navController2 = [[[UINavigationController alloc]initWithRootViewController:viewController2]autorelease];
    
    UIViewController *viewController3 = [[[CouponViewController alloc] initWithNibName:@"CouponViewController" bundle:nil] autorelease];
    UINavigationController* navController3 = [[[UINavigationController alloc]initWithRootViewController:viewController3]autorelease];
    
    
    UIViewController * viewConroller4= [[[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil]autorelease];
    UINavigationController* navController4 = [[[UINavigationController alloc]initWithRootViewController:viewConroller4]autorelease];
    
    //    UIViewController * viewController4 = [[[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil]autorelease];
    //    UINavigationController* navController4 = [[[UINavigationController alloc]initWithRootViewController:viewController4]autorelease];
    
    
    
    self.mtabBarController = [[CustomTabbar alloc] init];
    self.mtabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2,navController3,navController4,nil];
    
    mtabBarController.isneedSetOne = YES;
    self.window.rootViewController = mtabBarController;
}

#pragma mark Activity
- (void)showWaitView:(NSString *)waitText{
    //1:text
    //HUD.labelText = waitText;
    
    //2: gif
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:nil];
    SCGIFImageView* gifImageView = [[[SCGIFImageView alloc] initWithGIFFile:filePath] autorelease];
    gifImageView.frame = CGRectMake(0, 0, gifImageView.image.size.width/5, gifImageView.image.size.height/5);
    gifImageView.backgroundColor=[UIColor clearColor];
    HUD.customView = gifImageView;
    //3.jpg
	//HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading.png"]] autorelease];
	// Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
	//HUD.delegate = self;
    //HUD.labelText = waitText;
    HUD.opacity=0.0;
    
    [self.window bringSubviewToFront:HUD];
    [HUD show:YES];//显示
}
- (void)hiddenWaitView{
    [HUD hide:YES];//隐藏
}

@end
