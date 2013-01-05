//
//  AboutUsViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-10-26.
//
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "AboutCell.h"
#import "PrivacyViewController.h"

@interface AboutUsViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView * mTableView;
}

@end
