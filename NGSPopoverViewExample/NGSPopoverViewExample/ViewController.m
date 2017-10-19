//
//  ViewController.m
//  NGSPopoverViewExample
//
//  Created by Paulius Vindzigelskis on 06/04/16.
//  Copyright © 2016 Paulius Vindzigelskis. All rights reserved.
//

#import "ViewController.h"
#import "NGSPopoverView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *minTimeIntervalField;

@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //accessory view
    UIToolbar *tipToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    tipToolbar.barStyle = UIBarStyleBlackOpaque;
    tipToolbar.items = [NSArray arrayWithObjects:
                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                      target:nil
                                                                      action:nil],
                        [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                         style:UIBarButtonItemStyleDone                                                        target:self.minTimeIntervalField
                                                        action:@selector(resignFirstResponder)],
                        nil];
    [tipToolbar sizeToFit];
    [self.minTimeIntervalField setInputAccessoryView:tipToolbar];
}

- (NGSPopoverView*) popoverViewWithCornerRadius:(CGFloat)cornerRadius
{
    NGSPopoverView* popover = [[NGSPopoverView alloc] initWithCornerRadius:cornerRadius direction:NGSPopoverArrowPositionAutomatic arrowSize:CGSizeMake(20.f, 20.f)];

    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Some text\nAnd some more";
    label.numberOfLines = 0;
    
    popover.contentView = label;
    popover.minShowTimeInterval = [self.minTimeIntervalField.text floatValue];
    
    return popover;
}

- (IBAction)firstPressed:(id)sender {
    NGSPopoverView *popover = [self popoverViewWithCornerRadius:5.f];
    popover.shouldMaskSourceViewToVisible = YES;
    
    [popover showFromView:sender animated:YES];
}

- (IBAction)secondPressed:(id)sender {
    NGSPopoverView *popover = [self popoverViewWithCornerRadius:0.f];
    popover.fillScreen = YES;
    
    [popover showFromView:sender animated:YES];
}

- (IBAction)thirdPressed:(UIButton *)sender {
    NGSPopoverView *popover = [self popoverViewWithCornerRadius:5.f];
    popover.shouldMaskSourceViewToVisible = YES;
    popover.maskedSourceViewCornerRadius = sender.frame.size.width / 2.f;
    
    popover.outsideColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5f];
    
    [popover showFromView:sender animated:YES];
    
}

- (IBAction)forthPressed:(UIButton *)sender {
    NGSPopoverView *popover = [self popoverViewWithCornerRadius:5.f];
    
    [popover showFromView:sender animated:YES];
}

- (IBAction)fithPressed:(id)sender
{
    NGSPopoverView *popover = [self popoverViewWithCornerRadius:5.f];
    popover.outsideColor = [UIColor clearColor];
    popover.tintColor = [UIColor colorWithWhite:0 alpha:0.5f];
    
    popover.arrowDirection = NGSPopoverArrowPositionBottom;
    
    [popover showFromView:sender animated:YES];
}

@end
