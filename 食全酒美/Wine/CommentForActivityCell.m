//
//  CommentForActivityCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-26.
//
//

#import "CommentForActivityCell.h"

@implementation CommentForActivityCell
@synthesize mCommentDic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)refreshData
{
    mShopNameLabel.text = [mCommentDic objectForKey:@"shop_name"];
    mNickNameLabel.text = [mCommentDic objectForKey:@"comment_nickname"];
    mContentLabel.text = [mCommentDic objectForKey:@"comment_content"];
    CGSize size = [mContentLabel.text sizeWithFont:mContentLabel.font constrainedToSize:CGSizeMake(mContentLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame = mContentLabel.frame;
    frame.size=size;
    mContentLabel.frame=frame;
    
    mDateLabel.text = [mCommentDic objectForKey:@"comment_date"];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mCommentDic objectForKey:@"comment_userlogo"]] delegate:self];
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mImageView.image = [UIImage imageWithData:aData];
    }
}
@end
