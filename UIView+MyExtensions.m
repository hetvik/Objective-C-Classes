
//
//  UIView+MyExtensions.m



#import "UIView+MyExtensions.h"

@implementation UIView (MyExtensions)

@dynamic borderColor,borderWidth,cornerRadius;
@dynamic originX,originY,sizeWidth,sizeHeight,origin,size;


-(void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setMasksToBounds:YES];
}
- (void)setOriginX:(CGFloat)originX {
    CGRect rect = self.frame;
    rect.origin.x = originX;
    self.frame = rect;
}
- (void)setOriginY:(CGFloat)originY {
    CGRect rect = self.frame;
    rect.origin.y = originY;
    self.frame = rect;
}
- (void)setSizeWidth:(CGFloat)sizeWidth {
    CGRect rect = self.frame;
    rect.size.width = sizeWidth;
    self.frame = rect;
}
- (void)setSizeHeight:(CGFloat)sizeHeight {
    CGRect rect = self.frame;
    rect.size.height = sizeHeight;
    self.frame = rect;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}
- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

-(void)diognalView {
    CGSize viewSize = self.frame.size;
    CGPoint p1 = CGPointMake(0, viewSize.height);
    CGPoint p2 = CGPointMake(0, viewSize.height - 20);
    CGPoint p3 = CGPointMake(viewSize.width, viewSize.height * 0.55);
    CGPoint p4 = CGPointMake(viewSize.width, viewSize.height);
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p1];
    [path addLineToPoint:p2];
    [path addLineToPoint:p3];
    [path addLineToPoint:p4];
    [path closePath];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = nil;
    [self.layer addSublayer:layer];
    
}
@end

@implementation UILabel (MyExtensions)
@dynamic localizedTextKey;
- (void)setLocalizedText:(NSString *)localizedTextKey {
    self.text = NSLocalizedString(localizedTextKey, nil);
}
@end
@implementation UIButton (MyExtensions)
@dynamic localizedTitleKey;
- (void)setLocalizedTitleKey:(NSString *)localizedTitleKey {
    [self setTitle:NSLocalizedString(localizedTitleKey, nil) forState:UIControlStateNormal];

}
@end
@implementation UITextField (MyExtensions)
@dynamic localizedTextKey,localizedPlaceholderKey;
- (void)setLocalizedText:(NSString *)localizedTextKey {
    self.text = NSLocalizedString(localizedTextKey, nil);
}
- (void)setLocalizedPlaceholderKey:(NSString *)localizedPlaceholderKey {
    self.placeholder = NSLocalizedString(localizedPlaceholderKey, nil);
}
@end
@implementation UITextView (MyExtensions)
@dynamic localizedTextKey;
- (void)setLocalizedText:(NSString *)localizedTextKey {
    self.text = NSLocalizedString(localizedTextKey, nil);
}

@end

