//
//  ShopDetailViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-24.
//
//

#import "BaseNetworkViewController.h"
#import "SDWebDownLoadObject.h"
#import "TKAlertCenter.h"
#import "CallViewController.h"
#import "MapViewController.h"
#import "SinaWeiboRequest.h"
#import "SinaWeibo.h"
#import "LoginViewController.h"
@interface ShopDetailViewController : BaseNetworkViewController<UIAlertViewDelegate,SDWebDataDownloaderDelegate,SDWebDataManagerDelegate,SDWebDownLoadObjectDelegate,UIScrollViewDelegate,SinaWeiboRequestDelegate,SinaWeiboDelegate>
{
    int mShopId;
    int mEventId;
    NSMutableDictionary * mShopDetailDic;//shop_id;shop_name;shop_enname;shop_introduction;shop_characteristic;shop_businesstime;shop_telephone;shop_addr;shop_bus;shop_park;shop_cuisines;shop_area;shop_purpose;shop_metro;shop_longitude;shop_latitude;shop_logos;shop_wine;
    NSArray * mShopFoodWineArray;//wine_id;wine_name;wine_logo;
    
    BOOL isLoading;
    IBOutlet UIScrollView * mScrollView;
    IBOutlet UIScrollView * mLogoScrollView;
    IBOutlet UIPageControl * pageControl;
    IBOutlet UIView * mSwitchView;
    IBOutlet UIView * mContentView;
    IBOutlet UIButton * mTabButton1;
    IBOutlet UIButton * mTabButton2;
    IBOutlet UIButton * mTabButton3;
    IBOutlet UIButton * mTabButton4;
    
    IBOutlet UILabel * mShopIntroductionLabel;
    IBOutlet UILabel * mShopCharacteristicLabel;
    IBOutlet UILabel * mShopBussinessTimeLabel;
    IBOutlet UILabel * mShopWineLabel;
    IBOutlet UILabel * mShopPurposeLabel;
    IBOutlet UILabel * mShopCuisinessLabel;
    IBOutlet UILabel * mShopAreaLabel;
    IBOutlet UILabel * mShopTelephoneLabel;
    IBOutlet UIButton * mShopTelephoneBtn;
    
    IBOutlet UILabel * mShopAddressLabel;
    IBOutlet UIButton * mShopAddressBtn;
    IBOutlet UILabel * mShopMetro;
    IBOutlet UILabel * mShopBusLabel;
    IBOutlet UILabel * mShopParkLabel;
    
    IBOutlet UIView * mFoodWineView;
    BOOL isRequestShopDetail;
    NSMutableArray * mDownLoadObjectArray;
    
    IBOutlet UIImageView * mDot1;
    IBOutlet UIImageView * mDot2;
    IBOutlet UIImageView * mDot3;
    IBOutlet UIImageView * mDot4;
    IBOutlet UIImageView * mDot5;
    
    IBOutlet UIView * mBusview;
    
    IBOutlet UIImageView * mBus1;
    IBOutlet UIImageView * mBus2;
    IBOutlet UIImageView * mBus3;
    IBOutlet UIImageView * mBus4;
    
    IBOutlet UIButton * mOthershopButton;
    IBOutlet UIView * mBackGroundColorView;
}
@property(nonatomic,assign)int mShopId;
@property(nonatomic,assign)int mEventId;
@property(nonatomic,retain)NSMutableDictionary * mShopDetailDic;
@property(nonatomic,retain)NSArray * mShopFoodWineArray;
@property(nonatomic,retain)NSMutableArray * mDownLoadObjectArray;
-(IBAction)OtherShop:(id)sender;
-(IBAction)changePage:(id)sender;
-(IBAction)switchView:(id)sender;
@end
