//
//  SomeTypeWineCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-3.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
@interface SomeTypeWineCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    IBOutlet UILabel* mWineEnglishNameLabel;
    IBOutlet UILabel* mWineChineseNameLabel;
    IBOutlet UIImageView* mWineLogoImageView;
    IBOutlet UILabel* mPriceLabel;
    IBOutlet UILabel* mPraiseLabel;
    IBOutlet UIImageView * mActivityIndicator;
    NSDictionary * mDictionary;//wine_id;wine_name;wine_enname;wine_logo;wine_price;praise_count;discount;
}
@property(nonatomic,retain)NSDictionary* mDictionary;
-(void)reloadData;
@end
