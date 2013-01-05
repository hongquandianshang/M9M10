//
//  MyWineCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-10-12.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
@protocol MyWineCellDelegate<NSObject>
@required
-(void)WineDeleteAtIndex:(int)index;
@end
@interface MyWineCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    NSDictionary * mWineInfo;//collect_id;wine_id;wine_name;wine_enname;wine_logo;wine_price;collect_date;
    int index;
    IBOutlet UILabel * mWineNameLabel;
    IBOutlet UILabel * mWineEnNameLabel;
    IBOutlet UIImageView * mWineLogo;
    id<MyWineCellDelegate>delegate;
}
@property(nonatomic,retain)NSDictionary * mWineInfo;
@property(nonatomic,assign)int index;
@property(nonatomic,retain)id<MyWineCellDelegate>delegate;
-(void)refreshData;
@end
