//
//  NearByViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BaseNetworkViewController.h"
#import "SDWebDataManager.h"
@interface NearByViewController : BaseNetworkViewController<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CLLocationManager * mLocation;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    NSNumber * mLongtitude;
    NSNumber * mLatitude;
    NSMutableArray * mShopArray;//shop_id;shop_name;shop_addr;shop_cuisines;shop_logo;distance;
    BOOL isLoading;
    int mpagnum;
    BOOL isEnding;
}
@property(nonatomic,retain)CLLocationManager* mLocation;
@property(nonatomic,retain)NSNumber * mLongtitude;
@property(nonatomic,retain)NSNumber * mLatitude;
@property(nonatomic,retain)NSMutableArray * mShopArray;
@end
