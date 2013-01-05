//
//  ShopDetailOtherShopViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-27.
//
//

#import "BaseNetworkViewController.h"

@interface ShopDetailOtherShopViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView* mTableView;
    NSMutableArray * mOtherShopArray;
    BOOL isLoading;
    BOOL isEnding;
    int mPageNum;
    int mShopId;
}
@property(nonatomic,retain)NSMutableArray * mOtherShopArray;
@property(nonatomic,assign)int mShopId;
@end
