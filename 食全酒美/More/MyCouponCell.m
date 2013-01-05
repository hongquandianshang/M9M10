//
//  MyCouponCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-17.
//
//

#import "MyCouponCell.h"

@implementation MyCouponCell
@synthesize mCouponInfo;
@synthesize index;
@synthesize delegate;
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
-(IBAction)DeleteClicked:(id)sender
{
    [self.delegate CouponDeleteAtIndex:self.index];
}
-(void)refreshData
{
    CGSize size = [[mCouponInfo objectForKey:@"event_title"] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(180, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    if (size.height>27) {
        [rateLabel removeFromSuperview];
        
        rateLabel=[[MarqueeLabel alloc] initWithFrame:CGRectMake(79,16,180, 27) rate:40.0f andFadeLength:5.0f];
        rateLabel.numberOfLines = 1;
        rateLabel.opaque = NO;
        rateLabel.enabled = YES;
        rateLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        rateLabel.textAlignment = UITextAlignmentLeft;//不会居中
        rateLabel.textColor = [UIColor blackColor];
        rateLabel.backgroundColor = [UIColor clearColor];
        rateLabel.font = [UIFont systemFontOfSize:15];
        rateLabel.text = [mCouponInfo objectForKey:@"event_title"];
        [self addSubview:rateLabel];
        [rateLabel release];
    }
    else{
        [titleLabel removeFromSuperview];
        titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(79,16,180, 27)];
        titleLabel.text = [mCouponInfo objectForKey:@"event_title"];
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLabel];
        [titleLabel release];
    }
    
    
    mTitleLabel.text = [mCouponInfo objectForKey:@"coupon_content"];
//    mDateLabel.text = [NSString stringWithFormat:@"%@ %@",[mCouponInfo objectForKey:@"startdate"],[mCouponInfo objectForKey:@"enddate"]];
    mDateLabel.text = [NSString stringWithFormat:@"有效期:%@", [[mCouponInfo objectForKey:@"enddate"] substringToIndex:10]];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mCouponInfo objectForKey:@"coupon_url"]]delegate:self];
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mCouponLogo.image = [UIImage imageWithData:aData];
    }
}
@end
