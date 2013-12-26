//
//  PCNationsViewController.h
//  Project C
//
//  Created by Wu Ziqi on 13-5-26.
//  Copyright (c) 2013年 Wu Ziqi. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol NationSelectionDelegate <NSObject>

- (void)didSelectNewNationFlag:(int)tag;

@end

@interface PCNationsViewController : UIViewController

@property (weak, nonatomic) id<NationSelectionDelegate> delegate;

- (void)configureScaleDownFlags;
- (void)configureScaleUpFlags;

- (IBAction)selectFlag:(UIButton *)sender;

@end
