//
//  MyCouponCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-17.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
#import "MarqueeLabel.h"

@protocol MyCouponCellDelegate<NSObject>
@required
-(void)CouponDeleteAtIndex:(int)index;
@end
@interface MyCouponCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    MarqueeLabel *rateLabel;
    UILabel *titleLabel;
    IBOutlet UILabel * mTitleLabel;
    IBOutlet UILabel * mDateLabel;
    IBOutlet UIImageView * mCouponLogo;
    NSDictionary * mCouponInfo;//coupon_id;event_id;coupon_content;startdate;enddate;coupon_url;download_count;
    int index;
    id<MyCouponCellDelegate>delegate;
}
-(IBAction)DeleteClicked:(id)sender;
-(void)refreshData;
@property(nonatomic,retain)NSDictionary * mCouponInfo;
@property(nonatomic,assign)int index;
@property(nonatomic,retain)id<MyCouponCellDelegate>delegate;
@end
