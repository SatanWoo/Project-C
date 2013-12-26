//
//  PCViewController.h
//  Project C
//
//  Created by Wu Ziqi on 13-5-26.
//  Copyright (c) 2013年 Wu Ziqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *equalSetenceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *fromValue;
@property (weak, nonatomic) IBOutlet UILabel *toValue;
@property (weak, nonatomic) IBOutlet UIButton *fromButton;
@property (weak, nonatomic) IBOutlet UIButton *toButton;

- (IBAction)showNationView:(id)sender;

@end
