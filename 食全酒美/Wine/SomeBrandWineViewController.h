//
//  SomeBrandWineViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-6.
//
//

#import "BaseNetworkViewController.h"

@interface SomeBrandWineViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView* mTableView;
    NSMutableArray * mBrandWineArray;
    int mWineBrandId;
    BOOL isLoading;
    BOOL isEnding;
    int mPagnum;
}
@property(nonatomic,retain)NSMutableArray* mBrandWineArray;
@property(nonatomic,assign)int mWineBrandId;
@end
