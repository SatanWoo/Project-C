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
    [UIView animateWithDuration:0.6f animations:^{
        [self.view resetOriginY:460];
    }];
}

- (void)showKeyboard
{
    [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseOut animations:^{
         [self.view resetOriginY:171];
    } completion:^(BOOL finished) {
    }];
}

- (IBAction)press:(UIButton *)sender
{
    [self.delegate didPressKeyboard:sender.tag];
}

@end
