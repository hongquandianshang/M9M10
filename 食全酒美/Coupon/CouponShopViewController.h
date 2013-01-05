//
//  CouponShopViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-24.
//
//

#import "BaseNetworkViewController.h"

@interface CouponShopViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    NSMutableArray * mShopArray;//shop_id;shop_name;shop_addr;shop_logo;shop_cuisines
    int pagenum;
    BOOL isLoading;
    BOOL isEnding;
    int mEventId;
}
@property(nonatomic,retain)NSMutableArray * mShopArray;
@property(nonatomic,assign)int mEventId;
@end
