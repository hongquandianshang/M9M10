//
//  ShopDetailActivityViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-10-10.
//
//

#import "BaseNetworkViewController.h"

@interface ShopDetailActivityViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    int mShopId;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    BOOL isLoading;
    BOOL isEnding;
    NSMutableArray * mWineActivityArray;
    int mPageNum;
}
@property(nonatomic,assign)int mShopId;
@property(nonatomic,retain)NSMutableArray * mWineActivityArray;
@end
