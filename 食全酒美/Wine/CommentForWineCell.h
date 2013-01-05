//
//  CommentForWineCell.h
//  食全酒美
//
//  Created by zhenliang gong on 12-10-11.
//
//

#import <UIKit/UIKit.h>
#import "SDWebDataManager.h"
@interface CommentForWineCell : UITableViewCell<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    NSDictionary * mCommentDic;//comment_id;comment_nickname;comment_content;comment_date;comment_userlogo;
    IBOutlet UILabel * mNickNameLabel;
    IBOutlet UILabel * mCommentLabel;
    IBOutlet UILabel * mDateLable;
    IBOutlet UIImageView * mImageView;
}
@property(nonatomic,retain)NSDictionary * mCommentDic;
-(void)refreshData;
@end
