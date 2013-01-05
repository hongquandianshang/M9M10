//
//  MoreViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHandler.h"
#import "JSON.h"
#import "BaseNetWorkViewController.h"
#import "SDWebDataManager.h"
#import "TKAlertCenter.h"

@interface MoreViewController : BaseNetworkViewController<UIAlertViewDelegate,SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    IBOutlet UIImageView * mUserImageView;
    IBOutlet UILabel * mUserNameLabel;
    
}
-(IBAction)MyCityClicked:(id)sender;
-(IBAction)MyWineClicked:(id)sender;
-(IBAction)MyCouponClicked:(id)sender;
-(IBAction)ManagerAccountClicked:(id)sender;
-(IBAction)FeedbackClicked:(id)sender;
-(IBAction)AboutUsClicked:(id)sender;
@end
