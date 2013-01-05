//
//  SplashViewController.h
//  CardBump
//
//  Created by 香成 李 on 11-12-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController<UIScrollViewDelegate>{
	int curentScrollPage;
    
    UIScrollView *scrollView;
    UIPageControl *pageControl;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;

- (void)fadeScreen;
@end
