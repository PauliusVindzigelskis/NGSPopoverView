//
//  NGSPopoverView.h
//
//  Created by Paulius Vindzigelskis on 2014-12-12.
//  Copyright (c) 2014 Paulius Vindzigelskis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NGSPopoverArrowPosition)
{
    NGSPopoverArrowPositionAutomatic,
    NGSPopoverArrowPositionBottom,
    NGSPopoverArrowPositionLeft,
    NGSPopoverArrowPositionTop,
    NGSPopoverArrowPositionRight,
    NGSPopoverArrowPositionCount
};

@class NGSPopoverView;
@protocol  NGSPopoverViewDelegate <NSObject>
@optional
- (void) popoverView:(NGSPopoverView*) popoverView willShowAnimated:(BOOL) animated;
- (void) popoverView:(NGSPopoverView*) popoverView didShowAnimated:(BOOL) animated;
- (void) popoverView:(NGSPopoverView*) popoverView willHideAnimated:(BOOL) animated;
- (void) popoverView:(NGSPopoverView*) popoverView didHideAnimated:(BOOL) animated;
- (BOOL) popoverViewShouldDismissAnimated:(NGSPopoverView*) popoverView;
@end

IB_DESIGNABLE
@interface NGSPopoverView : UIView

@property (nonatomic, weak) id <NGSPopoverViewDelegate> delegate;

/*!
 * @brief Rouncded corner radius. Default is 0 (no rounded corner)
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/*!
 * @brief Arrow direction to draw - left, right, top or bottom
 */
@property (nonatomic, assign) IBInspectable NGSPopoverArrowPosition arrowDirection;

/*!
 * @brief Arrow size in dimensions. How it will look like depends on arow direction.
 */
@property (nonatomic, assign) IBInspectable CGSize arrowSize;

/*!
 * @brief Just preferred offset from (0,0) coordination inside popover. It will be optimized to fit nicely on bubble
 */
@property (nonatomic, assign) IBInspectable CGFloat arrowOffset;

/*!
 * @brief Default setter uses setContentView:withInsets: method with corner radius insets from each side, but minimum 10pt.
 */
@property (nonatomic, weak) UIView *contentView;

/*!
 * @brief When shows using showFromView: method, semi transparent black view hides all views under it. Enable this to exclude source view with rect equal to its size and rounded corner equal to maskedSourceViewCornerRadius property.
 */
@property (nonatomic, assign) BOOL shouldMaskSourceViewToVisible;

/*!
 * @brief When shows using showFromView: method, semi transparent black view hides all views under it. Enable shouldMaskSourceViewToVisible property to exclude source view with rect equal to its size and rounded corner equal to this property.
 */
@property (nonatomic, assign) CGFloat maskedSourceViewCornerRadius;

/*!
 * @brief Default value is YES. If implemented, calls popoverViewShouldDismissAnimated: delegate method just before dismissal.
 * @note Dismisses animated. If needed non-animated dismissal, use popoverViewShouldDismissAnimated: delegate method.
 */
@property (nonatomic, assign) BOOL dismissOnTap;

/*!
 * @brief Bool value to indicate if popover should fill window axis depending on where arrow is: fills horizontaly if arrow is vertical and fills vertically if arrow is horizontal.
 * @note Recommended to use with 0 corner radius for better look.
 */
@property (nonatomic, assign) BOOL fillScreen;

/*!
 * @brief Minimum time to show popover. If user tries to dismiss earlier, popover waits for timeout and dismisses automatically.
 * @note Default value is 0.
 */
@property (nonatomic, assign) NSTimeInterval minShowTimeInterval;

/*!
 * @brief Use setContentView: method to assign content view.
 * @param cornerRadius Rounded corner radius in CGFloat value. Can be 0.
 * @param arrowDirection Direction of arrow - left, right, top or bottom.
 * @param arrowSize Arrow dimensions in CGSize. If not square, look differs for vertical and horizontal arrow.
 */
-(instancetype)initWithCornerRadius:(CGFloat)corner
                          direction:(NGSPopoverArrowPosition)direction
                          arrowSize:(CGSize)arrSize;
/*!
 * @brief Don't add content view manually! This method adds it with automatic position calculation according to arrow size and position.
 * @param view View to make popover's content view.
 * @param insets Insets from each border inside popover.
 */
- (void) setContentView:(UIView*)view withInsets:(UIEdgeInsets)insets;

/**
 Animated show popover on app window with black see-through background.
 */
-(void)showFromView:(UIView *)view animated:(BOOL)animated;

/**
 Dismiss popover animated
 */
- (void) dismissAnimated:(BOOL)animated;

@end
