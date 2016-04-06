//
//  UIView+NGSAutoLayout.m
//  Pods
//
//  Created by Paulius Vindzigelskis on 06/04/16.
//
//

#import "UIView+NGSPopoverView.h"

@implementation UIView (NGSPopoverView)

-(void)addSubviewFillingParent:(UIView *)view margins:(UIEdgeInsets)margins
{
    [self addSubview:view];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(view);
    NSDictionary *metrics = @{@"top"     : @(margins.top),
                              @"bottom"  : @(margins.bottom),
                              @"left"    : @(margins.left),
                              @"right"   : @(margins.right)
                              };
    
    NSArray *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[view]-bottom-|" options:0 metrics:metrics views:viewsDict];
    NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view]-right-|" options:0 metrics:metrics views:viewsDict];
    
    [self addConstraints:constraintsV];
    [self addConstraints:constraintsH];
}

@end
