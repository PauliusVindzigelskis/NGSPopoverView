
# NGSPopoverView

[![Version](https://img.shields.io/cocoapods/v/NGSPopoverView.svg)](http://cocoapods.org/pods/NGSPopoverView)
[![Build Status](https://travis-ci.org/PauliusVindzigelskis/NGSPopoverView.svg?branch=R1.1.0)](https://travis-ci.org/PauliusVindzigelskis/NGSPopoverView)
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://github.com/PauliusVindzigelskis/NGSPopoverVieww)
[![Language](https://img.shields.io/badge/language-ObjC-blue.svg)](https://github.com/PauliusVindzigelskis/NGSPopoverView)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PauliusVindzigelskis/NGSPopoverView/master/LICENSE)

# README #

Universal simple popover view to show any kind of content which is subclass of UIView. Works in both - iPhone and iPad. Easy customizable.

## Installation ##


### Cocoapods ###

pod 'NGSPopoverView'

### General ###

Include NGSPopoverView .h and .m files in your target. #import "NGSPopoverView.h" where needed.

## FAQ ##

* How to change color of it from white to whatever I need?

Use tintColor property. Default value is white.

* I added UITableView inside popover, but it shows empty content. What did I do wrong?

NGSPopoverView uses AutoLayout to calculate it's size. Add height (required) and width (optional) constraints to UITableView as it doesn't have intrinsicContentSize property set up.

## Samples ##


### Rounded corners ###

![rounded_corner.png](https://bitbucket.org/repo/8yGqo8/images/2516946630-rounded_corner.png)

```
- (IBAction)buttonPressed:(UIButton *)sender {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Some text\nAnd some more";
    label.numberOfLines = 0;
    
    NGSPopoverView *popover = [[NGSPopoverView alloc] initWithCornerRadius:10.f
                                                                 direction:NGSPopoverArrowPositionAutomatic
                                                                 arrowSize:CGSizeMake(20, 10)];
    popover.contentView = label;
    
    [popover showFromView:sender animated:YES];
}
```

### Fill screen ###
![fill_screen.png](https://bitbucket.org/repo/8yGqo8/images/3076218040-fill_screen.png)
```
- (IBAction)buttonPressed:(UIButton *)sender {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Some text\nAnd some more";
    label.numberOfLines = 0;
    
    NGSPopoverView *popover = [[NGSPopoverView alloc] initWithCornerRadius:0.f
                                                                 direction:NGSPopoverArrowPositionAutomatic
                                                                 arrowSize:CGSizeMake(20, 10)];
    popover.contentView = label;
    popover.fillScreen = YES;
    
    [popover showFromView:sender animated:YES];
}
```
### Mask source view with transparency ###
![mask_view.png](https://bitbucket.org/repo/8yGqo8/images/3619268285-mask_view.png)
```
- (IBAction)buttonPressed:(UIButton *)sender {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Some text\nAnd some more";
    label.numberOfLines = 0;
    
    NGSPopoverView *popover = [[NGSPopoverView alloc] initWithCornerRadius:10.f
                                                                 direction:NGSPopoverArrowPositionAutomatic
                                                                 arrowSize:CGSizeMake(20, 10)];
    popover.contentView = label;
    popover.shouldMaskSourceViewToVisible = YES;
    popover.maskedSourceViewCornerRadius = sender.frame.size.width/2.f;
    
    [popover showFromView:sender animated:YES];
}
```

[![Analytics](https://ga-beacon.appspot.com/UA-62210028-4/ngspopoverview?flat)](https://github.com/igrigorik/ga-beacon)

<a target="_blank" href="http://www.hey.lt/details.php?id=ngspopoverview"><img width="88" height="31" border="0"
src="http://www.hey.lt/count.php?id=ngspopoverview" alt="Hey.lt - Nemokamas lankytojų skaitliukas"></a>
