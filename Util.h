//
//  Util.h
//
#import <UIKit/UIKit.h>
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

+ (void)textfieldPlashholderChange:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews withFontSize:(CGFloat)fSize;

+ (NSString *)formatDate:(NSString *)subjectDate source:(NSString *)sourceFormat result:(NSString *) resultFormat;

+ (CGSize)getLabelSize:(UILabel *)currentLabel;

+ (NSString *)calculateSHA:(NSString *)yourString;

+ (NSString *)getRemainingTime:(NSString *)dateCreated;

+ (NSArray *)stringToArray:(NSString *)response;

+ (NSDictionary *)stringToDict:(NSString *)response;

#pragma mark - User model

+ (void)resetDefaults;

+ (NSString *) applicationDocumentsDirectory;

@end


@interface NSArray (UtilArray)
-(BOOL)isValidIndex:(NSInteger)index;

@end
