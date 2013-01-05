//
//  ShopListViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-10.
//
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
@interface ShopListViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView* mTableView;
    NSMutableArray * mShopArray;
    int pagenum;
    BOOL isLoading;
    BOOL isEnding;
    int mEventId;
}
@property(nonatomic,retain)NSMutableArray *mShopArray;
@property(nonatomic,assign)int mEventId;
@end
