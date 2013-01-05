//
//  SDWebDownLoadObject.h
//  食全酒美
//
//  Created by zhenliang gong on 12-10-11.
//
//

#import <Foundation/Foundation.h>
#import "SDWebDataManager.h"
@protocol SDWebDownLoadObjectDelegate<NSObject>
@required
-(void)ImagefromWebAtIndex:(NSData*)imageDate index:(int)index;
@end
@interface SDWebDownLoadObject : NSObject<SDWebDataDownloaderDelegate,SDWebDataManagerDelegate>
{
    int  index;
    id<SDWebDownLoadObjectDelegate>delegate;
}
@property(nonatomic,assign)int index;
@property(nonatomic,retain)id<SDWebDownLoadObjectDelegate>delegate;
@end
