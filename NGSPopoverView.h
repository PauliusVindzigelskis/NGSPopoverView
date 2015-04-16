//
//  NGSPopoverView.h
//
//  Created by Paulius Vindzigelskis on 2014-12-12.
//  Copyright (c) 2014 Paulius Vindzigelskis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NGSPopoverArrowPosition)
{
    NGSPopoverArrowPositionAnywhere,
    NGSPopoverArrowPositionBottom,
    NGSPopoverArrowPositionLeft,
    NGSPopoverArrowPositionTop,
    NGSPopoverArrowPositionRight,
    NGSPopoverArrowPositionCount
};

IB_DESIGNABLE
@interface NGSPopoverView : UIView

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable NSUInteger arrowDirection;
@property (nonatomic, assign) IBInspectable CGSize arrowSize;
@property (nonatomic, assign) IBInspectable CGFloat arrowOffset;

@property (nonatomic, strong) IBOutlet UIView *contentView;

-(instancetype)initWithCornerRadius:(CGFloat)corner
                          direction:(NGSPopoverArrowPosition)direction
                          arrowSize:(CGSize)arrSize;

-(void)showFromView:(UIView *)view;
-(void)showFromView:(UIView *)view dismissOnTap:(BOOL)dismissOnTap fillScreen:(BOOL)fillScreen;
- (void) dismiss;

@end
