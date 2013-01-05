//
//  SomeTypeWineCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-3.
//
//

#import "SomeTypeWineCell.h"

@implementation SomeTypeWineCell
@synthesize mDictionary;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)reloadData
{
    mWineChineseNameLabel.text = [mDictionary objectForKey:@"wine_name"];
    mWineEnglishNameLabel.text = [mDictionary objectForKey:@"wine_enname"];
    mPriceLabel.text = [NSString stringWithFormat:@"¥ %@",[mDictionary objectForKey:@"wine_price"]];
    mPraiseLabel.text = [NSString stringWithFormat:@"%@人赞",[mDictionary objectForKey:@"praise_count"]];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mDictionary objectForKey:@"wine_logo"]] delegate:self];
    NSString *discount=[mDictionary objectForKey:@"discount"];
    if (discount && discount.length>0)
    {
        mActivityIndicator.hidden = NO;
    }
    else
    {
        mActivityIndicator.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mWineLogoImageView.image = [UIImage imageWithData:aData];
    }
}
@end
