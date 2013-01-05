//
//  ShopDetailFoodChooseWineViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-10-10.
//
//

#import "BaseNetworkViewController.h"

@interface ShopDetailFoodChooseWineViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView *mTableView;
    int mShopId;
    NSMutableArray * mWineArray;//wine_id;wine_name;wine_logo;wine_food;wine_introduce;
    BOOL isLoading;
}
@property(nonatomic,assign)int mShopId;
@property(nonatomic,retain)NSMutableArray * mWineArray;
@end
