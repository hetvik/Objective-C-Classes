//
//  Constant.h


#ifndef MapKitDraw_Constant_h
#define MapKitDraw_Constant_h

#define scrollingDuration 20.0f
#define textFadingLength 10.0f
#define textTrailingBufferLength 30.0f

#define Server [AFAppDotNetAPIClient sharedClient]

#define SharedAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(msg, @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Close", @"") otherButtonTitles:nil, nil] show]

#define delay(seconds, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block)

#define localize(msg) NSLocalizedString(msg, @"")

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define iOs7   (IOS_VERSION >= 7.0)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define kFont_Avenir_Book(fontSize) [UIFont fontWithName:@"Avenir-Book" size:fontSize];
#define kFont_Avenir_Medium(fontSize) [UIFont fontWithName:@"Avenir-Medium" size:fontSize];
#define kFont_Avenir_Light(fontSize) [UIFont fontWithName:@"Avenir-Light" size:fontSize];
#define kFont_Avenir_Heavy(fontSize) [UIFont fontWithName:@"Avenir-Heavy" size:fontSize];

//TitilliumText22L
#define kFont_TitilliumText22L_Light(fontSize) [UIFont fontWithName:@"TitilliumText22L-Light" size:fontSize];
#define kFont_TitilliumText22L_Regular(fontSize) [UIFont fontWithName:@"TitilliumText22L-Regular" size:fontSize];
#define kFont_TitilliumText22L_Bold(fontSize) [UIFont fontWithName:@"TitilliumText22L-Bold" size:fontSize];
#define kFont_TitilliumText22L_Medium(fontSize) [UIFont fontWithName:@"TitilliumText22L-Medium" size:fontSize];
#define kFont_TitilliumText22L_XBold(fontSize) [UIFont fontWithName:@"TitilliumText22L-XBold" size:fontSize];
#define kFont_TitilliumText22L_Thin(fontSize) [UIFont fontWithName:@"TitilliumText22L-Thin" size:fontSize];

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 460.0)
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)

#define Base_Url @""

#endif
