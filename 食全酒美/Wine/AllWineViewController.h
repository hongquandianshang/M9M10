//
//  AllWineViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
@interface AllWineViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *mWineArray;//cate_id;cate_name;cate_logo;cate_introduce;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    int mPageNum;
    BOOL isLoading;
    BOOL isEnding;
}
@property(nonatomic,retain)NSMutableArray  *mWineArray;
@end
