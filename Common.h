// Common.h


#import <Foundation/Foundation.h>
#define kCommon [Common shareInstance]

@interface Common : NSObject
{
    
}
+ (instancetype)shareInstance;

//User Model
@property (strong, nonatomic) NSString *strUserID;
@property (assign, nonatomic) BOOL isLogin;
@property (nonatomic, readwrite) CGFloat appRadius;
@property (nonatomic, strong) NSString *JourneyId;
@property (nonatomic,nonatomic) BOOL isActive;
@property (nonatomic, strong) NSMutableArray *marrAllJournies;

@end
