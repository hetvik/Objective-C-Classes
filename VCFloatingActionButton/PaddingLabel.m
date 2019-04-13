//
//  PaddingLabel.m
//  InterestCalculator
//
//  Created by Bhavik Talpada on 13/04/19.
//  Copyright © 2019 Bhavik Talpada. All rights reserved.
//

#import "PaddingLabel.h"

#define PADDING 10


@implementation PaddingLabel


- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING))];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    return CGRectInset([self.attributedText boundingRectWithSize:CGSizeMake(999, 999) options:NSStringDrawingUsesLineFragmentOrigin context:nil], -PADDING, -PADDING);
}
@end
