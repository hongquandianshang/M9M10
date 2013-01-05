//
//  CouponCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-13.
//
//

#import "CouponCell.h"

@implementation CouponCell
@synthesize mCouponInfoDictionary;
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
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mCouponInfoDictionary objectForKey:@"coupon_url"]] delegate:self];
    // Configure the view for the selected state
}
-(void)loadData
{
    CGSize size = [[mCouponInfoDictionary objectForKey:@"event_title"] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(169, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    if (size.height>27) {
        [rateLabel removeFromSuperview];
        
        rateLabel=[[MarqueeLabel alloc] initWithFrame:CGRectMake(79,7,169, 27) rate:40.0f andFadeLength:5.0f];
        rateLabel.numberOfLines = 1;
        rateLabel.opaque = NO;
        rateLabel.enabled = YES;
        rateLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        rateLabel.textAlignment = UITextAlignmentLeft;//不会居中
        rateLabel.textColor = [UIColor blackColor];
        rateLabel.backgroundColor = [UIColor clearColor];
        rateLabel.font = [UIFont systemFontOfSize:15];
        rateLabel.text = [mCouponInfoDictionary objectForKey:@"event_title"];
        [self addSubview:rateLabel];
        [rateLabel release];
    }
    else{
        [titleLabel removeFromSuperview];
        titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(79,7,169, 27)];
        titleLabel.text = [mCouponInfoDictionary objectForKey:@"event_title"];
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLabel];
        [titleLabel release];
    }
    
    mContentLabel.text = [mCouponInfoDictionary objectForKey:@"coupon_content"];
    mPrriodLabel.text = [NSString stringWithFormat:@"活动时间:%@至%@",[mCouponInfoDictionary objectForKey:@"startdate"],[mCouponInfoDictionary objectForKey:@"enddate"]];
    mDownLoadCountLabel.text =[NSString stringWithFormat:@"下载%i次", [[mCouponInfoDictionary objectForKey:@"download_count"]intValue]];
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mImage.image = [UIImage imageWithData:aData];
    }
}
@end
