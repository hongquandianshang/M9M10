//
//  WineRecommandViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-8-31.
//
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "RecommendSelectedViewController.h"
@interface WineRecommandViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate,RecommendSelectedDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    IBOutlet UIButton * mDefaultButton;
    IBOutlet UIButton * mCouponButton;
    IBOutlet UIButton * mPriceButton;
    IBOutlet UIImageView * mPriceIndicator;
    NSMutableArray  *mWineRecommandArray;
    int mPageNum;
    BOOL isLoading;
    BOOL isEnding;
    int mWineId;
    BOOL isPriceDesc;
}
@property(nonatomic,retain)NSMutableArray * mWineRecommandArray;
-(IBAction)DefaultClicked:(id)sender;
-(IBAction)CouponClicked:(id)sender;
-(IBAction)PriceClicked:(id)sender;
-(IBAction)SelectedClicked:(id)sender;
@end
