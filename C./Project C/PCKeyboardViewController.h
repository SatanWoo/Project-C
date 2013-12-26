//
//  PCKeyboardViewController.h
//  Project C
//
//  Created by Wu Ziqi on 13-5-26.
//  Copyright (c) 2013年 Wu Ziqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"

@protocol PCKeyboardDelegate <NSObject>
- (void)didPressKeyboard:(int)keyCode;
@end

@interface PCKeyboardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *keyboardBGImageView;
@property (weak, nonatomic) id<PCKeyboardDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *dotKey;

- (void)hideKeyboard;
- (void)showKeyboard;

- (IBAction)press:(id)sender;
@end
