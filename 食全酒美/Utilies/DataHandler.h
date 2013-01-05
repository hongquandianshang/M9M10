//
//  DataHandler.h
//  食全酒美
//
//  Created by dev dev on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

//#define rootUrl @"http://180.168.44.226:8888/m9m10/ws/sqjm"
#define rootUrl @"http://183.129.245.49:3389/m9m10/ws/sqjm"

@interface DataHandler : NSObject
{
    NSDictionary * baseDic;
    NSMutableDictionary * userInfoDic;//nickname;userid;userpic;usersource;
}
@property(nonatomic,retain)NSDictionary *baseDic;
@property(nonatomic,retain)NSMutableDictionary *userInfoDic;
- (void)sendJSON: (NSDictionary *)jsonDic urlStr:(NSString *)urlStr delegate:(id)delegate;
-(NSString *)checkNetWorkType;
-(BOOL)checkUserLogin;
//1城市列表
-(void)CityListRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//2美酒类型列表
-(void)WineTypeListRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//3美酒品牌列表
-(void)WineBrandListRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//4美酒活动列表
-(void)WineEventListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)wineTypeId:(id)delegate;
//5此美酒所属商家
-(void)WinePertainToShopListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)wineId:(id)delegate;
//6商家详情
-(void)ShopDetailRecord:(NSInteger)shopid:(id)delegate;
//7此商家更多美酒列表
-(void)ShopToWineListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)shopid:(id)delegate;
//8美酒详情
-(void)WineDetailRecord:(NSInteger)wineid:(id)delegate;
//9品牌美酒列表
-(void)InBrandWineListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)winebrandId:(id)delegate;
//10全部美酒列表
-(void)InTypeWineListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)winetypeId:(NSString*)defaultValue:(NSString*)couponValue:(NSString*)priceValue:(id)delegate;
//11赞美酒
-(void)PraiseWineListRecord:(NSInteger)wineId:(id)delegate;
//12美酒收藏*************************************
-(void)WineCollectRecord:(NSInteger)wineId:(id)delegate;
//13取消收藏*************************************
-(void)CancelCollectRecord:(NSInteger)collectId:(id)delegate;
//14我收藏的美酒列表*************************************
-(void)MyCollectListRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//15美酒活动首页显示
-(void)WineEventIndexRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//16美酒评论*************************************
-(void)WineCommentRecord:(NSInteger)wineId:(NSString*)content:(id)delegate;
//17美酒评论列表
-(void)WineCommentListRecord:(NSInteger)wineId:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//18推荐美酒列表
-(void)RecommendWineListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSString*)defaulttype:(NSString*)coupon:(NSString*)price:(NSString*)wine_type:(id)delegate;
//19商家美食搭配
-(void)ShopInCateListRequestRecord:(NSInteger)shopId:(NSInteger)wineId:(id)delegate;
//20商家美酒美食搭配美酒列表
-(void)ShopWineIdListRequestRecord:(NSInteger)shopId:(id)delegate;
//21活动评论*************************************
-(void)EventCommentRequestRecord:(NSInteger)shopId:(NSString*)content:(id)delegate;
//22活动评论列表
-(void)EventCommentListRequestRecord:(NSInteger)shopId:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//23登录
-(void)LoginRequestRecord:(NSString*)userName:(NSString*)userPassword:(NSInteger)userSource:(NSString*)accountId:(NSString*)nickName:(NSString*)avatarurl:(id)delegate;
//24注册
-(void)RegisterRequestRecord:(NSString *)userName Password:(NSString *)password NickName:(NSString *)nickName ImageData:(NSData *)imageData Sex:(NSString*)sex Age:(NSString*)age Phone:(NSString*)phone Delegate:(id)delegate;
//25活动所属商家列表
-(void)EventBelongToShopListRecord:(NSInteger)wineEventId:(NSInteger)startNum:(NSInteger)endNum:(id)delegate;
//26活动优惠券下载****************************
-(void)DownloadCouponRequestRecord:(NSInteger)eventId:(NSInteger)shopId:(id)delegate;
//27我的优惠券列表****************************
-(void)MyDownloadListRequestRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//28删除我的优惠券****************************
-(void)DeleteMyCouponRequesetRecord:(NSInteger)couponId:(NSInteger)eventId:(id)delegate;
//29我的优惠券详情****************************
-(void)MyCouponDetailRequestRecord:(NSInteger)couponId:(id)delegate;
//30优惠活动列表
-(void)CouponListRqeustRecord:(NSInteger)startnum:(NSInteger)endnum:(NSString*)search:(id)delegate;
//31附近商家
-(void)NearByShopListRequestRecord:(NSNumber*)longitude:(NSNumber *)latitude:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//32商圈列表
-(void)BusinessAreaListRequestRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
//33其它分店列表
-(void)OthershopListRequestRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)shopId:(id)delegate;
//34活动详情
-(void)EventDetailRequestRecord:(NSInteger)eventId:(NSInteger)shopId:(id)delegate;
//35商家全部活动列表
-(void)ShopEventListRequestRecord:(NSInteger)shopId:(NSInteger)startnum:(NSInteger)endnum:(id)delegate;
@end
