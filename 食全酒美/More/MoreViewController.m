//
//  MoreViewController.m
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "CityListViewController.h"
#import "MyWineViewController.h"
#import "MyCouponViewController.h"
#import "ManagerAccountViewController.h"
#import "AddShopViewController.h"
#import "LoginViewController.h"
#import "AboutUsViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController
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
    self.title = @"更多";
    self.navigationItem.rightBarButtonItem =nil;
    self.navigationItem.leftBarButtonItem =nil;
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 51.0, 31.0)];
//    
//    [rightBtn setImage:[UIImage imageNamed:@"AddShopUnClicked.png"] forState:UIControlStateNormal];
//    [rightBtn setImage:[UIImage imageNamed:@"AddShopClicked.png"] forState:UIControlStateHighlighted];
//    [rightBtn addTarget:self action:@selector(AddShop) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    rightBarBtn.style=UIBarButtonItemStyleBordered;
//    
//    self.navigationItem.rightBarButtonItem = rightBarBtn;
//    [rightBtn release];
//    [rightBarBtn release];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [(CustomTabbar*)self.tabBarController enablebuttons];
    [(CustomTabbar*)self.tabBarController enablebutton];
    [self hideTabBar:NO];
    if ([dataHandler.userInfoDic objectForKey:@"userid"])
    {
        mUserNameLabel.text = [dataHandler.userInfoDic objectForKey:@"nickname"];
        SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
        NSString *userpic=[dataHandler.userInfoDic objectForKey:@"userpic"];
        if (userpic && userpic.length>0)
        {
            [tempDownLoader downloadWithURL:[NSURL URLWithString:[dataHandler.userInfoDic objectForKey:@"userpic"]]delegate:self];
        }
        else{
            mUserImageView.image = [UIImage imageNamed:@"DefaultUser.png"];
        }
        
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 51.0, 31.0)];
        
        [rightBtn setImage:[UIImage imageNamed:@"LogoutUnClicked.png"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"LogoutClicked.png"] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(Logout) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        rightBarBtn.style=UIBarButtonItemStyleBordered;
        
        self.navigationItem.rightBarButtonItem = rightBarBtn;
        [rightBtn release];
        [rightBarBtn release];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)MyCityClicked:(id)sender
{
    CityListViewController * temp = [[CityListViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(IBAction)MyWineClicked:(id)sender
{
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        MyWineViewController * temp = [[MyWineViewController alloc]init];
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=103;
        [av show];
        [av release];
    }
}
-(IBAction)MyCouponClicked:(id)sender
{
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        MyCouponViewController * temp = [[MyCouponViewController alloc]init];
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }
    else{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否登录" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        av.delegate = self;
        av.tag=103;
        [av show];
        [av release];
    }
}
-(IBAction)ManagerAccountClicked:(id)sender
{
    LoginViewController * temp = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
//    UIImagePickerController * tempImagePicker = [[UIImagePickerController alloc]init];
//    tempImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    tempImagePicker.delegate = nil;
//    //[self presentModalViewController:tempImagePicker animated:YES];
//    [self presentViewController:tempImagePicker animated:YES completion:^{
//        
//    }];
//    [tempImagePicker release];
}
-(IBAction)FeedbackClicked:(id)sender
{
    //打开safari浏览器
    NSString* urlPath = @"http://www.m9m10.cn/report.aspx";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}
-(IBAction)AboutUsClicked:(id)sender
{
    AboutUsViewController * temp = [[AboutUsViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
-(void)AddShop
{
    AddShopViewController * temp = [[AddShopViewController alloc]init];
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
-(void)Logout
{
    if ([dataHandler.userInfoDic objectForKey:@"userid"]){
        switch ([[dataHandler.userInfoDic objectForKey:@"usersource"]intValue])
        {
            case 1:
            {
                SinaWeibo *sinaweibo = [self sinaweibo];
                sinaweibo.delegate = self;
                [sinaweibo logOut];
            }
                break;
            case 2:
            {
                [[self tencentweibo] logOut];
            }
                break;
            default:
                break;
        }
    }
    
    dataHandler.userInfoDic=nil;
    //保存
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userInfoDic"];// 保存到本地 //Library/Preferences/com.jishike.mppp.plist
    //如果程序意外退出，NSUserDefaults standardUserDefaults数据不会被系统写入到该文件，不过可以使用［[NSUserDefaults standardUserDefaults] synchronize］命令直接同步到文件里，来避免数据的丢失
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.navigationItem.rightBarButtonItem = nil;
    mUserNameLabel.text = @"邮箱,或sina,或腾讯账户名";
    mUserImageView.image = [UIImage imageNamed:@"DefaultUser.png"];
    
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"注销成功"];
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mUserImageView.image = [UIImage imageWithData:aData];
    }
}
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
	}
    
    LoginViewController * temp = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
//    switch (alertView.tag) {
//        case 101:
//        {
//            break;
//        }
//        case 102:
//        {
//            break;
//        }
//        case 103:
//        {
//            break;
//        }
//        default:
//            break;
//    }
}
@end
