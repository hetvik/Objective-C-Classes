//
//  Util.h
//


#import "Util.h"
#import "AppDelegate.h"
#include <CommonCrypto/CommonDigest.h>
#import <Photos/Photos.h>

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
+ (BOOL) validateEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
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
+ (void)hideKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
+ (void)textfieldPlashholderChange:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews FontSize:(CGFloat)size
{
    if ([view isKindOfClass:[UITextField class]])
    {
        UITextField *txt = (UITextField *)view;
        UIColor *color = txt.textColor;
        txt.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:txt.placeholder
                                        attributes:@{
                                                     NSForegroundColorAttributeName: color,
                                                     NSFontAttributeName : [UIFont fontWithName:fontFamily size:size]
                                                     }
         ];
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self textfieldPlashholderChange:fontFamily forView:sview andSubViews:YES FontSize:size];
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
+ (CGSize)getLabelSize:(UILabel *)currentLabel
{
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

+(NSMutableDictionary *)makeURLDictionary:(NSMutableDictionary *)dictionary
{
    NSString *loggedinuser_token = kCommon.strUserID;
    [dictionary setObject:@"" forKey:@"user_id"];
    if(loggedinuser_token != nil && loggedinuser_token.length > 0)
    {
        [dictionary setObject:loggedinuser_token forKey:@"user_id"];
    }
    return dictionary;
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

+ (NSDictionary *)stringToDict:(NSString *)response {
    
    NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return dictionary;
}

#pragma mark - USER MODEL

+ (void)resetDefaults {
    
    kCommon.strUserID=@"";
    kCommon.isLogin=NO;
    
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        
       [defs removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation([UIImage imageNamed:@"no_avatar"])forKey:@"user_pic"];
    [defs synchronize];
}

+ (void)getThumbFromVideo:(NSString *)url withCompletionBlock:(void(^)(UIImage *imgThumb))block {
    
    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:[NSURL URLWithString:url] options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform=TRUE;
    CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
    
    AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
        if (result != AVAssetImageGeneratorSucceeded) {
            NSLog(@"couldn't generate thumbnail, error:%@", error);
        }
        UIImage *thumb = [UIImage imageWithCGImage:im];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(thumb);
        });
    };
    
    /*CGSize maxSize = CGSizeMake(320, 180);
     generator.maximumSize = maxSize;*/
    [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
}

+ (void)getVideoFromUrl:(NSURL *)url withCompltion:(void (^)(NSData *))block {

    if ([url isFileURL]) {
        [self exportVideo:url withCompltion:block];
    } else {
        ALAssetsLibrary *library=[[ALAssetsLibrary alloc] init];
        
        [library assetForURL:url
                 resultBlock:^(ALAsset *asset)
         {
             if (asset){
                 ALAssetRepresentation *representation = [asset defaultRepresentation];
                 [self exportVideo:representation.url withCompltion:block];
                 
                 //////////////////////////////////////////////////////
                 // SUCCESS POINT #1 - asset is what we are looking for
                 //////////////////////////////////////////////////////
             }
             else {
                 // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
                 
                 [library enumerateGroupsWithTypes:ALAssetsGroupAll
                                        usingBlock:^(ALAssetsGroup *group, BOOL *stop)
                  {
                      [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                          if([result.defaultRepresentation.url isEqual:url])
                          {
                              [self exportVideo:result.defaultRepresentation.url withCompltion:block];
                              ///////////////////////////////////////////////////////
                              // SUCCESS POINT #2 - result is what we are looking for
                              ///////////////////////////////////////////////////////
                          }
                      }];
                  }
                  
                                      failureBlock:^(NSError *error)
                  {
                      NSLog(@"Error: Cannot load asset from photo stream - %@", [error localizedDescription]);
                      block(nil);
                      
                  }];
             }
             
         }
                failureBlock:^(NSError *error)
         {
             NSLog(@"Error: Cannot load asset - %@", [error localizedDescription]);
             block(nil);
         }
         ];
    }
   
    
   
}
+ (void)exportVideo:(NSURL *)url withCompltion:(void (^)(NSData *))block {
    NSString *extension = @"mp4";
    
    NSString *filePath = [[Util applicationDocumentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"ExportedVideo.%@",extension]];
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    
    // asset is a video
    AVURLAsset *avAsset = [[AVURLAsset alloc] initWithURL:url options:nil];
    NSString *compressFormat = AVAssetExportPreset640x480;
    
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    if ([compatiblePresets containsObject:compressFormat]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]
                                               initWithAsset:avAsset presetName:compressFormat];
        // Implementation continues.
        
        
        exportSession.outputURL = [NSURL fileURLWithPath:filePath];
        //exportSession.outputFileType = [representation UTI];
        exportSession.outputFileType = @"public.mpeg-4";
        
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    
                    NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(nil);
                    });
                    
                    break;
                    
                    
                }
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"Export canceled");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(nil);
                    });

                    
                    break;
                    
                }
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"Export completed");
                    NSData *exportedData = [NSData dataWithContentsOfFile:filePath];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(exportedData);
                    });
                    break;
                }
                default:
                    break;
            }
        }];
    }
}
/*
+ (void)getVideoFromUrl:(NSURL *)url withCompltion:(void (^)(NSData *))block {
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];

    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)
     {
         ALAssetRepresentation *representation = [asset defaultRepresentation];
         //NSString *extension = [representation.url pathExtension];
         
         if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
 
         }
     }failureBlock:^(NSError *error) {
         block(nil);
     }];
}*/

+ (MarqueeLabel *) setMarqueeProperty:(MarqueeLabel *)lable{
    
    lable.marqueeType = MLContinuous;
    lable.scrollDuration = scrollingDuration;
    lable.fadeLength = textFadingLength;
    lable.trailingBuffer = textTrailingBufferLength;
    return lable;
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
