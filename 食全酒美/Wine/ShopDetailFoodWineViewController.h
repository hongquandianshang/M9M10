//
//  ShopDetailFoodWineViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-10-10.
//
//

#import "BaseNetworkViewController.h"
#import "SDWebDataManager.h"
#import "SDWebDownLoadObject.h"
@interface ShopDetailFoodWineViewController : BaseNetworkViewController<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate,SDWebDownLoadObjectDelegate,UIScrollViewDelegate>
{
    int mShopId;
    int mWineId;
    int mArrangeNum;
    NSDictionary * mWineInfo;//wine_id;wine_name;wine_logo;wine_food;wine_introduce;
    NSMutableArray * mFoodInfo;//cate_id;cate_name;cate_logo;cate_introduce;
    IBOutlet UIScrollView * mScrollView;
    IBOutlet UILabel * mArrangeNumLabel;
    IBOutlet UILabel * mWineNameLabel;
    IBOutlet UIView * mWineContentView;
    IBOutlet UILabel * mWineContentLabel;
    IBOutlet UIImageView * mWineImageView;
    IBOutlet UILabel * mFoodTitleLabel;
    IBOutlet UILabel * mFoodContentLabel;
    UIScrollView * mFoodScrollView;
    UIPageControl *pageControl;
    NSMutableArray * mDownLoadObjectArray;
}
@property(nonatomic,retain)NSMutableArray * mFoodInfo;
@property(nonatomic,retain)NSDictionary * mWineInfo;
@property(nonatomic,retain)UIView * mWineContentView;;
@property(nonatomic,retain)UIScrollView * mScrollView;
@property(nonatomic,retain)UIScrollView * mFoodScrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)NSMutableArray * mDownLoadObjectArray;
@property(nonatomic,assign)int mShopId;
@property(nonatomic,assign)int mWineId;
@property(nonatomic,assign)int mArrangeNum;
@end
