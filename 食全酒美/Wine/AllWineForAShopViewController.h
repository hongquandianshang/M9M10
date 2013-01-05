//
//  AllWineForAShopViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-26.
//
//

#import "BaseNetworkViewController.h"
#import "RecommendSelectedViewController.h"
@interface AllWineForAShopViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate,RecommendSelectedDelegate>
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
    int mShopId;
    BOOL isPriceDesc;
}
@property(nonatomic,retain)NSMutableArray * mWineRecommandArray;
@property(nonatomic,assign)int mShopId;
-(IBAction)DefaultClicked:(id)sender;
-(IBAction)CouponClicked:(id)sender;
-(IBAction)PriceClicked:(id)sender;
@end
