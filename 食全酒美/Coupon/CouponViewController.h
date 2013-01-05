//
//  CouponViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
@interface CouponViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTabelView;
    IBOutlet UISearchBar * mSearchBar;
    NSMutableArray * mCouponArray;
    BOOL isLoading;
    int mpagnum;
    BOOL isEnding;
}
@property(nonatomic,retain)NSMutableArray * mCouponArray;
@end
