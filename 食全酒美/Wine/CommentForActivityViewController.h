//
//  CommentForActivityViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-26.
//
//

#import "BaseNetworkViewController.h"

@interface CommentForActivityViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
{
   IBOutlet UIImageView * mlogoBgView;
   IBOutlet UITableView * mTableView;
   BOOL isLoading;
    BOOL isEnding;
   NSMutableArray * mCommentArray;
    int mPagnum;
    int mShopId;
}
@property(nonatomic,retain)NSMutableArray *  mCommentArray;
@property (nonatomic,assign)int mShopId;
-(IBAction)CommentClicked:(id)sender;
@end
