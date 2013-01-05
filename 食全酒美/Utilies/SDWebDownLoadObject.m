//
//  SDWebDownLoadObject.m
//  食全酒美
//
//  Created by zhenliang gong on 12-10-11.
//
//

#import "SDWebDownLoadObject.h"

@implementation SDWebDownLoadObject
@synthesize index;
@synthesize delegate;
-(void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
    //mActivityImage.image = [UIImage imageWithData:aData];
    [self.delegate ImagefromWebAtIndex:aData index:index];
}
@end
