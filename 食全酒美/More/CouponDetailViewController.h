//
//  CouponDetailViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-29.
//
//

#import "BaseNetworkViewController.h"
#import "SDWebDataManager.h"
@interface CouponDetailViewController : BaseNetworkViewController<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    int mCouponId;
    IBOutlet UIScrollView * mScrollView;
    IBOutlet UILabel * mContentLabel;
    IBOutlet UILabel * shopNameLabel;
    IBOutlet UILabel * mShopNameLabel;
    IBOutlet UILabel * titleLabel;
    IBOutlet UILabel * mTitleLabel;
    IBOutlet UILabel * mDownLoadCodeLabel;
    IBOutlet UIImageView * mCouponImageView;
    BOOL isLoading;
    NSMutableDictionary * mCouponInfo;//event_id;event_title;coupon_content;coupon_url;download_code;
}
@property(nonatomic,assign)int mCouponId;
@property(nonatomic,retain)NSMutableDictionary * mCouponInfo;
-(IBAction)ShareClicked:(id)sender;
-(IBAction)CommentClicked:(id)sender;
@end
