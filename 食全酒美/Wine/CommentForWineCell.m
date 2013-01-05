//
//  CommentForWineCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-10-11.
//
//

#import "CommentForWineCell.h"

@implementation CommentForWineCell
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
    mNickNameLabel.text = [mCommentDic objectForKey:@"comment_nickname"];
    mCommentLabel.text = [mCommentDic objectForKey:@"comment_content"];
    CGSize size = [mCommentLabel.text sizeWithFont:mCommentLabel.font constrainedToSize:CGSizeMake(mCommentLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame = mCommentLabel.frame;
    frame.size=size;
    mCommentLabel.frame=frame;
    
    mDateLable.text = [mCommentDic objectForKey:@"comment_date"];
    mImageView.image = [UIImage imageNamed:@"defaultPerson.png"];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mCommentDic objectForKey:@"comment_userlogo"]]delegate:self];
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mImageView.image = [UIImage imageWithData:aData];
    }
}
- (void)webDataManager:(SDWebDataManager *)dataManager didFailWithError:(NSError *)error{
    mImageView.image = [UIImage imageNamed:@"defaultPerson.png"];
}
@end
