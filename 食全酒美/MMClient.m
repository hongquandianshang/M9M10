//
//  MMClient.m
//  食全酒美
//
//  Created by hongquan on 1/5/13.
//
//

#import "MMClient.h"

@interface MMClient ()


@end

@implementation MMClient


+ (MMClient *)sharedClient
{
    static MMClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MMClient alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

+ (NSMutableURLRequest *)postRequestWithParam:(NSDictionary *)param
                                        toAPI:(NSString *)api
{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",BASE_URL,APP_URL,api]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    if (!request) {
        NSLog(@"Error creating the URL Request");
    }
    NSData *postData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
    NSString *postLength = [NSString stringWithFormat:@"%d",postData.length];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:10.0];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    return request;
}

+ (void)postParam:(NSDictionary *)param
            toAPI:(NSString *)api
        onSuccess:(void(^)(NSDictionary *result))success
        onFailure:(void(^)(NSError *error))failure
{
    NSMutableURLRequest *request = [MMClient postRequestWithParam:param toAPI:api];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSDictionary *result = [MMClient processResponse:response withData:data withError:error];
        if (result) {
            success(result);
        }else{
            failure(error);
        }
    }];
}

+ (id)processResponse:(NSURLResponse *)response
             withData:(NSData *)data
            withError:(NSError *)error
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (error) {
        NSLog(@"%@",error);
        return nil;
    }
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    if (error) {
        error = [NSError errorWithDomain:@"MM_JSON_DECODE_ERROR"
                                    code:httpResponse.statusCode
                                userInfo:nil];
        NSLog(@"%@",error);
        NSLog(@"%s",data.bytes);
        return nil;
    }
    if (httpResponse.statusCode == 200) {
        return object;
    }
    return nil;
}

//- (void)networkUp
//{
//    network++;
//    if (network) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    }
//}
//
//- (void)networkDown
//{
//    network--;
//    if (!network) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    }
//}


//+ (void)processRemoteNotification:(NSDictionary *)userInfo
//{
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    NSLog(@"notification %@",userInfo);
//    if ([userInfo objectForKey:@"authToken"]) {
//        [RankClient sharedClient].authToken = [userInfo objectForKey:@"authToken"];
//        [RankClient playSound:@"Glass"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:RANK_NOTIFICATION
//                                                            object:nil
//                                                          userInfo:@{@"key":@"authToken",@"value":[userInfo objectForKey:@"authToken"]}];
//    }
//    if ([userInfo objectForKey:@"message"]) {
//        [RankClient playSound:@"Submarine"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:RANK_NOTIFICATION
//                                                            object:nil
//                                                          userInfo:@{@"key":@"message",@"value":[userInfo objectForKey:@"message"]}];
//    }
//    if ([userInfo objectForKey:@"receipt"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:RANK_NOTIFICATION
//                                                            object:nil
//                                                          userInfo:@{@"key":@"receipt",@"value":[userInfo objectForKey:@"receipt"]}];
//    }
//    if ([userInfo objectForKey:@"url"]) {
//        [RankClient playSound:@"Submarine"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:RANK_NOTIFICATION
//                                                            object:nil
//                                                          userInfo:@{@"key":@"url",@"value":[userInfo objectForKey:@"url"]}];
//    }
//    if ([userInfo objectForKey:@"refresh"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:RANK_NOTIFICATION
//                                                            object:nil
//                                                          userInfo:@{@"key":@"refresh",@"value":[userInfo objectForKey:@"refresh"]}];
//    }
//    if ([userInfo objectForKey:@"peer"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:RANK_NOTIFICATION
//                                                            object:nil
//                                                          userInfo:@{@"key":@"peer",@"value":[userInfo objectForKey:@"peer"]}];
//    }
//}
//
//
//+ (NSString *)peer
//{
//    NSString* tokenString = [[RankClient sharedClient].deviceToken description];
//    tokenString = [tokenString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    tokenString = [tokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
//    return tokenString;
//}
//
//+ (NSURL *)URLwithPHP:(NSString *)php andDictionary:(NSDictionary *)dict
//{
//    NSMutableDictionary *GET = [NSMutableDictionary dictionaryWithDictionary:dict];
//    if (![RankClient peer]) {
//        BlockAlertView *alertView = [[BlockAlertView alloc]initWithTitle:NSLocalizedString(@"SIGNIN", nil)
//                                                                 message:nil];
//        [alertView setCancelButtonWithTitle:NSLocalizedString(@"OK",nil) block:^{}];
//        [alertView show];
//        return nil;
//    }
//    [GET setObject:[RankClient peer] forKey:@"deviceToken"];
//    [GET setObject:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] forKey:@"timestamp"];
//    if (dict) {
//        NSMutableString *raw = [NSMutableString string];
//        for (NSString *key in [GET.allKeys sortedArrayUsingSelector:@selector(compare:)]) {
//            [raw appendFormat:@"%@%@",key,[GET objectForKey:key]];
//        }
//        NSData *data = hmacForKeyAndData([RankClient sharedClient].authToken, [raw base64EncodedString]);
//        NSString *signiture = [[data description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//        signiture = [signiture stringByReplacingOccurrencesOfString:@" " withString:@""];
//        [GET setObject:signiture forKey:@"signiture"];
//    }
//    NSMutableString *string = [NSMutableString stringWithFormat:@"%@%@%@?",BASE_URL,APP_URL,php];
//    for (NSString *key in GET) {
//        NSString *sourceString = [GET objectForKey:key];
//        NSString *urlEncoded = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)sourceString,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",kCFStringEncodingUTF8);
//        [string appendFormat:@"%@=%@&",key,urlEncoded];
//    }
//    NSLog(@"%@",string);
//    //    [RankClient playSound:@"Pop"];
//    return [NSURL URLWithString:string];
//}
//
//+ (id)processResponse:(NSURLResponse *)response withData:(NSData *)data withError:(NSError *)error
//{
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    if (error) {
//        NSLog(@"%@",error);
//        return nil;
//    }
//    id object = [NSJSONSerialization JSONObjectWithData:data
//                                                options:NSJSONReadingMutableContainers
//                                                  error:&error];
//    if (error) {
//        error = [NSError errorWithDomain:@"RANK_JSON_DECODE_ERROR" code:httpResponse.statusCode userInfo:nil];
//        NSLog(@"%@",error);
//        NSLog(@"%s",data.bytes);
//        return nil;
//    }
//    if (httpResponse.statusCode == 500){
//        error = [NSError errorWithDomain:@"RANK_STATUS_CODE_ERROR" code:httpResponse.statusCode userInfo:nil];
//        NSLog(@"500 %@",object);
//        //[RankClient playSound:@"Sosumi"];
//        return nil;
//    }
//    if (httpResponse.statusCode == 400){
//        error = [NSError errorWithDomain:@"RANK_STATUS_CODE_ERROR" code:httpResponse.statusCode userInfo:nil];
//        NSLog(@"400 %@",object);
//        [RankClient playSound:@"Sosumi"];
//        return nil;
//    }
//    if (httpResponse.statusCode == 300) {
//        BlockAlertView *alertView = [[BlockAlertView alloc]initWithTitle:NSLocalizedString(@"SIGNIN", nil)
//                                                                 message:nil];
//        [alertView setCancelButtonWithTitle:NSLocalizedString(@"OK",nil) block:^{}];
//        [alertView show];
//        return nil;
//    }
//    if (httpResponse.statusCode == 200) {
//        [RankClient playSound:@"Tink"];
//        return object;
//    }
//    return nil;
//}
//
//+ (void)registerPeerWithToken:(NSData *)token withHandler:(void(^)())handler
//{
//    NSLog(@"register %@",token);
//    [RankClient sharedClient].deviceToken = token;
//    NSURL *URL = [RankClient URLwithPHP:REGISTER_PHP andDictionary:nil];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"register ok %@",result);
//            handler();
//        }
//    }];
//}
//
//+ (void)updateItem:(NSString *)item withString:(NSString *)value withHandler:(void (^)())handler
//{
//    NSURL *URL = [self URLwithPHP:UPDATE_PEER_PHP andDictionary:@{@"item":item,@"value":value}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"update item ok %@",result);
//            handler();
//        }
//    }];
//}
//
//
//+ (void)submitPhoto:(NSData *)data withHandler:(void (^)(NSString *filename))handler
//{
//    NSString *md5 = [RankClient md5WithData:data];
//    NSNumber *size = [NSNumber numberWithInteger:data.length];
//    NSURL *URL = [self URLwithPHP:UPLOAD_PHOTO_PHP
//                    andDictionary:@{@"size":size.stringValue,@"md5":md5}];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = data;
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"submit photo ok %@",result);
//            handler([result objectForKey:@"filename"]);
//        }
//    }];
//}
//
//+ (void)submitBlog:(NSString *)blog inCollege:(NSString *)college withHandler:(void (^)())handler
//{
//    CLLocation *location = [RankClient sharedClient].locationManager.location;
//    NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
//    NSLog(@"location %@",location);
//    NSURL *URL = [self URLwithPHP:UPDATE_BLOG_PHP
//                    andDictionary:@{
//                  @"college":college,
//                  @"blog":blog,
//                  @"latitude":latitude,
//                  @"longitude":longitude}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"submit blog ok %@",result);
//            handler();
//        }
//    }];
//}
//
//+ (void)deletePhoto:(NSString *)photo withHandler:(void(^)())handler
//{
//    NSURL *URL = [self URLwithPHP:DELETE_PHOTO_PHP
//                    andDictionary:@{@"photo":photo}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"delete photo ok %@",result);
//            handler();
//        }
//    }];
//}
//
//+ (void)sendMessage:(NSString *)message toPeer:(NSString *)peer withHandler:(void (^)())handler
//{
//    NSURL *URL = [self URLwithPHP:SEND_MESSAGE_PHP
//                    andDictionary:@{@"message":message,@"peer":peer}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [self processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"send message ok %@",result);
//            handler();
//        }
//    }];
//}
//
//+ (void)getPeerWithPeer:(NSString *)peer withHandler:(void (^)(NSMutableArray *, NSMutableArray *))handler
//{
//    NSURL *URL = [self URLwithPHP:GET_PEER_PHP andDictionary:@{@"peer":peer}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"get peer ok %@",result);
//            NSMutableArray *items = [[result objectForKey:@"Items"] mutableCopy];
//            NSMutableArray *photos = [[result objectForKey:@"Photos"] mutableCopy];
//            handler(items,photos);
//        }
//    }];
//    
//}
//
//+ (void)queryBlogsInCollege:(NSString *)college withHandler:(void (^)(NSArray *blogs))handler
//{
//    NSURL *URL = [self URLwithPHP:QUERY_BLOGS_PHP andDictionary:@{@"college":college}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"%@",result);
//            NSMutableArray *blogs = [[result objectForKey:@"Blogs"] mutableCopy];
//            handler(blogs);
//        }
//    }];
//}
//
//+ (void)queryPeersWithPeer:(NSString *)peer withHandler:(void (^)(NSArray *peers))handler
//{
//    NSURL *URL = [self URLwithPHP:QUERY_PEERS_PHP andDictionary:@{@"peer":peer}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"query peers ok %@",result);
//            NSArray *peers = [result objectForKey:@"Peers"];
//            handler(peers);
//        }
//    }];
//}
//
//+ (void)queryMessagesWithPeerA:(NSString *)pa andTimeA:(NSNumber *)ta andPeerB:(NSString *)pb andTimeB:(NSNumber *)tb withHandler:(void (^)(NSMutableArray *messages))handler;
//{
//    NSURL *URL = [self URLwithPHP:QUERY_MESSAGES_PHP andDictionary:@{
//                  @"pa":pa,
//                  @"ta":ta.stringValue,
//                  @"pb":pb,
//                  @"tb":tb.stringValue,
//                  }];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"query messages ok %@",result);
//            NSMutableArray *messages = [[result objectForKey:@"Messages"] mutableCopy];
//            handler(messages);
//        }
//    }];
//}
//
//+ (void)withdrawFromCollege:(NSString *)peer withHandler:(void (^)())handler
//{
//    
//}
//
//+ (void)updateRelation:(NSNumber *)relation withPeer:(NSString *)peer withHandler:(void (^)())handler
//{
//    NSURL *URL = [self URLwithPHP:UPDATE_RELATION_PHP andDictionary:@{@"peer":peer,@"relation":relation.stringValue}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"update relation ok %@",result);
//            handler();
//        }
//    }];
//}
//
//
//+ (void)listFilesWithPrefix:(NSString *)prefix withHandler:(void (^)(NSArray *folders, NSArray *files))handler
//{
//    NSURL *URL = [self URLwithPHP:LIST_FILES_PHP andDictionary:@{@"prefix":prefix}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"list files ok %@",result);
//            NSArray *files = [result objectForKey:@"Files"];
//            NSArray *folders = [result objectForKey:@"Folders"];
//            handler(folders,files);
//        }
//    }];
//}
//
//+ (void)getFileWithKey:(NSString *)key withHandler:(void (^)(NSDictionary *info))handler
//{
//    NSURL *URL = [self URLwithPHP:GET_FILE_PHP andDictionary:@{@"key":key}];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[RankClient sharedClient] networkUp];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        [[RankClient sharedClient] networkDown];
//        NSDictionary *result = [RankClient processResponse:response withData:data withError:error];
//        if (result) {
//            NSLog(@"get file ok %@",result);
//            NSDictionary *info = [result objectForKey:@"info"];
//            handler(info);
//        }
//    }];
//}
//
//
//+ (NSURL *)urlWithPhoto:(NSString *)filename
//{
//    NSURL *URL = [NSURL URLWithString:PHOTO_URL];
//    URL = [NSURL URLWithString:filename relativeToURL:URL];
//    return URL;
//}
//
//NSData *hmacForKeyAndData(NSString *key, NSString *data)
//{
//    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
//    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
//    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
//    return [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
//}
//
//+ (NSString*)md5WithData:(NSData *)data
//{
// 	// Create byte array of unsigned chars
//    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
//    
//	// Create 16 byte MD5 hash value, store in buffer
//    CC_MD5(data.bytes, data.length, md5Buffer);
//    
//	// Convert unsigned char buffer to NSString of hex values
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//		[output appendFormat:@"%02x",md5Buffer[i]];
//    
//    return output;
//}
//
//+ (UIImage *)imageWithPeer:(NSString *)peer orSex:(NSString *)sex
//{
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    NSURL *fileURL = [[app applicationDocumentsDirectory] URLByAppendingPathComponent:peer];
//    NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
//    
//    if (imageData) {
//        return [UIImage imageWithData:imageData];
//    }else{
//        NSString *S = sex;
//        if ([S isEqualToString:NSLocalizedString(@"MALE", nil)]) {
//            return [UIImage imageNamed:@"Sex-Male-icon.png"];
//        }
//        if ([S isEqualToString:NSLocalizedString(@"FEMALE", nil)]) {
//            return [UIImage imageNamed:@"Sex-Female-icon.png"];
//        }
//    }
//    return [UIImage imageNamed:@"Sex-Male-Female-icon.png"];
//}



@end