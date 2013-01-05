//
//  AllWineCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-3.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
@interface AllWineCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    IBOutlet UILabel *mWineNameLabel;
    IBOutlet UIImageView * mWineImageView;
    IBOutlet UIImageView * mSelectedIndicator;
    NSDictionary * mWineInfo;//(1)wine_type_id;wine_type_name;wine_type_logo;
    //(2)wine_brand_id;wine_brand_name;wine_brand_logo;
    NSString * mDownloadURL;
    NSString * mWineTypeName;
    int CellType;//1for typeWine 2forbrandwine;
}
@property(nonatomic,copy)NSString* mDownloadURL;
@property(nonatomic,copy)NSString* mWineTypeName;
@property(nonatomic,retain)NSDictionary * mWineInfo;
@property(nonatomic,assign)int CellType;
-(void)refreshData;
@end
