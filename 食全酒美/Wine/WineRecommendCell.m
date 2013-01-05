//
//  WineRecommendCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-3.
//
//

#import "WineRecommendCell.h"

@implementation WineRecommendCell
@synthesize mWineRecommendDictionary;
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
-(void)drawRect:(CGRect)rect
{
    mChineseNameLabel.text = [mWineRecommendDictionary objectForKey:@"wine_name"];
    mEnglishNameLabel.text = [mWineRecommendDictionary objectForKey:@"wine_enname"];
    mPriceLabel.text = [NSString stringWithFormat:@"¥ %@",[mWineRecommendDictionary objectForKey:@"wine_price"]];
    mCollectLabel.text = [NSString stringWithFormat:@"%@人收藏",[mWineRecommendDictionary objectForKey:@"collect_count"]];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mWineRecommendDictionary objectForKey:@"wine_logo"]]delegate:self];
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mLogoImageView.image = [UIImage imageWithData:aData];
    }
}
@end
