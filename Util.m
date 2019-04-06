//
//  Util.h
//


#import "Util.h"
#import "AppDelegate.h"
#include <CommonCrypto/CommonDigest.h>

@implementation Util

+ (instancetype)sharedInstance
{
    static Util *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (BOOL)isEnglishLanguage{
    
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language containsString:@"en"]){
        return YES;
    }
    return NO;
}

+ (NSString *)urlencode:(NSString *)simpleString
{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[simpleString UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9'))
        {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}
+ (BOOL)isAlphaNumericOnly:(NSString *)input
{
    NSRange rang;
    rang = [input rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length ) return NO;  // no letter
    rang = [input rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ( !rang.length )  return NO;  // no number;
    return YES;
}
+ (BOOL) validateAlphabets: (NSString *)alpha
{
    NSString *abnRegex = @"[A-Za-z]+";
    NSPredicate *abnTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", abnRegex];
    BOOL isValid = [abnTest evaluateWithObject:alpha];
    return isValid;
}

+ (BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (BOOL) isStringNull:(NSString *)srcString
{
    if (srcString != nil && srcString != (id)[NSNull null] && ![srcString isKindOfClass:[NSNull class]] && ![srcString isEqualToString:@"<null>"] && ![srcString isEqualToString:@"(null)"] && srcString.length > 0)
    return NO;
    
    return YES;
}

+ (NSMutableArray *)filterNullObjects:(NSArray *)array {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF != %@", [NSNull null]];
    NSArray *fileterd = [array filteredArrayUsingPredicate:predicate];
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:fileterd];
    return mArray;
}

+ (NSMutableDictionary *)filterNullObjectsInDict:(NSDictionary *)dict {
    NSMutableDictionary *dictNew = [dict mutableCopy];
    for (NSString *key in dictNew) {
        id object = [dictNew objectForKey:key];
        if ([Util isStringNull:[NSString stringWithFormat:@"%@",object]]) {
            [dictNew removeObjectForKey:key];
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            [dictNew setObject: [self filterNullObjectsInDict:object] forKey: key];
        }
    }
    return  dictNew;
}


+ (NSString *)dictToString:(NSDictionary *)response {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:response options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return myString;
}

+ (NSString *)arrayToString:(NSMutableArray *)response {
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:response options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return myString;
}

+ (NSString *)generateImageName{
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"ddMMMYYYYHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    return dateString;
}

+ (UIImage *)captureView:(UIView *)view {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [view.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSString *)getTodaysDayName {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayName = [dateFormatter stringFromDate:now];
    return dayName;
}

+(NSString *)getShortTodaysDayName {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    
    NSString *dayName = [dateFormatter stringFromDate:now];
    return dayName;
}

+ (BOOL)isPushNotificationEnabled{
    //BOOL isEnabled = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]) {
        
        UIUserNotificationType isEnabled = [[[UIApplication sharedApplication] currentUserNotificationSettings] types];
        
        if (isEnabled == UIUserNotificationTypeNone)
        {
            return isEnabled;
        }
        return isEnabled;
    }
    else
        
    {
        
        UIRemoteNotificationType isEnabled = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        
        if (isEnabled == UIRemoteNotificationTypeNone) {
            return isEnabled;
        }
        return isEnabled;
    }
    
}

+ (NSDictionary *)stringToDict:(NSString *)response {
    
    if ([Util isStringNull:response]) {
        response = @"";
    }
    
    NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return dictionary;
}

+ (void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

+ (CGSize )getSizeOfText:(NSString *)text withMaxWidth:(CGFloat)maxWidth withFont:(UIFont *)font{
    
    CGRect stringRect = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                           options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                        attributes:@{ NSFontAttributeName : font }
                                           context:nil];
    
    CGSize stringSize = CGRectIntegral(stringRect).size;
    return stringSize;
}

+ (BOOL) isUserContactNumberHaveValidLength: (NSString *) userContactNo{
    
    if ([userContactNo length] >= 10 && [userContactNo length] <= 20){
        return YES;
    }
    return NO;
}

+ (NSString *)convet12HourFormat:(NSString *)value {
    NSString *result = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    NSDate *date   = [formatter dateFromString:value];
    formatter.dateFormat = @"hh:mm a";
    result = [formatter stringFromDate:date];
    
    return result;
}

+ (NSString *)convet24HourFormat:(NSString *)value {
    
    NSString *result = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSDate *date = [formatter dateFromString:value];
    formatter.dateFormat = @"HH:mm";
    result = [formatter stringFromDate:date];
    
    return result;
}

+ (void)textfieldPlashholderChange:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews withFontSize:(CGFloat)fSize {
    if ([view isKindOfClass:[UITextField class]])
    {
        UITextField *txt = (UITextField *)view;
        UIColor *color = txt.textColor;
        txt.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:txt.placeholder
                                        attributes:@{
                                                     NSForegroundColorAttributeName: color,
                                                     NSFontAttributeName : [UIFont fontWithName:fontFamily size:fSize]
                                                     }
         ];
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [Util textfieldPlashholderChange:fontFamily forView:sview andSubViews:YES withFontSize:fSize];
        }
    }
}

+ (UIImage *)getThumbFromVideo:(NSString *)url
{
    /*AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:url] options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef;
    @try {
        imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
        return nil;
    }*/
    UIImage *imgThumb;//=[[UIImage alloc] initWithCGImage:imgRef];
    return imgThumb;
}
+ (CGSize)getLabelSize:(UILabel *)currentLabel {
    CGSize finalSize;
    if (currentLabel.text.length==0) {
        finalSize=CGSizeMake(0, 0);
        return finalSize;
    }
    NSAttributedString *attributedText =
    [[NSAttributedString alloc] initWithString:currentLabel.text
                                    attributes:@{NSFontAttributeName: currentLabel.font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){currentLabel.bounds.size.width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    finalSize = rect.size;
    return finalSize;
}

+(NSString *)formatDate:(NSString *)subjectDate source:(NSString *)sourceFormat result:(NSString *) resultFormat {
    
    NSString *strDateTime = @"";
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [f setDateFormat:sourceFormat];
    NSDate *startDate = [f dateFromString:subjectDate];
    [f setTimeZone:[NSTimeZone timeZoneWithName:@"PDT"]];
    [f setDateFormat:resultFormat];
    strDateTime = [f stringFromDate:startDate];
    
    return strDateTime;
}

+ (NSString *)calculateSHA:(NSString *)yourString
{
    const char *cstr = [yourString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:yourString.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes,(CC_LONG) data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSArray *)stringToArray:(NSString *)response {
    
    NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return array;
}

#pragma mark - USER MODEL

+ (void)resetDefaults {
    
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        
       [defs removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation([UIImage imageNamed:@"no_avatar"])forKey:@"user_pic"];
    [defs synchronize];
}

+ (NSString *)getRemainingTime:(NSString *)dateCreated{
    
    NSDateFormatter *apDateFormate = [[NSDateFormatter alloc] init];
    [apDateFormate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *finalRemaingTime=@"";
    NSDate *startDate = [apDateFormate dateFromString:dateCreated];
    NSDate *endDate = [NSDate date];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:startDate toDate:endDate options:0];
    
    if (components.year != 0){
        
        if (components.year > 1)
            finalRemaingTime = [NSString stringWithFormat:@"%ld years ago",(long)components.year];
        else
            finalRemaingTime = [NSString stringWithFormat:@"%ld year ago",(long)components.year];
        
    }else if (components.month != 0){
        
        if (components.month > 1)
            finalRemaingTime = [NSString stringWithFormat:@"%ld months ago",(long)components.month];
        else
            finalRemaingTime = [NSString stringWithFormat:@"%ld month ago",(long)components.month];
        
    }else if (components.weekOfYear != 0){
        
        if (components.weekOfYear > 1)
            finalRemaingTime = [NSString stringWithFormat:@"%ld weeks ago",(long)components.weekOfYear];
        else
            finalRemaingTime = [NSString stringWithFormat:@"%ld week ago",(long)components.weekOfYear];
        
    }else if (components.day != 0){
        
        if (components.day > 1)
            finalRemaingTime = [NSString stringWithFormat:@"%ld days ago",(long)components.day];
        else
            finalRemaingTime = [NSString stringWithFormat:@"%ld day ago",(long)components.day];
        
    }else if (components.hour != 0){
        
        if (components.hour > 1)
            finalRemaingTime = [NSString stringWithFormat:@"%ld hours ago",(long)components.hour];
        else
            finalRemaingTime = [NSString stringWithFormat:@"%ld hour ago",(long)components.hour];
        
    }else if (components.minute != 0){
        
        if (components.minute > 1)
            finalRemaingTime = [NSString stringWithFormat:@"%ld mins ago",(long)components.minute];
        else
            finalRemaingTime = [NSString stringWithFormat:@"%ld min ago",(long)components.minute];
        
    }else if (components.second > 0){
        
        if (components.second > 1)
            finalRemaingTime = [NSString stringWithFormat:@"%ld secs ago",(long)components.second];
        else
            finalRemaingTime = [NSString stringWithFormat:@"%ld sec ago",(long)components.second];
        
    }else{
        finalRemaingTime = @"just now";
    }
    return finalRemaingTime;
}
+ (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = paths.firstObject;
    return basePath;
}
@end

@implementation NSArray (UtilArray)

-(BOOL)isValidIndex:(NSInteger)index{
    if (index<[self count]) {
        return YES;
    }
    return NO;
}
@end
