// AFAppDotNetAPIClient.h
//
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

#import "AFAppDotNetAPIClient.h"

NSString * const base_server = Base_Url;

@implementation AFAppDotNetAPIClient
@synthesize internetConn;

+ (instancetype)sharedClient
{
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:base_server]];
        
    });
    return _sharedClient;
}

- (void)getRequest:(NSString *)url withParam:(NSDictionary *)params withStringResponse:(APIStringResponse)block {
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *data=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        block(data,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil,error);
    }];
}

- (void)getRequest:(NSString *)url withParam:(NSDictionary *)params withJsonResponse:(APIJSONResponse)block {
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    [self GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil,error);
    }];
}

- (void)postRequest:(NSString *)url withParam:(NSDictionary *)params withStringResponse:(APIStringResponse)block {
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [AFAppDotNetAPIClient sharedClient].responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSString *data=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        block(data,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil,error);
    }];
}

- (void)postRequest:(NSString *)url withParam:(NSDictionary *)params withJsonResponse:(APIJSONResponse)block
{
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    [self POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil,error);
    }];
}
- (void)deleteRequest:(NSString *)url withParam:(NSString *)params withJsongResponse:(APIJSONResponse)block {
    
    NSData *postData = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength =[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *Url=[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@%@",self.baseURL,url]];
    [request setURL:Url];
    [request setHTTPMethod:@"DELETE"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer=[AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        block(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.responseObject) {
            block(operation.responseObject,nil);
        } else {
            block(nil,error);
        }
    }];
    [operation start];
}
- (void)deleteRequest:(NSString *)url withParam:(NSString *)params withStringResponse:(APIStringResponse)block {
    
    NSData *postData = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength =[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *Url=[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@%@",self.baseURL,url]];
    [request setURL:Url];
    [request setHTTPMethod:@"DELETE"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *data=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        block(data,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.responseObject) {
            NSString *data=[[NSString alloc]initWithData:operation.responseObject encoding:NSUTF8StringEncoding];
            block(data,nil);
        } else {
            block(nil,error);
        }
    }];
    [operation start];
}

- (void)putRequest:(NSString *)url withParam:(NSDictionary *)params withStringResponse:(APIStringResponse)block {
    
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self PUT:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
    {
        [AFAppDotNetAPIClient sharedClient].responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSString *data=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        block(data,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil,error);
    }];
}
- (void)getAgentPostData:(NSString *)url withParam:(NSDictionary *)params withJsonResponse:(APIJSONResponse)block {
    
    NSURLRequest *requsest = [NSURLRequest requestWithURL:[NSURL URLWithString:url relativeToURL:self.baseURL]];
    
    AFHTTPRequestOperation *oper = [[AFHTTPRequestOperation alloc] initWithRequest:requsest];
    oper.responseSerializer = [AFJSONResponseSerializer serializer];
    [oper setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        block(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.responseObject) {
            block(operation.responseObject,nil);
        } else {
            block(nil,error);
        }
    }];
    [oper start];
}

#pragma mark - Check For Internet Connection
-(BOOL)checkForInternetConnection
{
   Reachability *reach = [Reachability reachabilityForInternetConnection] ;
    
    NetworkStatus status = [reach currentReachabilityStatus];
    
    [self stringFromStatus:status];
    
    if (internetConn)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    return NO;
}
#pragma Mark Check Network Status
-(void)stringFromStatus:(NetworkStatus)status
{
    switch(status)
    {
        case NotReachable:
            internetConn=NO;
            break;
        case ReachableViaWiFi:
            internetConn=YES;
            break;
        case ReachableViaWWAN:
            internetConn=YES;
            break;
        default:
            internetConn=YES;
            break;
    }
}
- (void)postRequestWithProgress:(NSString *)url withParam:(NSDictionary *)params withMultiPartData:( void (^)(id <AFMultipartFormData> formData))formDataBlock withJsonResponse:(APIJSONResponse)block withProgess:(APIProgressResponse)progressBlock {
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST" URLString:[self.baseURL.absoluteString stringByAppendingString:url]
                                    parameters:params
                     constructingBodyWithBlock:formDataBlock error:nil];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        block(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.responseObject) {
            block(operation.responseObject,nil);
        } else {
            block(nil,error);
        }
    }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        NSLog(@"Wrote %lld/%lld result = %f", totalBytesWritten, totalBytesExpectedToWrite, (float)(totalBytesWritten/totalBytesExpectedToWrite));
        progressBlock((float)totalBytesWritten/totalBytesExpectedToWrite);
    }];
    
    // 5. Begin!
    [operation start];
}


@end
