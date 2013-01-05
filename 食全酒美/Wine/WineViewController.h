//
//  WineViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
@interface WineViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView * mTrigleView;
    IBOutlet UIView * mSelectedView;
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    NSMutableArray * mWineActivityArray;
    BOOL isLoading;
    BOOL isEnding;
    int mPageNum;
}
@property(nonatomic,retain)NSMutableArray * mWineActivityArray;
-(IBAction)AllWine:(id)sender;
-(IBAction)BrandWine:(id)sender;
-(IBAction)WineActivity:(id)sender;
-(IBAction)WineRecommand:(id)sender;
-(IBAction)WineShow:(id)sender;
@end
