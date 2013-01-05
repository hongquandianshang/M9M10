//
//  NearByCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-19.
//
//

#import "NearByCell.h"

@implementation NearByCell

@synthesize mShopLogo;
@synthesize mShopNameLabel;
@synthesize mCuisinesLabel;
@synthesize mAddressLabel;
@synthesize mAddressLogo;
@synthesize mDistanceLabel;
@synthesize mCellLineIV;

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

- (void)dealloc
{
    [mShopLogo release];
    [mShopNameLabel release];
    [mCuisinesLabel release];
    [mAddressLabel release];
    [mAddressLogo release];
    [mDistanceLabel release];
    [mCellLineIV release];
    [super dealloc];
}

-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mShopLogo.image = [UIImage imageWithData:aData];
    }
}
@end
