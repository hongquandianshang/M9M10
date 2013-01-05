//
//  ShopCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-27.
//
//

#import "ShopCell.h"

@implementation ShopCell
@synthesize mShopDic;
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
    mShopNameLabel.text = [mShopDic objectForKey:@"shop_name"];
    mShopCuisinesLabel.text = [mShopDic objectForKey:@"shop_cuisines"];
    mShopAddrLabel.text = [@"地址：" stringByAppendingString:[mShopDic objectForKey:@"shop_addr"]?[mShopDic objectForKey:@"shop_addr"]:@""];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mShopDic objectForKey:@"shop_logo"]]delegate:self];
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mShopLogoImageView.image = [UIImage imageWithData:aData];
    }
}
@end
