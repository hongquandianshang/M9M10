//
//  WineRecommendCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-3.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
@interface WineRecommendCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    IBOutlet UIImageView * mLogoImageView;
    IBOutlet UILabel * mChineseNameLabel;
    IBOutlet UILabel * mEnglishNameLabel;
    IBOutlet UILabel * mPriceLabel;
    IBOutlet UILabel * mCollectLabel;
    NSDictionary * mWineRecommendDictionary;//wine_id;wine_name;wine_enname;wine_logo;wine_price;collect_count;discount;
}
@property(nonatomic,retain)NSDictionary * mWineRecommendDictionary;
@end
