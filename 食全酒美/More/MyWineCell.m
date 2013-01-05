//
//  MyWineCell.m
//  食全酒美
//
//  Created by zhenliang gong on 12-10-12.
//
//

#import "MyWineCell.h"

@implementation MyWineCell
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
-(IBAction)DeleteClicked:(id)sender
{
    [self.delegate WineDeleteAtIndex:index];
}
-(void)refreshData
{
    mWineNameLabel.text = [mWineInfo objectForKey:@"wine_name"];
    mWineEnNameLabel.text = [mWineInfo objectForKey:@"wine_enname"];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mWineInfo objectForKey:@"wine_logo"]]delegate:self];
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mWineLogo.image = [UIImage imageWithData:aData];
    }
}
@end
