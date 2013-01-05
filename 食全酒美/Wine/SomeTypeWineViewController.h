//
//  SomeTypeWineViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-3.
//
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "SomeTypeSelectedViewController.h"
@interface SomeTypeWineViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate,SomeTypeSelectedDelegate>
{
    int mWineId;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    IBOutlet UIButton * mDefaultButton;
    IBOutlet UIButton * mCouponButton;
    IBOutlet UIButton * mPriceButton;
    IBOutlet UIImageView * mPriceIndicator;
    NSMutableArray * mSomeTypeWineArray;
    int mPageNum;
    BOOL isLoading;
    BOOL isEnding;
    BOOL isPriceDesc;
}
@property(nonatomic,assign)int mWineId;
@property(nonatomic,retain)NSMutableArray * mSomeTypeWineArray;

-(IBAction)SelectedClicked:(id)sender;
-(IBAction)DefaultClicked:(id)sender;
-(IBAction)CouponClicked:(id)sender;
-(IBAction)PriceClicked:(id)sender;
@end
