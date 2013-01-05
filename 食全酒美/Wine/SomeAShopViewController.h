//
//  SomeAShopViewController.h
//  食全酒美
//
//  Created by zhenliang gong on 12-9-12.
//
//

#import "BaseNetworkViewController.h"

@interface SomeAShopViewController : BaseNetworkViewController
{
    NSDictionary* mDictionary;
    int mShopId;
    int mEventId;
    IBOutlet UILabel * mlabel;
}
@property(nonatomic,retain)NSDictionary* mDictionary;
@property(nonatomic,assign)int mShopId;
@property(nonatomic,assign)int mEventId;
-(IBAction)SeeTheShopClicked:(id)sender;
@end
