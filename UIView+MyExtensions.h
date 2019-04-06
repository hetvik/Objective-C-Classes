//
//  UIView+MyExtensions.h


#import <UIKit/UIKit.h>

@interface UIView (MyExtensions)

@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;


@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat sizeWidth;
@property (nonatomic, assign) CGFloat sizeHeight;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
-(void)diognalView;
@end

@interface UILabel (MyExtensions)
@property (nonatomic) IBInspectable NSString *localizedTextKey;
@end

@interface UIButton (MyExtensions)
@property (nonatomic) IBInspectable NSString *localizedTitleKey;
@end

@interface UITextField (MyExtensions)
@property (nonatomic) IBInspectable NSString *localizedTextKey;
@property (nonatomic) IBInspectable NSString *localizedPlaceholderKey;
@end

@interface UITextView (MyExtensions)
@property (nonatomic) IBInspectable NSString *localizedTextKey;

@end
