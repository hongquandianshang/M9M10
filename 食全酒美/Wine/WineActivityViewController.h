//
//  WineActivityViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "WineActivitySelectedWineViewController.h"
@interface WineActivityViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate,WineActivitySelectedWineDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    BOOL isLoading;
    BOOL isEnding;
    NSMutableArray * mWineActivityArray;
    int mPageNum;
    int mWineTypeId;
}
@property(nonatomic,retain)NSMutableArray * mWineActivityArray;
@end
