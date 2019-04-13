//
//  PaddingLabel.h
//  InterestCalculator
//
//  Created by Bhavik Talpada on 13/04/19.
//  Copyright © 2019 Bhavik Talpada. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PaddingLabel : UILabel

@property (nonatomic) IBInspectable CGFloat topInset;
@property (nonatomic) IBInspectable CGFloat bottomInset;
@property (nonatomic) IBInspectable CGFloat leftInset;
@property (nonatomic) IBInspectable CGFloat rightInset;

@end

