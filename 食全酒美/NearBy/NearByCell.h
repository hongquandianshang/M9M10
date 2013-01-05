//
//  NearByCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-19.
//
//
#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"

@interface NearByCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    UIImageView * mShopLogo;
    UILabel * mShopNameLabel;
    UILabel * mCuisinesLabel;
    UILabel * mAddressLabel;
    UIImageView * mAddressLogo;
    UILabel * mDistanceLabel;
    UIImageView *mCellLineIV;
}

@property (nonatomic, retain) IBOutlet UIImageView *mShopLogo;
@property (nonatomic, retain) IBOutlet UILabel * mShopNameLabel;
@property (nonatomic, retain) IBOutlet UILabel * mCuisinesLabel;
@property (nonatomic, retain) IBOutlet UILabel * mAddressLabel;
@property (nonatomic, retain) IBOutlet UIImageView * mAddressLogo;
@property (nonatomic, retain) IBOutlet UILabel * mDistanceLabel;
@property (nonatomic, retain) IBOutlet UIImageView *mCellLineIV;

@end
