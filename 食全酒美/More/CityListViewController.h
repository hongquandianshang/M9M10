//
//  CityListViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-17.
//
//

#import "BaseNetworkViewController.h"

@interface CityListViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    int mPageNum;
    BOOL isLoading;
    NSMutableArray* mCityArray;
}
@property(nonatomic,retain)NSMutableArray * mCityArray;
@end
