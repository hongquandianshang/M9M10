//
//  FirstViewController.h
//  食全酒美
//
//  Created by dev dev on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabbar.h"
@interface FirstViewController : UIViewController
{
    CustomTabbar * mTabbar;
}
@property(nonatomic,retain)CustomTabbar* mTabbar;
-(IBAction)Clicked:(id)sender;
@end
