//
//  AboutCell.m
//  Hunt
//
//  Created by Li XiangCheng on 12-8-29.
//  Copyright (c) 2012年 Li XiangCheng. All rights reserved.
//

#import "AboutCell.h"

@implementation AboutCell

@synthesize tipLabel;

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
    [tipLabel release];
    [super dealloc];
}

@end
