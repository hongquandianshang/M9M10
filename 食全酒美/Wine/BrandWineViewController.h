//
//  BrandWineViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
@interface BrandWineViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray  *mWineBrandArray;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mtableView;
    BOOL isLoading;
    BOOL isEnding;
    int mPageNum;
}
@property(nonatomic,retain)NSMutableArray* mWineBrandArray;
@end
