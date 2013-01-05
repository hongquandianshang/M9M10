//
//  WineActivityCell.h
//  食全酒美
//
//  Created by dev dev on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
#import "CustomTabbar.h"
@interface WineActivityCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    NSDictionary * mActivityInformationDic;//wine_event_id wine_event_name wine_event_url wine_event_starttime wine_event_endtime
    int mIndex;
    IBOutlet UIImageView* mActivityImage;
    IBOutlet UILabel* mTitleLabel;
    IBOutlet UILabel* mContentLabel;
    IBOutlet UIView * mContentView;
}
@property(nonatomic,retain)NSDictionary * mActivityInformationDic;
@property(nonatomic,retain)CustomTabbar * mTabbar;
@property(nonatomic,assign)int mIndex;
-(void)refreshContentView;
-(void)refreshData;
@end
