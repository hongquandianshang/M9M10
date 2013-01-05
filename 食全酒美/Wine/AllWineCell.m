//
//  AllWineCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-9-3.
//
//

#import "AllWineCell.h"

@implementation AllWineCell
@synthesize mDownloadURL;
@synthesize mWineTypeName;
@synthesize mWineInfo;
@synthesize CellType;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)refreshData
{
    switch (CellType) {
        case 1:
        {
            mWineNameLabel.text = [mWineInfo objectForKey:@"wine_type_name"];
            SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
            [tempDownLoader downloadWithURL:[NSURL URLWithString:[mWineInfo objectForKey:@"wine_type_logo"]] delegate:self];
        }
            break;
        case 2:
        {
            mWineNameLabel.text = [mWineInfo objectForKey:@"wine_brand_name"];
            SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
            [tempDownLoader downloadWithURL:[NSURL URLWithString:[mWineInfo objectForKey:@"wine_brand_logo"]] delegate:self];
            NSLog(@"%@",[mWineInfo objectForKey:@"wine_brand_logo"]);
        }
            break;
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    mSelectedIndicator.hidden = !selected;
    // Configure the view for the selected state
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mWineImageView.image = [UIImage imageWithData:aData];
    }
}
@end
