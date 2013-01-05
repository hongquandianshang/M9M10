//
//  WineActivityCell.m
//  食全酒美
//
//  Created by dev dev on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WineActivityCell.h"

@implementation WineActivityCell
@synthesize mActivityInformationDic;
@synthesize mIndex;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshContentView:) name:@"RefreshContent" object:nil];
    SDWebDataManager *tempDownLoader = [SDWebDataManager sharedManager];
    [tempDownLoader downloadWithURL:[NSURL URLWithString:[mActivityInformationDic objectForKey:@"wine_event_url"]]delegate:self];
}
-(void)refreshData
{
    mTitleLabel.text = [mActivityInformationDic objectForKey:@"wine_event_name"];
    mContentLabel.text = [mActivityInformationDic objectForKey:@"wine_instruction"];
}
-(void)refreshContentView:(NSNotification*)notification
{
    if ([notification.object intValue]==mIndex)
    {
        mContentLabel.hidden = NO;
    }
    else
    {
        mContentLabel.hidden = YES;
    }
    
    int height = 0;
    CGSize size = [mTitleLabel.text sizeWithFont:mTitleLabel.font constrainedToSize:CGSizeMake(mTitleLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    mTitleLabel.frame = CGRectMake(0, 0, mTitleLabel.frame.size.width, size.height);
    
    height+=mTitleLabel.frame.size.height;
    
    if (!mContentLabel.hidden) {
        size = [mContentLabel.text sizeWithFont:mContentLabel.font constrainedToSize:CGSizeMake(mContentLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        mContentLabel.frame = CGRectMake(0, height, mContentLabel.frame.size.width, size.height);
        
        height+=mContentLabel.frame.size.height;
    }
    
    mContentView.frame=CGRectMake(310-mTitleLabel.frame.size.width, 89-height, mTitleLabel.frame.size.width, height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    if (aData) {
        mActivityImage.image = [UIImage imageWithData:aData];
    }
}
-(void)dealloc
{
    [mActivityInformationDic release];
    [super dealloc];
}
@end
