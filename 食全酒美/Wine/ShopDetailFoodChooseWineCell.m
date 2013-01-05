//
//  ShopDetailFoodChooseWineCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-10-11.
//
//

#import "ShopDetailFoodChooseWineCell.h"

@implementation ShopDetailFoodChooseWineCell
@synthesize mWineInfo;
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
    mWineNameLabel.text = [mWineInfo objectForKey:@"wine_name"];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mWineInfo objectForKey:@"wine_logo"]]delegate:self];
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    mWineLogoImage.image = [UIImage imageWithData:aData];
}
@end
