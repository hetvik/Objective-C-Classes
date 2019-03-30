// Common.m


#import "Common.h"

@implementation Common

@synthesize isLogin;
@synthesize appRadius;
@synthesize strUserID;
@synthesize JourneyId;
@synthesize marrAllJournies;
@synthesize isActive;
+ (instancetype)shareInstance {
    
    static Common *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        //Filter Data
        self.appRadius=1;
        
        //User Model
        self.strUserID = @"";
        
        marrAllJournies = [NSMutableArray array];
    }
    return self;
}
@end
