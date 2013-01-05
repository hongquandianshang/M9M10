//
//  CommentContentViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-26.
//
//

#import "BaseNetworkViewController.h"
#import "UIPlaceHolderTextView.h"
#import "TKAlertCenter.h"
@interface CommentContentViewController : BaseNetworkViewController<UITextViewDelegate>
{
    IBOutlet UIPlaceHolderTextView * mTextView;
    int mShopId;
    int mWineId;
    IBOutlet UIView *editInputView;
    IBOutlet UILabel *numLabel;
}
@property(nonatomic,assign)int mShopId;
@property(nonatomic,assign)int mWineId;

-(IBAction)XClicked:(id)sender;
@end
