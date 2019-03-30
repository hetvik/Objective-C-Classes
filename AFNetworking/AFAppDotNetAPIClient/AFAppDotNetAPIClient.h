// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

extern NSString * const base_server;

typedef void (^APIStringResponse)   (NSString *response, NSError *error);
typedef void (^APIJSONResponse)     (NSDictionary *response, NSError *error);
typedef void (^APIProgressResponse)     (float progress);

@interface AFAppDotNetAPIClient : AFHTTPSessionManager {
    BOOL internetConn;
}
@property (nonatomic, assign)BOOL internetConn;
+ (instancetype)sharedClient;

- (void)getRequest:(NSString *)url withParam:(NSDictionary *)params withStringResponse:(APIStringResponse)block;
- (void)getRequest:(NSString *)url withParam:(NSDictionary *)params withJsonResponse:(APIJSONResponse)block;
- (void)postRequest:(NSString *)url withParam:(NSDictionary *)params withStringResponse:(APIStringResponse)block;
- (void)postRequest:(NSString *)url withParam:(NSDictionary *)params withJsonResponse:(APIJSONResponse)block;
- (void)deleteRequest:(NSString *)url withParam:(NSString *)params withStringResponse:(APIStringResponse)block;
- (void)putRequest:(NSString *)url withParam:(NSDictionary *)params withStringResponse:(APIStringResponse)block;
- (void)getAgentPostData:(NSString *)url withParam:(NSDictionary *)params withJsonResponse:(APIJSONResponse)block;
-(BOOL)checkForInternetConnection;
- (void)postRequestWithProgress:(NSString *)url withParam:(NSDictionary *)params withMultiPartData:( void (^)(id <AFMultipartFormData> formData))formDataBlock withJsonResponse:(APIJSONResponse)block withProgess:(APIProgressResponse)progressBlock;

- (void)deleteRequest:(NSString *)url withParam:(NSString *)params withJsongResponse:(APIJSONResponse)block;

@end
