//
//  NGSPopoverView.m
//
//  Created by Paulius Vindzigelskis on 2014-12-12.
//  Copyright (c) 2014 Paulius Vindzigelskis. All rights reserved.
//

#import "NGSPopoverView.h"
#import "UIView+NGSPopoverView.h"

@interface NGSPopoverView ()

@property (nonatomic, assign) UIEdgeInsets customInsets;

//Show on window
@property (nonatomic, weak) UIView *blurView;
@property (nonatomic, weak) UIView *fromView;
@property (nonatomic, assign) BOOL isArrowDirectionChanged;
@property (nonatomic, weak) CALayer *blurLayer;
@property (nonatomic, assign) NSTimeInterval showTimePassed;
@property (nonatomic, assign) BOOL autoDismissAfterMinTime;

@end

@implementation NGSPopoverView

- (instancetype) init
{
    if (self = [super init])
    {
        self.tintColor = [UIColor whiteColor];
    } return self;
}

-(instancetype)initWithCornerRadius:(CGFloat)corner direction:(NGSPopoverArrowPosition)direction arrowSize:(CGSize)arrSize
{
    if (self = [self init])
    {
        NSAssert((direction >=0 && direction < NGSPopoverArrowPositionCount), @"");
        _arrowDirection = direction;
        _cornerRadius = corner;
        _arrowSize = arrSize;
        if ([self isDirectionHorizontal:direction])
        {
            [self switchArrowSizeValues];
        }
        _dismissOnTap = YES;
        self.backgroundColor = [UIColor clearColor];//default color
    }
    return self;
}

-(void)setContentView:(UIView *)contentView
{
    CGFloat inset = MAX(10.f, _cornerRadius);
    [self setContentView:contentView withInsets:UIEdgeInsetsMake(inset, inset, inset, inset)];
}
-(void)setContentView:(UIView *)contentView withInsets:(UIEdgeInsets)margins
{
    self.customInsets = margins;
    if (_contentView)
    {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    
    _contentView = contentView;
    
    if (contentView)
    {
        [contentView removeFromSuperview];
        
        UIEdgeInsets insets = [self edgeInsets];
        margins.left += insets.left;
        margins.right += insets.right;
        margins.top += insets.top;
        margins.bottom += insets.bottom;
        
        [self addSubviewFillingParent:contentView
                              margins:margins];
    }
}

-(void)setArrowDirection:(NGSPopoverArrowPosition)arrowDirection
{
    NGSPopoverArrowPosition oldDirection = _arrowDirection;
    
    NSAssert((arrowDirection >=0 && arrowDirection < NGSPopoverArrowPositionCount), @"");
    _arrowDirection = arrowDirection;
    self.isArrowDirectionChanged = YES;
    
    if (
        [self isDirectionHorizontal:arrowDirection]
        ^
        [self isDirectionHorizontal:oldDirection]
        )
    {
        [self switchArrowSizeValues];
    }
}

- (void) switchArrowSizeValues
{
    CGSize arrowSize = _arrowSize;
    _arrowSize.width = arrowSize.height;
    _arrowSize.height = arrowSize.width;
    
}

- (BOOL) isDirectionHorizontal:(NGSPopoverArrowPosition)position
{
    return (position == NGSPopoverArrowPositionLeft
            || position == NGSPopoverArrowPositionRight);
}

-(UIColor *)tintColor
{
    UIColor *tintColor = [super tintColor] ? : [UIColor greenColor];
    return tintColor;
}

#pragma mark - View setup

-(CGSize)intrinsicContentSize
{
    CGFloat minWidth = self.cornerRadius * 2.f + _arrowSize.width;
    CGFloat minHeight = self.cornerRadius * 2.f + _arrowSize.height;
    CGSize minSize = CGSizeMake(minWidth, minHeight);
    if (self.contentView)
    {
        CGSize minContentSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        CGSize fullSize = minSize;
        fullSize.width += minContentSize.width;
        fullSize.height += minContentSize.height;
        
        return fullSize;
    } else {
        return minSize;
    }
}

- (void)drawRect:(CGRect)rect {
    [self drawRectangle];
    [self drawArrow];
}

- (UIEdgeInsets) edgeInsets
{
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    switch ((NGSPopoverArrowPosition)self.arrowDirection) {
        case NGSPopoverArrowPositionBottom:
        {
            insets.bottom = self.arrowSize.height;
        }   break;
        case NGSPopoverArrowPositionLeft:
        {
            insets.left = self.arrowSize.width;
        }   break;
        case NGSPopoverArrowPositionTop:
        {
            insets.top = self.arrowSize.height;
        }   break;
        case NGSPopoverArrowPositionRight:
        {
            insets.right = self.arrowSize.width;
        }   break;
            
        default:
            break;
    }
    return insets;
}

- (CGRect) rectangleRect
{
    UIEdgeInsets edgeInsets = [self edgeInsets];
    CGRect rect = self.bounds;
    rect.origin.x += edgeInsets.left;
    rect.size.width -= edgeInsets.left;
    
    rect.origin.y += edgeInsets.top;
    rect.size.height -= edgeInsets.top;
    
    rect.size.width -= edgeInsets.right;
    rect.size.height -= edgeInsets.bottom;
    
    return rect;
}

- (void) drawRectangle
{
    CGRect rect = [self rectangleRect];
    
    CGPoint startPosition = CGPointMake(rect.origin.x + _cornerRadius, rect.origin.y);
    
    CGPoint point1 = CGPointMake(rect.origin.x + rect.size.width - _cornerRadius, startPosition.y);
    CGPoint point2 = CGPointMake(point1.x + _cornerRadius, point1.y + _cornerRadius);
    CGPoint point2_control = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    CGPoint point3 = CGPointMake(point2.x, rect.origin.y + rect.size.height - _cornerRadius);
    CGPoint point4 = CGPointMake(point3.x - _cornerRadius, point3.y + _cornerRadius);
    CGPoint point4_control = CGPointMake(point2_control.x, point2_control.y + rect.size.height);
    CGPoint point5 = CGPointMake(rect.origin.x + _cornerRadius, point4.y);
    CGPoint point6 = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height - _cornerRadius);
    CGPoint point6_control = CGPointMake(rect.origin.x, point4_control.y);
    CGPoint point7 = CGPointMake(point6.x, rect.origin.y + _cornerRadius);
    CGPoint point8 = startPosition;
    CGPoint point8_control = CGPointMake(rect.origin.x, rect.origin.y);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [self.tintColor setStroke];
    [self.tintColor setFill];
    
    [path moveToPoint:startPosition];
    [path addLineToPoint:point1];
    [path addQuadCurveToPoint:point2 controlPoint:point2_control];
    [path addLineToPoint:point3];
    [path addQuadCurveToPoint:point4 controlPoint:point4_control];
    [path addLineToPoint:point5];
    [path addQuadCurveToPoint:point6 controlPoint:point6_control];
    [path addLineToPoint:point7];
    [path addQuadCurveToPoint:point8 controlPoint:point8_control];
    
    [path stroke];
    [path fill];
}

- (void) drawArrow
{
    CGPoint arrowPosition = CGPointMake(_arrowOffset, _arrowOffset);
    {
        CGRect rect = [self rectangleRect];
        
        CGFloat horizontalAlpha = _cornerRadius + _arrowSize.width / 2.f;
        CGFloat vertivalAlpha = _cornerRadius + _arrowSize.height /2.f;
        
        arrowPosition.x = MAX(rect.origin.x + horizontalAlpha, arrowPosition.x); //left
        arrowPosition.x = MIN(rect.origin.x + rect.size.width - horizontalAlpha, arrowPosition.x); // right
        arrowPosition.y = MAX(rect.origin.y + vertivalAlpha, arrowPosition.y); //top
        arrowPosition.y = MIN(rect.origin.y + rect.size.height - vertivalAlpha, arrowPosition.y); // bottom
    }
    
    CGPoint startPosition = arrowPosition;
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    
    CGPoint point1, point2, point3 = CGPointZero;
    
    CGFloat arrowWidth = _arrowSize.width;
    CGFloat arrowHeight = _arrowSize.height;
    
    switch ((NGSPopoverArrowPosition)self.arrowDirection) {
        case NGSPopoverArrowPositionBottom:
        {
            startPosition.y = self.frame.size.height - 0.5f;
            
            point1 = CGPointMake(startPosition.x - arrowWidth/2, startPosition.y - arrowHeight);
            point2 = CGPointMake(point1.x + arrowWidth, point1.y);
            point3 = startPosition;
            
            insets.bottom = arrowHeight;
        }   break;
        case NGSPopoverArrowPositionLeft:
        {
            startPosition.x = 0.5f;
            
            point1 = CGPointMake(startPosition.x + arrowWidth, startPosition.y - arrowHeight/2);
            point2 = CGPointMake(point1.x, startPosition.y + arrowHeight/2);
            point3 = startPosition;
            
            insets.left = arrowWidth;
        }   break;
        default:
        case NGSPopoverArrowPositionTop:
        {
            startPosition.y = 0.5f;
            
            point1 = CGPointMake(startPosition.x + arrowWidth/2, startPosition.y + arrowHeight);
            point2 = CGPointMake(startPosition.x - arrowWidth/2, point1.y);
            point3 = startPosition;
            
            insets.top = arrowHeight;
        }   break;
        case NGSPopoverArrowPositionRight:
        {
            startPosition.x = self.frame.size.width - 0.5f;
                
            point1 = CGPointMake(startPosition.x - arrowWidth, startPosition.y + arrowHeight/2);
            point2 = CGPointMake(point1.x, startPosition.y - arrowHeight/2);
            point3 = startPosition;
            
            insets.right = arrowWidth;
        }   break;
    }
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    

    [self.tintColor setStroke];
    [self.tintColor setFill];
    
    [path setLineWidth:0.5f];
    
    [path moveToPoint:startPosition];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path closePath];
    
    
    [path stroke];
    [path fill];
}

#pragma mark - Show on window - Inherited

-(void)layoutSubviews
{
    if (self.blurView)
    {
        UIView *superview = self.blurView.superview;
        if (self.blurLayer)
        {
            [self.blurLayer removeFromSuperlayer];
            CALayer *newLayer = [self blurFillLayerWithSuperview:superview holeView:_fromView];
            [self.blurView.layer addSublayer:newLayer];
            self.blurLayer = newLayer;
            
            [self.superview bringSubviewToFront:self];
        }
        
        CGPoint point = [_fromView.superview convertPoint:_fromView.center toView:superview];
        
        CGFloat offset = 0;
        if ([self isArrowVertical])
        {
            offset = point.x - self.frame.origin.x;
        } else {
            offset = point.y - self.frame.origin.y;
        }
        self.arrowOffset = offset;
        
    }
    [super layoutSubviews];
}

#pragma mark - Show on window - Tools

- (BOOL) isArrowVertical
{
    return (self.arrowDirection == NGSPopoverArrowPositionTop || self.arrowDirection == NGSPopoverArrowPositionBottom);
}

-(NGSPopoverArrowPosition) arrowDirectionForView:(UIView*)view superView:(UIView*)superview
{
    //detect arrow direction
    CGRect frame = [view.superview convertRect:view.frame toView:superview];
    CGFloat topSpace = frame.origin.y;
    CGFloat leftSpace = frame.origin.x;
    CGFloat bottomSpace = superview.frame.size.height - CGRectGetMaxY(frame);
    CGFloat rightSpace = superview.frame.size.width - CGRectGetMaxX(frame);
    
    CGFloat maxVerticalValue = MAX(bottomSpace, topSpace);
    CGFloat maxHorizontalValue = MAX(leftSpace, rightSpace);
    NGSPopoverArrowPosition direction;
    if (maxHorizontalValue > maxVerticalValue)
    {
        //horizontal it is!
        direction = leftSpace > rightSpace ? NGSPopoverArrowPositionRight : NGSPopoverArrowPositionLeft;
    } else {
        //vertical it is!
        direction = topSpace > bottomSpace ? NGSPopoverArrowPositionBottom : NGSPopoverArrowPositionTop;
    }
    
    return direction;
}

#pragma mark - Show on window - Public

-(void)showFromView:(UIView *)anchorView animated:(BOOL)animated
{
    NSAssert([anchorView isKindOfClass:[UIView class]], @"Should be any kind of UIView");
    self.fromView = anchorView;
    UIView *superview = anchorView.window;
    
    if (self.arrowDirection == NGSPopoverArrowPositionAutomatic)
    {
        self.arrowDirection = [self arrowDirectionForView:anchorView superView:superview];
    }
    
    //renew insets as arrow direction might have changed from initializer.
    if (self.isArrowDirectionChanged && _contentView)
    {
        self.isArrowDirectionChanged = NO;
        [self setContentView:_contentView withInsets:_customInsets];
    }
    
    
    UIView *blurView = [[UIView alloc] init];
    if (self.dismissOnTap)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(tappedToDismiss) forControlEvents:UIControlEventTouchUpInside];
        [blurView addSubviewFillingParent:button margins:UIEdgeInsetsZero];
    }
    self.blurView = blurView;
    [superview addSubviewFillingParent:blurView margins:UIEdgeInsetsZero];
    if (self.shouldMaskSourceViewToVisible){
        //Semi transparent black layer with hole in it to show source view
        CALayer *fillLayer = [self blurFillLayerWithSuperview:superview holeView:anchorView];
        [blurView.layer addSublayer:fillLayer];
        self.blurLayer = fillLayer;
    } else {
        blurView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5f];
    }
    
    [blurView addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    { // constraints to parent
        BOOL isVertical = [self isArrowVertical];
        NSString *inEqualString = @">=";
        NSString *equalString = self.fillScreen ? @"" : @">=";
        NSString *verticalConstraintsFormat = [NSString stringWithFormat:@"V:|-(%@0)-[view]-(%@0)-|",
                                               isVertical ? inEqualString : equalString,
                                               isVertical ? inEqualString : equalString];
        NSString *horizontalConstraintsFormat = [NSString stringWithFormat:@"H:|-(%@0)-[view]-(%@0)-|",
                                                 isVertical ? equalString : inEqualString,
                                                 isVertical ? equalString : inEqualString];
        
        NSDictionary *views = @{@"view":self};
        NSMutableArray *allConstraints = [NSMutableArray array];
        [allConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintsFormat options:0 metrics:nil views:views]];
        [allConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintsFormat options:0 metrics:nil views:views]];
        
        [blurView addConstraints:allConstraints];
    }
    
    CGFloat offset = 5.f;
    NSLayoutConstraint *first;
    NSLayoutConstraint *second;
    switch ((NGSPopoverArrowPosition)self.arrowDirection) {
            
        case NGSPopoverArrowPositionBottom:
        {
            first = [NSLayoutConstraint constraintWithItem:anchorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.f];
            second = [NSLayoutConstraint constraintWithItem:anchorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:offset];
        }   break;
        
        default:
        case NGSPopoverArrowPositionTop:
        {
            first = [NSLayoutConstraint constraintWithItem:anchorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.f];
            second = [NSLayoutConstraint constraintWithItem:anchorView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:-offset];
        }   break;
            
        case NGSPopoverArrowPositionLeft:
        {
            first = [NSLayoutConstraint constraintWithItem:anchorView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:-offset];
            second = [NSLayoutConstraint constraintWithItem:anchorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.f];

        }   break;
            
            
        case NGSPopoverArrowPositionRight:
        {
            first = [NSLayoutConstraint constraintWithItem:anchorView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:offset];
            second = [NSLayoutConstraint constraintWithItem:anchorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.f];
        }   break;
        

    }
    UILayoutPriority priority = 250;
    first.priority = priority;
    second.priority = priority;
    [superview addConstraints:@[first, second]];
    
    if ([self.delegate respondsToSelector:@selector(popoverView:willShowAnimated:)])
    {
        [self.delegate popoverView:self willShowAnimated:animated];
    }
    
    //animations
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(popoverView:didShowAnimated:)])
        {
            [self.delegate popoverView:self didShowAnimated:animated];
        }
    };
    
    if (animated)
    {
        blurView.alpha = 0.f;
        [UIView animateWithDuration:0.3f animations:^{
            blurView.alpha = 1.f;
        } completion:completion];
    } else {
        completion(YES);
    }
    
    self.showTimePassed = 0;
    self.autoDismissAfterMinTime = NO;
    if (self.minShowTimeInterval)
    {
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    }
}

- (void) tappedToDismiss
{
    BOOL shouldDismiss = self.showTimePassed >= self.minShowTimeInterval;
    if ([self.delegate respondsToSelector:@selector(popoverViewShouldDismissAnimated:)])
    {
        shouldDismiss = [self.delegate popoverViewShouldDismissAnimated:self];
    } else {
        self.autoDismissAfterMinTime = YES;
    }
    
    if (shouldDismiss)
    {
        [self dismissAnimated:YES];
    }
}

- (void) timerTick:(NSTimer*)timer
{
    self.showTimePassed += timer.timeInterval;
    if (self.showTimePassed >= self.minShowTimeInterval)
    {
        [timer invalidate];
        if (self.autoDismissAfterMinTime)
        {
            [self tappedToDismiss];
        }
    }
}

- (void) dismissAnimated:(BOOL)animated
{
    if (self.blurView)
    {
        if ([self.delegate respondsToSelector:@selector(popoverView:willHideAnimated:)])
        {
            [self.delegate popoverView:self willHideAnimated:animated];
        }
        
        void (^completion)(BOOL finished) = ^(BOOL finished){
            [self.blurView removeFromSuperview];
            [self removeFromSuperview];
            
            self.blurView = nil;
            self.blurLayer = nil;
            self.fromView = nil;
            
            
            if ([self.delegate respondsToSelector:@selector(popoverView:didHideAnimated:)])
            {
                [self.delegate popoverView:self didHideAnimated:animated];
            }
        };
        if (animated)
        {
            self.blurView.alpha = 1.f;
            [UIView animateWithDuration:0.3f animations:^{
                self.blurView.alpha = 0.f;
            } completion:completion];
        } else {
            completion(YES);
        }
        
    }
}

#pragma mark - Setup

- (CALayer*) blurFillLayerWithSuperview:(UIView*)superview holeView:(UIView*)view
{
    CGFloat radius = self.maskedSourceViewCornerRadius;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:superview.frame cornerRadius:0];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:[superview convertRect:view.frame fromView:view.superview] cornerRadius:radius];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.5;
    
    return fillLayer;
}
 



@end
