//
//  MyCouponViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-17.
//
//

#import "BaseNetworkViewController.h"
#import "MyCouponCell.h"
@interface MyCouponViewController : BaseNetworkViewController<MyCouponCellDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    NSMutableArray * mCouponArray;
    BOOL isLoading;
    int mPageNum;
    BOOL isEnding;
}
@property(nonatomic,retain)NSMutableArray *mCouponArray;
@end
