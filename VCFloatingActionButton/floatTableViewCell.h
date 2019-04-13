//
//  floatTableViewCell.h
//  floatingButtonTrial
//
//  Created by Giridhar on 26/03/15.
//  Copyright (c) 2015 Giridhar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaddingLabel.h"

@interface floatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet PaddingLabel *title;
@property (strong,nonatomic) UIView *overlay;
-(void)setTitle:(NSString*)txt andImage:(UIImage*)img;

@end
