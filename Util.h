//
//  Util.h
//

#import <Foundation/Foundation.h>

typedef void (^APIStringResponse)   (NSString *response, NSError *error);

@interface Util : NSObject

+ (instancetype)sharedInstance;

+ (NSString *)urlencode:(NSString *)simpleString;

+ (BOOL)isAlphaNumericOnly:(NSString *)input;

+ (BOOL)validateAlphabets: (NSString *)alpha;

+ (BOOL)isValidEmail:(NSString *)checkString;

+ (BOOL)isStringNull:(NSString *)srcString;

+ (void)hideKeyboard;

+ (void)textfieldPlashholderChange:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews FontSize:(CGFloat)size;

+ (NSString *)formatDate:(NSString *)subjectDate source:(NSString *)sourceFormat result:(NSString *) resultFormat;

+ (CGSize)getLabelSize:(UILabel *)currentLabel;

+ (NSMutableDictionary *)makeURLDictionary:(NSMutableDictionary *)dictionary;

+ (NSString *)calculateSHA:(NSString *)yourString;

+ (void)getThumbFromVideo:(NSString *)url withCompletionBlock:(void(^)(UIImage *imgThumb))block;

+ (MarqueeLabel *) setMarqueeProperty:(MarqueeLabel *)lable;

+ (NSString *)getRemainingTime:(NSString *)dateCreated;

+ (NSArray *)stringToArray:(NSString *)response;

+ (NSDictionary *)stringToDict:(NSString *)response;
+ (void)exportVideo:(NSURL *)url withCompltion:(void (^)(NSData *))block;


#pragma mark - User model

+ (void)resetDefaults;

+ (void)getVideoFromUrl:(NSURL *)url withCompltion:(void (^)(NSData *data))block;
+ (NSString *) applicationDocumentsDirectory;

@end


@interface NSArray (UtilArray)
-(BOOL)isValidIndex:(NSInteger)index;

@end
