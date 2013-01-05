//
//  ShopCircleViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-20.
//
//

#import "BaseNetworkViewController.h"

@interface ShopCircleViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * mCircleArray;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    BOOL isLoading;
    int mPageNum;
}
@property(nonatomic,retain)NSMutableArray * mCircleArray;

@end
