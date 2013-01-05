//
//  CustomTabbar.h
//  BabyFace2
//
//  Created by dev dev on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CustomTabbar : UITabBarController{
    UIImageView * backgroundImage;
    UIImageView * selectImage;
    UIImageView * tabBarBg;
    NSMutableArray *tabBtn;
    UIButton *btn;
    UIView * mContainView;
    BOOL isneedSetOne;
}
@property(nonatomic,retain)UIView * mContainView;
@property(nonatomic,assign)BOOL isneedSetOne;
-(void)initTab;
-(void)whenTabbarIsUnselected;  
-(void)addCustomTabbarElements;
-(void)whenTabbarIsSelected:(int)tabID;
-(void)disablebutton;
-(void)enablebutton;
-(void)disablebuttons;
-(void)enablebuttons;
@end
