//
//  AFService.h
//  AFNetworkManager
//
//  Created by Nilson Filho on 17/01/19.
//  Copyright © 2019 Nilson Filho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
	POST,
	GET,
	DELETE,
	PUT
} AFMethod ;

typedef void (^AFSuccessBlock)(NSURLSessionDataTask *operation, id response);
typedef void (^AFFailedBlock)(NSURLSessionDataTask *operation, NSError *error);

@interface AFService : NSObject

- (id)initWithBaseURL:(NSString *)baseURL;
+ (void)setAuthorizationHeader:(NSString *)authorizationHeader;
+ (void)setRequestSerializer:(NSString *)requestSerializer;


- (void)POST:(NSString*)urlString params:(NSDictionary*)params success:(AFSuccessBlock)success failed:(AFFailedBlock)failed;
- (void)GET:(NSString*)urlString params:(NSDictionary*)params success:(AFSuccessBlock)success failed:(AFFailedBlock)failed;
- (void)DELETE:(NSString*)urlString params:(NSDictionary*)params success:(AFSuccessBlock)success failed:(AFFailedBlock)failed;
- (void)PUT:(NSString*)urlString params:(NSDictionary*)params success:(AFSuccessBlock)success failed:(AFFailedBlock)failed ;

@end

NS_ASSUME_NONNULL_END
