//
//  MyWineViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-17.
//
//

#import "BaseNetworkViewController.h"
#import "MyWineCell.h"
@interface MyWineViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate,MyWineCellDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    BOOL isLoading;
    BOOL isEnding;
    int mPageNum;
    NSMutableArray * mWineArray;
}
@property(nonatomic,retain)NSMutableArray * mWineArray;
@end
