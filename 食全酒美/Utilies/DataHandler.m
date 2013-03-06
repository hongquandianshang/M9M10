//
//  DataHandler.m
//  食全酒美
//
//  Created by dev dev on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataHandler.h"
#import "SynthesizeSingleton.h"
#import "JSON.h"
#import "Reachability.h"
#define BOUNDRY @"0xKhTmLbOuNdArY"
@implementation DataHandler
@synthesize baseDic;
@synthesize userInfoDic;
SYNTHESIZE_SINGLETON_FOR_CLASS(DataHandler);
-(id)init
{
    if (self=[super init])
    {
        self.baseDic = [NSDictionary dictionaryWithObjectsAndKeys:
                        @"ios" ,@"os",@"iphone",@"device",[[UIDevice currentDevice]  uniqueIdentifier] ,@"deviceid",@"10" ,@"version",[[UIDevice currentDevice]  uniqueIdentifier] ,@"token",nil];
        //self.userInfoDic = [NSMutableDictionary dictionaryWithCapacity:0];
        self.userInfoDic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userInfoDic"]];
    }
    return self;
}
- (void)sendJSON: (NSDictionary *)jsonDic urlStr:(NSString *)urlStr delegate:(id)delegate{
    
    SBJSON *sb = [[SBJSON alloc] init];
    NSString *jsonStr = [sb stringWithObject:jsonDic error:nil];
    NSLog(@"%@ %@",urlStr,jsonDic);
    //    NSString *urlStr = [urlString1 stringByAppendingString:jsonStr];
    [sb release];
    //    设置Post
    
    //NSString *body1 = [NSString stringWithFormat:@"json=%@",jsonStr];
    //NSLog(@"send=jsonStr＝＝%@",jsonStr);
    // NSString *body = [jsonStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    NSData *postData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url=[rootUrl stringByAppendingString:urlStr];
    NSLog(@"url===%@",url);
    NSURL *baseUrl = [NSURL URLWithString:url];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init] ;
    [urlRequest setURL:baseUrl];
    if (!urlRequest) {
        NSLog(@"Error creating the URL Request");
    }
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    [urlRequest setTimeoutInterval:10.0];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:delegate];
    
    [urlRequest release];
    [conn release];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate showWaitView:@"请稍等..."];//显示
    
}
-(NSString *)checkNetWorkType {
    // 检查网络状态
	NSString *netType = nil;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
		case NotReachable:
			// 没有网络连接
			netType = @"no";
			break;
		case ReachableViaWWAN:
			// 使用3G网络
			netType = @"3G";
			break;
		case ReachableViaWiFi:
			// 使用WiFi网络
			netType = @"WiFi";
			break;
    }
	//NSLog(@"netType:%@",netType);
    return netType;
}
-(BOOL)checkUserLogin
{
    if ([userInfoDic objectForKey:@"userid"])
    {
        return YES;
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    return NO;
}
//1城市列表
-(void)CityListRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    NSMutableDictionary * jsonDic =[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",@"",@"city",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"CityListRecord",nil] urlStr:@"/citylist" delegate:(id)delegate];
}
//2美酒类型列表
-(void)WineTypeListRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WineTypeListRecord",nil] urlStr:@"/winetype" delegate:(id)delegate];
}
//3美酒品牌列表
-(void)WineBrandListRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    NSMutableDictionary * jsonDic =[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WineBrandListRecord",nil] urlStr:@"/winebrandlist" delegate:(id)delegate];
}
//4美酒活动列表
-(void)WineEventListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)wineTypeId:(id)delegate
{
    if (wineTypeId == 0) {
        NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",[NSString stringWithFormat:@""],@"wine_type_id",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WineEventListRecord",nil] urlStr:@"/wineevent" delegate:(id)delegate];
    }
    else
    {
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",[NSString stringWithFormat:@"%i",wineTypeId],@"wine_type_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WineEventListRecord",nil] urlStr:@"/wineevent" delegate:(id)delegate];
    }
}
//5此美酒所属商家
-(void)WinePertainToShopListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)wineId:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",[NSString stringWithFormat:@"%i",wineId],@"wine_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WinePertainToShopListRecord",nil] urlStr:@"/pertaintoshop" delegate:(id)delegate];
}
//6商家详情
-(void)ShopDetailRecord:(NSInteger)shopid:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",shopid],@"shop_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"ShopDetailRecord",nil] urlStr:@"/shopdetail" delegate:(id)delegate];
}
//7美酒详情
-(void)WineDetailRecord:(NSInteger)wineid:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",wineid],@"wine_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WineDetailRecord",nil] urlStr:@"/winedetail" delegate:(id)delegate];
}
//8此商家更多美酒列表
-(void)ShopToWineListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)shopid:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",[NSString stringWithFormat:@"%i",shopid],@"shop_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"ShopToWineListRecord",nil] urlStr:@"/shoptowine" delegate:(id)delegate];
}
//9某品牌下的美酒列表
-(void)InBrandWineListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)winebrandId:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",[NSString stringWithFormat:@"%i",winebrandId],@"wine_brand_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"InBrandWineListRecord",nil] urlStr:@"/inbrandwine" delegate:delegate];
}
//10某类型下的美酒列表
-(void)InTypeWineListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)winetypeId:(NSString*)defaultValue:(NSString*)couponValue:(NSString*)priceValue:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",[NSString stringWithFormat:@"%i",winetypeId],@"wine_type_id",defaultValue,@"system_default",couponValue,@"popularity",priceValue,@"price",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"InTypeWineListRecord",nil] urlStr:@"/intypewine" delegate:delegate];
                                 
}
//11赞美酒
-(void)PraiseWineListRecord:(NSInteger)wineId:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",wineId],@"wine_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"PraiseWineRecord",nil] urlStr:@"/praise" delegate:delegate];
}
//12美酒收藏*************************************
-(void)WineCollectRecord:(NSInteger)wineId:(id)delegate
{
    if ([self checkUserLogin])
    {
        NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfoDic objectForKey:@"userid"],@"user_id",[NSString stringWithFormat:@"%i",wineId],@"wine_id",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WineCollectRecord",nil] urlStr:@"/collect" delegate:delegate];
    }
}
//13取消收藏*************************************
-(void)CancelCollectRecord:(NSInteger)collectId:(id)delegate
{
    if ([self checkUserLogin])
    {
        NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",collectId],@"collect_id",[userInfoDic objectForKey:@"userid"],@"user_id",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"CancelCollectRecord",nil] urlStr:@"/cancelcollect" delegate:delegate];
    }
    
}
//14我收藏的美酒列表*************************************
-(void)MyCollectListRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    if ([self checkUserLogin])
    {
        NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfoDic objectForKey:@"userid"],@"user_id",[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"MyCollectListRecord",nil] urlStr:@"/mycollectlist" delegate:delegate];
    }
}
//15美酒活动首页显示
-(void)WineEventIndexRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WineEventIndexRecord",nil] urlStr:@"/eventindex" delegate:delegate];
}
//16美酒评论*************************************
-(void)WineCommentRecord:(NSInteger)wineId:(NSString*)content:(id)delegate
{
    if ([self checkUserLogin])
    {
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfoDic objectForKey:@"userid"],@"user_id",[NSString stringWithFormat:@"%i",wineId],@"wine_id",content,@"content",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WineCommentRecord",nil] urlStr:@"/winecomment" delegate:delegate];
    }
}
//17美酒评论列表
-(void)WineCommentListRecord:(NSInteger)wineId:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",wineId],@"wine_id",[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"WineCommentListRecord",nil] urlStr:@"/winecommentlist" delegate:delegate];
}
//18推荐美酒列表
-(void)RecommendWineListRecord:(NSInteger)startnum:(NSInteger)endnum:(NSString*)defaulttype:(NSString*)popularity:(NSString*)price:(NSString*)wine_type:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",defaulttype,@"system_default",popularity,@"popularity",price,@"price",wine_type,@"wine_type",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"RecommendWineListRecord",nil] urlStr:@"/recommenwinelist" delegate:delegate];
}
//19商家美食搭配
-(void)ShopInCateListRequestRecord:(NSInteger)shopId:(NSInteger)wineId:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",shopId],@"shop_id",[NSString stringWithFormat:@"%i",wineId],@"wine_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"ShopInCateListRequestRecord",nil] urlStr:@"/shopincatelist" delegate:delegate];
}
//20商家美酒美食搭配美酒列表
-(void)ShopWineIdListRequestRecord:(NSInteger)shopId:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",shopId],@"shop_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"ShopWineIdListRequestRecord",nil] urlStr:@"/shopwineidlist" delegate:delegate];
}
//21活动评论*************************************
-(void)EventCommentRequestRecord:(NSInteger)shopId:(NSString*)content:(id)delegate
{
    if ([self checkUserLogin])
    {
        NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfoDic objectForKey:@"userid"],@"user_id",[NSString stringWithFormat:@"%i",shopId],@"shop_id",content,@"content",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"EventCommentRequestRecord",nil] urlStr:@"/eventcomment" delegate:delegate];
    }
}
//22活动评论列表
-(void)EventCommentListRequestRecord:(NSInteger)shopId:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",shopId],@"shop_id",[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"EventCommentListRequestRecord",nil] urlStr:@"/eventcommentlist" delegate:delegate];
}
//23登录
-(void)LoginRequestRecord:(NSString*)userName:(NSString*)userPassword:(NSInteger)userSource:(NSString*)accountId:(NSString*)nickName:(NSString*)avatarurl:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"username",userPassword,@"password",[NSString stringWithFormat:@"%i",userSource],@"usersource",accountId,@"accountid",nickName,@"nickname",avatarurl,@"avatarurl" ,nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"LoginRequestRecord",nil] urlStr:@"/login" delegate:delegate];
}
//24注册
//-(void)RegisterRequestRecord:(NSString*)userName:(NSString*)password:(NSString*)nickName:(NSString*)image:(id)delegate
//{
//    NSMutableDictionary* jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:userName,@"username",password,@"password",nickName,@"nickname",image,@"image",nil];
//    [jsonDic addEntriesFromDictionary:baseDic];
//    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"RegisterRequestRecord",nil] urlStr:@"/register" delegate:delegate];
//}
//24注册
-(void)RegisterRequestRecord:(NSString *)userName Password:(NSString *)password NickName:(NSString *)nickName ImageData:(NSData *)imageData Sex:(NSString*)sex Age:(NSString*)age Phone:(NSString*)phone Delegate:(id)delegate
{
    NSString * json = [NSString stringWithFormat:@"{\"os\":\"ios\",  \"device\":\"iphone\",  \"deviceid\":\"%@\",  \"version\":\"10\",  \"token\":\"%@\", \"username\":\"%@\" , \"password\":\"%@\" , \"nickname\":\"%@\" , \"sex\":\"%@\", \"age\":\"%@\", \"phone\":\"%@\"}",[[UIDevice currentDevice]  uniqueIdentifier],[[UIDevice currentDevice]  uniqueIdentifier], userName,password,nickName,sex,age,phone];
    NSMutableData * postData = [NSMutableData dataWithCapacity:1024];
    NSString *url=[rootUrl stringByAppendingString:@"/register"];
    
    NSMutableURLRequest *urlRequest =
	[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDRY]forHTTPHeaderField:@"Content-Type"];
    
    //分隔符
	[postData appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
    //json项
    //     NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"json\"\r\n\r\n%@",json]dataUsingEncoding:NSUTF8StringEncoding]];
    //分隔符
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
    //imagedata项 jpeg png gif
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n",@""]dataUsingEncoding:NSUTF8StringEncoding]];
    if (imageData!=nil) {
        //数据内容
        [postData appendData:imageData];
    }
    //分隔符
	[postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
    
	[urlRequest setHTTPBody:postData];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //    NSError *error;
    //    NSURLResponse *response;
    //    NSData *result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    //
    //    if (!result) {
    //        NSLog(@"result      %@",result);
    //
    //    }
    //    NSString *str = [[[NSString alloc] initWithBytes:[result bytes] length:[result length] encoding:NSUTF8StringEncoding] autorelease];
    //    NSLog(@"str==%@",str);
    //    return [str JSONValue];
    
    
	// request.
    
    [urlRequest setTimeoutInterval:5.0];
    [urlRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    //https
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:urlRequest
                                                                   delegate:delegate];
    if(theConnection) {
		
	}
	else {
		NSLog(@" \n\n theConnection is NULL  \n\n ");
	}
}
//25活动所属商家列表
-(void)EventBelongToShopListRecord:(NSInteger)wineEventId:(NSInteger)startNum:(NSInteger)endNum:(id)delegate
{
    NSMutableDictionary* jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",wineEventId],@"wine_event_id",[NSString stringWithFormat:@"%i",startNum],@"startnum",[NSString stringWithFormat:@"%i",endNum],@"endnum",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"EventBelongToShopListRecord",nil] urlStr:@"/eventbelongtoshop" delegate:delegate];
}
//26活动优惠券下载****************************
-(void)DownloadCouponRequestRecord:(NSInteger)eventId:(NSInteger)shopId:(id)delegate
{
    if ([self checkUserLogin])
    {
        NSMutableDictionary* jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",eventId],@"event_id",[userInfoDic objectForKey:@"userid"],@"user_id",[NSString stringWithFormat:@"%i",shopId],@"shop_id",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"DownloadCouponRequestRecord", nil] urlStr:@"/downloadcoupon" delegate:delegate];
    }
}
//27我的优惠券列表****************************
-(void)MyDownloadListRequestRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    if ([self checkUserLogin])
    {
        NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfoDic objectForKey:@"userid"],@"user_id",[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"MyDownloadListRequestRecord", nil] urlStr:@"/mydownloadlist" delegate:delegate];
    }
    
}
//28删除我的优惠券****************************
-(void)DeleteMyCouponRequesetRecord:(NSInteger)couponId:(NSInteger)eventId:(id)delegate
{
    if ([self checkUserLogin])
    {
        NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfoDic objectForKey:@"userid"],@"user_id",[NSString stringWithFormat:@"%i",couponId],@"coupon_id",[NSString stringWithFormat:@"%i",eventId],@"event_id",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"DeleteMyCouponRequestRecord", nil] urlStr:@"/deletemycoupon" delegate:delegate];
    }
}
//29我的优惠券详情****************************
-(void)MyCouponDetailRequestRecord:(NSInteger)couponId:(id)delegate
{
    if ([self checkUserLogin])
    {
        NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[userInfoDic objectForKey:@"userid"],@"user_id",[NSString stringWithFormat:@"%i",couponId],@"coupon_id",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"MyCouponDetailRequestRecord", nil] urlStr:@"/mycoupondetail" delegate:delegate];
    }
}
//30优惠活动列表
-(void)CouponListRqeustRecord:(NSInteger)startnum:(NSInteger)endnum:(NSString*)search:(id)delegate
{
        NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",search,@"search",nil];
        [jsonDic addEntriesFromDictionary:baseDic];
        [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"CouponListRqeustRecord",nil] urlStr:@"/couponlist" delegate:delegate];
}
//31附近商家
-(void)NearByShopListRequestRecord:(NSNumber*)longitude:(NSNumber *)latitude:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",[longitude floatValue]],@"longitude",[NSString stringWithFormat:@"%f",[latitude floatValue]],@"latitude",[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"NearByShopListRequestRecord",nil] urlStr:@"/nearbyshop" delegate:delegate];
}
//32商圈列表
-(void)BusinessAreaListRequestRecord:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"BusinessAreaListRequestRecord",nil] urlStr:@"/businessarea" delegate:delegate];
}
//33其它分店列表
-(void)OthershopListRequestRecord:(NSInteger)startnum:(NSInteger)endnum:(NSInteger)shopId:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",[NSString stringWithFormat:@"%i",shopId],@"shop_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"OthershopListRequestRecord",nil] urlStr:@"/othershop" delegate:delegate];
}
//34活动详情
-(void)EventDetailRequestRecord:(NSInteger)eventId:(NSInteger)shopId:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",eventId],@"event_id",[NSString stringWithFormat:@"%i",shopId],@"shop_id",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"EventDetailRequestRecord",nil] urlStr:@"/eventdetali" delegate:delegate];
}
//35商家全部活动列表
-(void)ShopEventListRequestRecord:(NSInteger)shopId:(NSInteger)startnum:(NSInteger)endnum:(id)delegate
{
    NSMutableDictionary * jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",shopId],@"shop_id",[NSString stringWithFormat:@"%i",startnum],@"startnum",[NSString stringWithFormat:@"%i",endnum],@"endnum",nil];
    [jsonDic addEntriesFromDictionary:baseDic];
    [self sendJSON:[NSDictionary dictionaryWithObjectsAndKeys:jsonDic,@"ShopEventListRequestRecord",nil] urlStr:@"/shopeventlist" delegate:delegate];
}
@end