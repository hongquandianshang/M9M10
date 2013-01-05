//
//  WineActivitySelectedWineViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-24.
//
//

#import "BaseNetworkViewController.h"
@protocol WineActivitySelectedWineDelegate<NSObject>
@required
-(void)SelectedAtIndex:(NSInteger)index:(NSInteger)windId;
@end

@interface WineActivitySelectedWineViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *mWineArray;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    int mPageNum;
    BOOL isLoading;
    BOOL isEnding;
    id<WineActivitySelectedWineDelegate> delegate;
}
@property(nonatomic,retain)id<WineActivitySelectedWineDelegate>delegate;
@property(nonatomic,retain)NSMutableArray  *mWineArray;
@end
