//
//  BaseNetworkViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHandler.h"
#import "JSON.h"
#import "CustomTabbar.h"
#import "MarqueeLabel.h"
@interface BaseNetworkViewController : UIViewController
{
    DataHandler * dataHandler;
    NSMutableData * receivedData;
    CustomTabbar * mTabbar;
}
@property(nonatomic,retain)NSMutableData * receivedData;
@property(nonatomic,retain)CustomTabbar * mTabbar;
- (void) hideTabBar:(BOOL) hidden;
- (void)setTitle:(NSString *)title;
@end
