
//
//  AFService.m
//  AFNetworkManager
//
//  Created by Nilson Filho on 17/01/19.
//  Copyright © 2019 Nilson Filho. All rights reserved.
//

#import "AFService.h"

NSString *_authorizationHeader = @"";
NSString *_baseURL = @"";
NSString *_requestSerializer = @"application/json";

@implementation AFService


#pragma mark - Initializers

- (id)initWithBaseURL:(NSString *)baseURL {
	self = [super init];
	
	if (self != nil) {
		_baseURL = baseURL;
	}
	
	return self;
}

+ (void)setAuthorizationHeader:(NSString *)authorizationHeader {
	_authorizationHeader = authorizationHeader;
}

// optional as the default is Json
+ (void)setRequestSerializer:(NSString *)requestSerializer {
	_requestSerializer = requestSerializer;
}


#pragma mark - API Call methods

- (void)POST:(NSString *)urlString params:(NSDictionary *)params success:(AFSuccessBlock)success failed:(AFFailedBlock)failed {
	[self apiRequest:urlString method:POST params:params success:success failed:failed];
}

- (void)GET:(NSString *)urlString params:(NSDictionary *)params success:(AFSuccessBlock)success failed:(AFFailedBlock)failed {
	[self apiRequest:urlString method:GET params:params success:success failed:failed];
}

- (void)DELETE:(NSString *)urlString params:(NSDictionary *)params success:(AFSuccessBlock)success failed:(AFFailedBlock)failed {
	[self apiRequest:urlString method:DELETE params:params success:success failed:failed];
}

- (void)PUT:(NSString *)urlString params:(NSDictionary *)params success:(AFSuccessBlock)success failed:(AFFailedBlock)failed {
	[self apiRequest:urlString method:PUT params:params success:success failed:failed];
}


#pragma mark - API Call Handler

- (void)apiRequest:(NSString*)urlString method:(AFMethod)method params:(NSDictionary*)paramsDic success:(AFSuccessBlock)success failed:(AFFailedBlock)failed {
	NSString *url = [_baseURL stringByAppendingString:urlString];
	NSLog(@"Url: %@", url);
	
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:paramsDic];
	
	void (^successInterceptor)(NSURLSessionDataTask *operation, id responseObject) = ^(NSURLSessionDataTask *operation, id responseObject) {
		NSLog(@"JSON: %@", responseObject);
		success(operation, responseObject);
	};
	
	void (^failedInterceptor)(NSURLSessionDataTask *operation, NSError *error) = ^(NSURLSessionDataTask *operation, NSError *error) {
		NSLog(@"Error: %@", error);
		failed(operation, error);
	};
	
	NSLog(@"Params: %@", params);
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	[manager.requestSerializer setValue:_requestSerializer forHTTPHeaderField:@"Content-Type"];
	
	// set authorization header when needed
	if (_authorizationHeader.length > 0) {
		NSString *authorization = [NSString stringWithFormat:@"Bearer %@", _authorizationHeader];
		[manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
	}
	
	if (method == GET) {
		[manager GET:url parameters:params progress:nil success:successInterceptor failure:failedInterceptor];
		
	} else if(method == POST){ // POST
		[manager POST:url parameters:params progress:nil success:successInterceptor failure:failedInterceptor];
		
	} else if(method == PUT) {
		[manager PUT:url parameters:params success:successInterceptor failure:failedInterceptor];
		
	} else if(method == DELETE) {
		[manager DELETE:url parameters:params success:successInterceptor failure:failedInterceptor];
	}
}

@end
