//
//  PCNationsViewController.m
//  Project C
//
//  Created by Wu Ziqi on 13-5-26.
//  Copyright (c) 2013年 Wu Ziqi. All rights reserved.
//

#import "PCNationsViewController.h"

@interface PCNationsViewController ()

@end

@implementation PCNationsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureScaleDownFlags];
	
}

- (void)configureScaleDownFlags
{
    float delay = 0.6f;
    int i = 0;

    for (UIView *view in self.view.subviews) {
        [UIView animateWithDuration:0.4f delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            view.transform = CGAffineTransformScale(view.transform, 0.2, 0.2);
        } completion:^(BOOL finished) {
        }];
        
        i++;
        if (i % 3 == 0) delay -= 0.2f;
    }
}

- (void)configureScaleUpFlags
{
    float delay = 0;
    int i = 0;
    
    for (UIView *view in self.view.subviews) {
        [UIView animateWithDuration:0.3f delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            view.transform = CGAffineTransformScale(view.transform, 5, 5);
        } completion:^(BOOL finished) {   
        }];
        
        i++;
        if (i % 3 == 0) delay += 0.2f;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)selectFlag:(UIButton *)sender
{
    [self.delegate didSelectNewNationFlag:sender.tag];
}
@end
