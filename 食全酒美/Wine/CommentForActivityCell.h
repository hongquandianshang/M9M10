//
//  CommentForActivityCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-26.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
@interface CommentForActivityCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    NSDictionary * mCommentDic;//comment_id;shop_name;comment_nickname;user_logo;comment_content;comment_date;
    IBOutlet UILabel * mShopNameLabel;
    IBOutlet UILabel * mNickNameLabel;
    IBOutlet UILabel * mContentLabel;
    IBOutlet UILabel * mDateLabel;
    IBOutlet UIImageView * mImageView;
}
@property(nonatomic,retain)NSDictionary * mCommentDic;
-(void)refreshData;
@end
