//
//  ActivityDetailViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-25.
//
//

#import "BaseNetworkViewController.h"
#import "SDWebDataManager.h"
#import "TKAlertCenter.h"
#import "SinaWeiboRequest.h"
#import "SinaWeibo.h"
#import "TCWBEngine.h"
#import "LoginViewController.h"
@interface ActivityDetailViewController : BaseNetworkViewController<UIAlertViewDelegate,SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    IBOutlet UIButton * mTabButton1;
    IBOutlet UIButton * mTabButton2;
    IBOutlet UIButton * mTabButton3;
    IBOutlet UIButton * mTabButton4;
    int mShopId;
    int mEventId;
    BOOL isLoading;
    NSDictionary * mActivityDetailDic;//comment_count;event_id;event_title;event_url;event_rules;event_introduce;event_address;shop_name;event_time;
    IBOutlet UILabel * mEventRulesLabel;
    IBOutlet UILabel * mEventIntroduceLabel;
    IBOutlet UILabel * mEventAddressLabel;
    IBOutlet UILabel * mEventTimeLabel;
    IBOutlet UILabel * mEventCommentCountLabel;
    IBOutlet UIScrollView * mScrollView;
    IBOutlet UIImageView * mImageView;
    IBOutlet UIView * mMatchTitleView;
    IBOutlet UIView * mAddressTitleView;
}
@property(nonatomic,assign)int mShopId;
@property(nonatomic,assign)int mEventId;
@property(nonatomic,retain)NSDictionary * mActivityDetailDic;
@end
