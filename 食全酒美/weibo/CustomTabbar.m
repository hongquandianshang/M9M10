//
//  CustomTabbar.m
//  BabyFace2
//
//  Created by dev dev on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomTabbar.h"
#define ContainViewTag 1001
@implementation CustomTabbar
@synthesize mContainView;
@synthesize isneedSetOne;
-(id)init
{
    if (self=[super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self whenTabbarIsUnselected];
    [self addCustomTabbarElements];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%f,%f",((UIButton*)[tabBtn objectAtIndex:0]).frame.size.height,self.view.frame.size.height);
    for (UIView * view in self.view.subviews)
    {
        if (![view isKindOfClass:[UIButton class]])
        {
            if (view.frame.origin.y>160&&view.tag !=ContainViewTag)
            {
                view.hidden = YES;
            }
        }
        //[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 49)];
    }
    //[self.view setFrame:CGRectMake(0, 0, 320, 40)];
    NSLog(@"%f,%f",((UIButton*)[tabBtn objectAtIndex:0]).frame.size.height,self.view.frame.size.height);
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    //[self initTab];
//    [self whenTabbarIsUnselected];
//    [self addCustomTabbarElements];
//    self.view.backgroundColor = [UIColor whiteColor];
//     NSLog(@"%f,%f",((UIButton*)[tabBtn objectAtIndex:0]).frame.size.height,self.view.frame.size.height);
//    for (UIView * view in self.view.subviews) 
//    {
//        if (![view isKindOfClass:[UIButton class]]) 
//        {
//            if (view.frame.origin.y>160&&view.tag !=ContainViewTag)
//            {
//                view.hidden = YES;
//            }
//        }
//        [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 49)];
//    }
//    //[self.view setFrame:CGRectMake(0, 0, 320, 40)];
//    NSLog(@"%f,%f",((UIButton*)[tabBtn objectAtIndex:0]).frame.size.height,self.view.frame.size.height);
}
-(void)viewDidAppear:(BOOL)animated
{
    if (isneedSetOne) {
        [self whenTabbarIsSelected:0];
        isneedSetOne = NO;
    }
    
}
-(void)dealloc
{
    [tabBtn release];
    [super dealloc];
}
-(void)whenTabbarIsUnselected
{
//    for (UIView *view in self.view.subviews) 
//    {
//        if ([view isKindOfClass:[UITabBar class]]) 
//        {
//            view.hidden = YES;
//            break;
//        }
//    }
}

-(void)addCustomTabbarElements
{
    int tabNum = 4;
    if (!tabBtn) {
      tabBtn = [[NSMutableArray alloc]initWithCapacity:0];  
    }
    
    NSMutableArray * image = [[NSMutableArray alloc]init];
    NSString * wineBar = [NSString stringWithFormat:@"WineBarUnSelected.png"];
    NSString * nearByBar = [NSString stringWithFormat:@"NearByBarUnSelected.png"];
    NSString * couponBar = [NSString stringWithFormat:@"CouponBarUnSelected.png"];
    NSString * moreBar = [NSString stringWithFormat:@"MoreBarUnSelected.png"];
    [image addObject:wineBar];
    [image addObject:nearByBar];
    [image addObject:couponBar];
    [image addObject:moreBar];
    
    NSMutableArray *imageselected = [[NSMutableArray alloc]init];
    NSString * borntabselected = [NSString stringWithFormat:@"WineBarSelected.png"];
    NSString * forcasttabselected = [NSString stringWithFormat:@"NearByBarSelected.png"];
    NSString * ablumtabselected = [NSString stringWithFormat:@"CouponBarSelected.png"];
    NSString * sharetabselected = [NSString stringWithFormat:@"MoreBarSelected.png"];
    [imageselected addObject:borntabselected];
    [imageselected addObject:forcasttabselected];
    [imageselected addObject:ablumtabselected];
    [imageselected addObject:sharetabselected];
    
    
    int count = 0;
    for (UIView * view in [self.view subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            count++;
        }
    }
    self.mContainView = [[UIView alloc]initWithFrame:CGRectMake(0, 431, 320, self.view.frame.size.height)];
    mContainView.tag = ContainViewTag;
        for (int i=0; i<tabNum; i++) 
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(0+i*80, 0, 80, 49)];
            [btn setBackgroundImage:[UIImage imageNamed:(NSString*)[image objectAtIndex:i]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:(NSString*)[imageselected objectAtIndex:i]] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageNamed:(NSString*)[imageselected objectAtIndex:i]] forState:UIControlStateSelected];
            [btn setTag:i];
            [tabBtn addObject:btn];
            [btn addTarget:self action:@selector(buttonClickedTag:) forControlEvents:UIControlEventTouchUpInside];
            
            if (count==0)
            {
                [mContainView addSubview:btn];
                //[self.view addSubview:btn];
                NSLog(@"%@",self.view);
            }       
        }
    for (UIView * view in [self.view subviews]) {
        NSLog(@"%@",view);
    }
    [self.view addSubview:mContainView];
    //    [self.view bringSubviewToFront:tempview];
        [image release];
        [imageselected release];
    
}
-(void)disablebutton
{
    for (UIView * view in self.view.subviews) 
    {
//        if ([view isKindOfClass:[UIButton class]]) {
//            view.hidden = YES;
//        }
        if (view.tag == ContainViewTag)
        {
            view.hidden = YES;
        }
    }
}
-(void)enablebutton
{
    for (UIView * view in self.view.subviews) {
        if (view.tag == ContainViewTag) {
            view.hidden = NO;
        }
    }
}
-(void)disablebuttons
{
//    for (UIView * view in self.mContainView.subviews) 
//    {
//        if ([view isKindOfClass:[UIButton class]]) {
//            ((UIButton*)view).enabled = NO;
//        }
//        else
//        {
//            if (view.frame.origin.y>160) {
//                //view.hidden = YES;
//            }
//        }
//    }
}
-(void)enablebuttons
{
    for (UIView * view in self.mContainView.subviews) 
    {
        if ([view isKindOfClass:[UIButton class]]) {
            ((UIButton*)view).enabled = YES;
        }
    }
}
-(void)buttonClickedTag:(id)sender
{
    int tagNum = [sender tag];
    [self whenTabbarIsSelected:tagNum];
    
}
-(void)whenTabbarIsSelected:(int)tabID
{
    if (self.selectedIndex == tabID)
    {
        [[self.viewControllers objectAtIndex:tabID] popToRootViewControllerAnimated:YES];   
    }
    switch (tabID) 
    {
        case 0:
        {
            for (UIView * button in mContainView.subviews)
            {
                if ([button isKindOfClass:[UIButton class]]) 
                {
                    if (button.tag == 0) {
                        [(UIButton*)button setSelected:YES];
                    }
                    else {
                        [(UIButton*)button setSelected:NO];
                    }
                }
            }
        }
            break;
        case 1:
        {
            for (UIView * button in mContainView.subviews)
            {
                if ([button isKindOfClass:[UIButton class]]) 
                {
                    if (button.tag == 1) {
                        [(UIButton*)button setSelected:YES];
                    }
                    else {
                        [(UIButton*)button setSelected:NO];
                    }
                }
            }
        }
            break;
        case 2:
        {
            for (UIView * button in mContainView.subviews)
            {
                if ([button isKindOfClass:[UIButton class]]) 
                {
                    if (button.tag == 2) {
                        [(UIButton*)button setSelected:YES];
                    }
                    else {
                        [(UIButton*)button setSelected:NO];
                    }
                }
            }
        }
            break;
        case 3:
        {
            for (UIView * button in mContainView.subviews)
            {
                if ([button isKindOfClass:[UIButton class]]) 
                {
                    if (button.tag == 3) {
                        [(UIButton*)button setSelected:YES];
                    }
                    else {
                        [(UIButton*)button setSelected:NO];
                    }
                }
            }
        }
            break;
        default:
            break;
    }
    self.selectedIndex = tabID;
}
- (void) hideTabBar:(BOOL) hidden
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
	
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, 480-49, view.frame.size.width, view.frame.size.height)];
            }
        } 
        else 
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480-49)];
            }
        }
    }
    
    [UIView commitAnimations];
}
@end
