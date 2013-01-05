//
//  SomeTypeSelectedViewController.h
//  食全酒美
//
//  Created by Li XiangCheng on 12-11-27.
//
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
@protocol SomeTypeSelectedDelegate<NSObject>
@required
-(void)SelectedAtIndex:(NSInteger)index:(NSInteger)windId;
@end
@interface SomeTypeSelectedViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *mWineArray;//cate_id;cate_name;cate_logo;cate_introduce;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    int mPageNum;
    BOOL isLoading;
    BOOL isEnding;
    id<SomeTypeSelectedDelegate>delegate;
}
@property(nonatomic,retain)NSMutableArray  *mWineArray;
@property(nonatomic,retain)id<SomeTypeSelectedDelegate>delegate;
@end
