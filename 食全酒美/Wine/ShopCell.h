//
//  ShopCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-27.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
@interface ShopCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    NSDictionary * mShopDic;//shop_id;shop_name;shop_addr;shop_logo;shop_cuisines;
    IBOutlet UILabel * mShopNameLabel;
    IBOutlet UILabel * mShopCuisinesLabel;
    IBOutlet UILabel * mShopAddrLabel;
    IBOutlet UIImageView * mShopLogoImageView;
}
@property(nonatomic,retain)NSDictionary * mShopDic;
-(void)refreshData;
@end
