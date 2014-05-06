//
//  PCKeyboardViewController.m
//  Project C
//
//  Created by Wu Ziqi on 13-5-26.
//  Copyright (c) 2013年 Wu Ziqi. All rights reserved.
//

#import "PCKeyboardViewController.h"

@interface PCKeyboardViewController ()

@end

@implementation PCKeyboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)hideKeyboard
{
    NSLog(@"self origin y is %g", self.view.frame.origin.y);
    [UIView animateWithDuration:0.6f animations:^{
        [self.view resetOriginY:self.view.superview.frame.size.height];
    }];
}

- (void)showKeyboard
{
    NSLog(@"screen height is %g, and frame height is %g",self.view.superview.frame.size.height, self.view.frame.size.height);
    [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseOut animations:^{
         [self.view resetOriginY:self.view.superview.frame.size.height - self.view.frame.size.height];
    } completion:^(BOOL finished) {
    }];
}

- (IBAction)press:(UIButton *)sender
{
    [self.delegate didPressKeyboard:sender.tag];
}

@end
