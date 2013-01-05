//
//  CommentForWineViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-10-11.
//
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
@interface CommentForWineViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView * mlogoBgView;
    IBOutlet UITableView * mTableView;
    int mWineId;
    BOOL isLoading;
    BOOL isEnding;
    NSMutableArray * mCommentArray;
    int mPagnum;

}
@property(nonatomic,assign)int mWineId;
@property(nonatomic,retain)NSMutableArray * mCommentArray;
-(IBAction)WriteCommentClicked:(id)sender;
@end
