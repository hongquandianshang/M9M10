//
//  MMClient.h
//  食全酒美
//
//  Created by hongquan on 1/5/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#ifdef DEBUG
#define BASE_URL @"http://183.129.245.49:3389"
#else
#define BASE_URL @"http://183.129.245.49:3389"
#endif

#define APP_URL @"/m9m10/ws/sqjm"
#define LOGIN_API @"/login"

@interface MMClient : NSObject

@property (nonatomic, strong)NSDictionary *userInfoDict;

+ (MMClient *)sharedClient;

+ (void)postParam:(NSDictionary *)param
            toAPI:(NSString *)api
        onSuccess:(void(^)(NSDictionary *result))success
        onFailure:(void(^)(NSError *error))failure;

//+ (NSString *)peer;
//
//+ (void)processRemoteNotification:(NSDictionary *)userInfo;
//
/////////////////////////////////////////////////
//+ (void)registerPeerWithToken:(NSData *)token withHandler:(void(^)())handler;
//
//+ (void)updateItem:(NSString *)item withString:(NSString *)value withHandler:(void (^)())handler;
//
//+ (void)submitPhoto:(NSData *)data withHandler:(void (^)(NSString *filename))handler;
//
//+ (void)deletePhoto:(NSString *)photo withHandler:(void(^)())handler;
//
//+ (void)submitBlog:(NSString *)blog inCollege:(NSString *)college withHandler:(void (^)())handler;
//
//+ (void)sendMessage:(NSString *)message toPeer:(NSString *)peer withHandler:(void (^)())handler;
//
//+ (void)getPeerWithPeer:(NSString *)peer withHandler:(void (^)(NSMutableArray *items, NSMutableArray *photos))handler;
//
//+ (void)queryBlogsInCollege:(NSString *)college withHandler:(void (^)(NSArray *blogs))handler;
//
//+ (void)queryPeersWithPeer:(NSString *)peer withHandler:(void (^)(NSArray *peers))handler;
//
//+ (void)queryMessagesWithPeerA:(NSString *)pa
//                      andTimeA:(NSNumber *)ta
//                      andPeerB:(NSString *)pb
//                      andTimeB:(NSNumber *)tb
//                   withHandler:(void (^)(NSMutableArray *messages))handler;
//
//+ (void)withdrawFromCollege:(NSString *)peer withHandler:(void (^)())handler;
//
//+ (void)updateRelation:(NSNumber *)relation withPeer:(NSString *)peer withHandler:(void (^)())handler;
//
//+ (void)listFilesWithPrefix:(NSString *)prefix withHandler:(void (^)(NSArray *folders, NSArray *files))handler;
//
//+ (void)getFileWithKey:(NSString *)key withHandler:(void (^)(NSDictionary *info))handler;
//
//+ (NSURL *)urlWithPhoto:(NSString *)filename;
//
//+ (UIImage *)imageWithPeer:(NSString *)peer orSex:(NSString *)sex;
//
//- (void)networkUp;
//
//- (void)networkDown;

@end