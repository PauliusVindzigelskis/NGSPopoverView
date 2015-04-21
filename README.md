# README #

Simple popover view to show any kind of content which is subclass of UIView

## How do I get set up? ##

* Just import NGSPopoverView .h and .m files

## Samples ##


### Rounded corners ###
![iOS Simulator Screen Shot 2015 bal. 21 11.48.52.png](https://bitbucket.org/repo/8yGqo8/images/1752092786-iOS%20Simulator%20Screen%20Shot%202015%20bal.%2021%2011.48.52.png)
```
#!objective-c

- (IBAction)buttonPressed:(UIButton *)sender {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Some text\nAnd some more";
    label.numberOfLines = 0;
    
    NGSPopoverView *popover = [[NGSPopoverView alloc] initWithCornerRadius:10.f
                                                                 direction:NGSPopoverArrowPositionAnywhere
                                                                 arrowSize:CGSizeMake(20, 10)];
    popover.contentView = label;
    
    [popover showFromView:sender animated:YES];
}
```

### Fill screen ###
![iOS Simulator Screen Shot 2015 bal. 21 11.49.53.png](https://bitbucket.org/repo/8yGqo8/images/2324410341-iOS%20Simulator%20Screen%20Shot%202015%20bal.%2021%2011.49.53.png)
```
#!objective-c

- (IBAction)buttonPressed:(UIButton *)sender {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Some text\nAnd some more";
    label.numberOfLines = 0;
    
    NGSPopoverView *popover = [[NGSPopoverView alloc] initWithCornerRadius:0.f
                                                                 direction:NGSPopoverArrowPositionAnywhere
                                                                 arrowSize:CGSizeMake(20, 10)];
    popover.contentView = label;
    popover.fillScreen = YES;
    
    [popover showFromView:sender animated:YES];
}
```
### Mask source view with transparency ###
![iOS Simulator Screen Shot 2015 bal. 21 11.52.03.png](https://bitbucket.org/repo/8yGqo8/images/3404845128-iOS%20Simulator%20Screen%20Shot%202015%20bal.%2021%2011.52.03.png)
```
#!objective-c

- (IBAction)buttonPressed:(UIButton *)sender {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Some text\nAnd some more";
    label.numberOfLines = 0;
    
    NGSPopoverView *popover = [[NGSPopoverView alloc] initWithCornerRadius:10.f
                                                                 direction:NGSPopoverArrowPositionAnywhere
                                                                 arrowSize:CGSizeMake(20, 10)];
    popover.contentView = label;
    popover.shouldMaskSourceViewToVisible = YES;
    popover.maskedSourceViewCornerRadius = sender.frame.size.width/2.f;
    
    [popover showFromView:sender animated:YES];
}
```