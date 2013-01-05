//
//  ShopDetailFoodChooseWineCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-10-11.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
@interface ShopDetailFoodChooseWineCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    IBOutlet UILabel * mWineNameLabel;
    IBOutlet UIImageView * mWineLogoImage;
    NSDictionary * mWineInfo;//wine_id;wine_name;wine_logo;wine_food;wine_introduce;
}
@property(nonatomic,retain)NSDictionary * mWineInfo;
-(void)refreshData;
@end
