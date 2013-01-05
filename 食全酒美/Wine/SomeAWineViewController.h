//
//  SomeAWineViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-6.
//
//

#import "BaseNetworkViewController.h"
#import "SDWebDataManager.h"
#import "SDWebDownLoadObject.h"
#import "TKAlertCenter.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "LoginViewController.h"
@interface SomeAWineViewController : BaseNetworkViewController<UIAlertViewDelegate,SDWebDataDownloaderDelegate,SDWebDataManagerDelegate,SDWebDownLoadObjectDelegate,UIScrollViewDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate>
{
    int mWineId;
    NSDictionary * mWineDetail;//wine_id;wine_name;wine_enname;wine_country;wine_color;wine_smell;wine_taste;wine_potentia;wine_foodmatches;wine_breed;wine_praisecount;wine_collect_count;wine_comment_count;wine_pricearea;wine_starlevel;wine_brandstory;wine_introduce;wine_logos;
    
    IBOutlet UIScrollView * mScrollView;
    IBOutlet UIView * mContentView;
    IBOutlet UIView * mVillageIntroduceTitleView;
    IBOutlet UIView * mTestNoteTitleView;
    IBOutlet UIScrollView * mWineScrollView;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UILabel * mBrandStoryLabel;
    IBOutlet UILabel * mVillageIntroductionLabel;
    IBOutlet UILabel * mTestNoteLabel;
    IBOutlet UILabel * mPriceLabel;
    IBOutlet UILabel * mCountryLabel;
    IBOutlet UILabel * mBreedLabel;
    
    IBOutlet UILabel * mCommentNumberLabel;
    IBOutlet UILabel * mCollectNumberLabel;
    IBOutlet UILabel * mPraiseNumberLabel;
    IBOutlet UIImageView * mPraiseIV;
    
    IBOutlet UIImageView * mStarLevel1;
    IBOutlet UIImageView * mStarLevel2;
    IBOutlet UIImageView * mStarLevel3;
    IBOutlet UIImageView * mStarLevel4;
    IBOutlet UIImageView * mStarLevel5;
    
    NSMutableArray * mDownLoadObjectArray;
}
@property(nonatomic,assign)int mWineId;
@property(nonatomic,retain)NSDictionary* mWineDetail;
@property(nonatomic,retain)NSMutableArray * mDownLoadObjectArray;

-(IBAction)SeeShop:(id)sender;
@end
