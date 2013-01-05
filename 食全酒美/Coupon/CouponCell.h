//
//  CouponCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-13.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
#import "MarqueeLabel.h"

@interface CouponCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    //IBOutlet UILabel * mLabel;
    MarqueeLabel *rateLabel;
    UILabel *titleLabel;
    IBOutlet UILabel * mContentLabel;
    IBOutlet UILabel * mPrriodLabel;
    IBOutlet UILabel * mDownLoadCountLabel;
    IBOutlet UIImageView * mImage;
    NSDictionary * mCouponInfoDictionary;//event_id;event_title;coupon_content;startdate;enddate;coupon_url;download_count;is_effective
}
@property(nonatomic,retain)NSDictionary * mCouponInfoDictionary;
-(void)loadData;
@end
