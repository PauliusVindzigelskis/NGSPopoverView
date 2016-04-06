//
//  ViewController.m
//  NGSPopoverViewExample
//
//  Created by Paulius Vindzigelskis on 06/04/16.
//  Copyright © 2016 Paulius Vindzigelskis. All rights reserved.
//

#import "ViewController.h"
@import NGSPopoverView;

@interface ViewController ()

@end

@implementation ViewController

- (NGSPopoverView*) popoverViewWithCornerRadius:(CGFloat)cornerRadius
{
    NGSPopoverView* popover = [[NGSPopoverView alloc] initWithCornerRadius:cornerRadius direction:NGSPopoverArrowPositionAutomatic arrowSize:CGSizeMake(20.f, 20.f)];

    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Some text\nAnd some more";
    label.numberOfLines = 0;
    
    popover.contentView = label;
    
    return popover;
}

- (IBAction)firstPressed:(id)sender {
    NGSPopoverView *popover = [self popoverViewWithCornerRadius:5.f];
    
    [popover showFromView:sender animated:YES];
}

- (IBAction)secondPressed:(id)sender {
    NGSPopoverView *popover = [self popoverViewWithCornerRadius:0.f];
    popover.fillScreen = YES;
    
    [popover showFromView:sender animated:YES];
}

- (IBAction)thirdPressed:(id)sender {
    NGSPopoverView *popover = [self popoverViewWithCornerRadius:5.f];
    popover.shouldMaskSourceViewToVisible = YES;
    
    [popover showFromView:sender animated:YES];
    
}

- (IBAction)forthPressed:(UIButton *)sender {
    NGSPopoverView *popover = [self popoverViewWithCornerRadius:5.f];
    popover.shouldMaskSourceViewToVisible = YES;
    popover.maskedSourceViewCornerRadius = sender.frame.size.width / 2.f;
    
    [popover showFromView:sender animated:YES];
    
}

@end
