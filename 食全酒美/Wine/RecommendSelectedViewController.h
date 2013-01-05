//
//  RecommendSelectedViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-5.
//
//

#import "BaseNetworkViewController.h"
@protocol RecommendSelectedDelegate<NSObject>
@required
-(void)SelectedAtIndex:(NSInteger)index:(NSInteger)windId;
@end
@interface RecommendSelectedViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *mWineArray;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    int mPageNum;
    BOOL isLoading;
    BOOL isEnding;
    id<RecommendSelectedDelegate>delegate;
}
@property(nonatomic,retain)NSMutableArray  *mWineArray;
@property(nonatomic,retain)id<RecommendSelectedDelegate>delegate;
@end
