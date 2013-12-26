//
//  PCViewController.m
//  Project C
//
//  Created by Wu Ziqi on 13-5-26.
//  Copyright (c) 2013年 Wu Ziqi. All rights reserved.
//

#import "PCViewController.h"
#import "PCNationsViewController.h"
#import "PCKeyboardViewController.h"
#import "UIView+Frame.h"
#import "CurrencyManager.h"
#import "ChartViewController.h"

#define kNationViewController @"kNationViewController"
#define kPCKeyboardViewController @"kPCKeyboardViewController"
#define KNavigationBar 44
#define kFirstFlag 20
#define kSecondFlag 30

@interface PCViewController () <PCKeyboardDelegate, NationSelectionDelegate>

@property (nonatomic, strong) PCNationsViewController *nationViewController;
@property (nonatomic, strong) PCKeyboardViewController *keyboardViewController;
@property (nonatomic, strong) NSArray *countryArray;
@property (nonatomic, strong) NSMutableString *fromValueString;
@property (nonatomic, strong) NSString *fromCountryString;
@property (nonatomic, strong) NSString *toCountryString;
@property (nonatomic, assign) bool isNationViewShowed;
@property (nonatomic, assign) int currentSelectedFlag;

@end

@implementation PCViewController
@synthesize nationViewController = _nationViewController;
@synthesize keyboardViewController = _keyboardViewController;
@synthesize isNationViewShowed = _isNationViewShowed;
@synthesize countryArray = _countryArray;

- (NSArray *)countryArray
{
    if (_countryArray == nil) {
        _countryArray = [NSArray arrayWithObjects:@"CNY", @"JPY", @"EUR",  @"USD", @"GBP", @"CAD", @"AUS", @"HKD", @"TWD", nil];
    }
    return _countryArray;
}

- (PCNationsViewController *)nationViewController
{
    if (_nationViewController == nil) {
        _nationViewController =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:kNationViewController];
        _nationViewController.delegate = self;
    }
    return _nationViewController;
}

- (PCKeyboardViewController *)keyboardViewController
{
    if (_keyboardViewController == nil) {
        _keyboardViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:kPCKeyboardViewController];
        _keyboardViewController.delegate = self;
    }
    return _keyboardViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentSelectedFlag = kFirstFlag;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    
    [self configureNavigationBar];
    [self configureNationView];
    [self configureKeyboardView];
    [self configureInputView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)configureNavigationBar
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_background"] forBarMetrics:UIBarMetricsDefault];
}

- (void)configureNationView
{
    [self.nationViewController.view resetOriginY:self.view.frame.size.height - self.nationViewController.view.frame.size.height - KNavigationBar];
    [self.view addSubview:self.nationViewController.view];
}

- (void)configureKeyboardView
{    
    [self.keyboardViewController.view resetOriginY:self.view.frame.size.height - self.keyboardViewController.view.frame.size.height - KNavigationBar];
    [self.view addSubview:self.keyboardViewController.view];
}

- (void)configureInputView
{
    [self.toButton setAutoresizingMask:UIViewAutoresizingNone];
    [self.toButton setImage:[UIImage imageNamed:@"CNY"] forState:UIControlStateNormal];
    
    [self.fromButton setAutoresizingMask:UIViewAutoresizingNone];
    [self.fromButton setImage:[UIImage imageNamed:@"USD"] forState:UIControlStateNormal];
    
    self.fromValueString = [NSMutableString stringWithString:@""];
    self.fromCountryString = @"USD";
    self.toCountryString = @"CNY";
    
    [self updateSentence];
}

- (IBAction)showNationView:(id)sender
{
    self.currentSelectedFlag = ((UIButton *)sender).tag;
    
    if (self.isNationViewShowed)
        [self showKeyboard];
    else
        [self hideKeyboard];
    
    self.isNationViewShowed = !self.isNationViewShowed;
}

- (void)showKeyboard
{
    [self.keyboardViewController showKeyboard];
    [self.nationViewController configureScaleDownFlags];
}

- (void)hideKeyboard
{
    [self.keyboardViewController hideKeyboard];
    [self.nationViewController configureScaleUpFlags];
}

#pragma mark - PCKeyboardDelegate
- (void)didPressKeyboard:(int)keyCode
{
    if (keyCode == 12) {//delete
        if (self.fromValueString.length >= 1) {
            
            if ([self.fromValueString characterAtIndex:self.fromValueString.length-1] == '.') {
                [self.keyboardViewController.dotKey setEnabled:YES];
            }
            
            [self.fromValueString deleteCharactersInRange:NSMakeRange(self.fromValueString.length-1, 1)];
        }
        
        
        
    }
    else if (keyCode == 10) {//dot clicked
        NSRange indexOfDot = [self.fromValueString rangeOfString:@"."];
        
        if (indexOfDot.location == NSNotFound) {
            [self.fromValueString appendString:@"."];
            [self.keyboardViewController.dotKey setEnabled:NO];
        }
        
    }
    else {//digit clicked
        [self.fromValueString appendString:[NSString stringWithFormat:@"%d", keyCode]];
    }
    
    [self updateValue];
    
}

- (void)didSelectNewNationFlag:(int)tag
{
    NSString *countryName = [self getName:tag];
    
    if (self.currentSelectedFlag == kFirstFlag) {
        [self.fromButton setImage:[UIImage imageNamed:countryName] forState:UIControlStateNormal];
        self.fromCountryString = countryName;
    } else {
        [self.toButton setImage:[UIImage imageNamed:countryName] forState:UIControlStateNormal];
        self.toCountryString = countryName;
    }
    
    if (![self.fromValueString isEqualToString:@""]) [self updateValue];
    
    [self updateSentence];
    [self showKeyboard];
    self.isNationViewShowed = FALSE;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"rateHistory"]) {
        ChartViewController *chartVC = (ChartViewController *)segue.destinationViewController;
        
        chartVC.toCountryString = self.toCountryString;
        chartVC.fromCountryString = self.fromCountryString;
    }
}

- (NSString *)getName:(int)tag
{
    return [self.countryArray objectAtIndex:tag];
}

- (void)updateValue
{
    float fromFloatValue = [self.fromValueString floatValue];
    float toFloatValue = fromFloatValue * [[CurrencyManager defaultManager] rateFrom:self.fromCountryString to:self.toCountryString];
    self.fromValue.text = self.fromValueString;
    [self.fromValue setFont:[UIFont fontWithName:@"TRENDS" size:30]];
    
    self.toValue.text = [NSString stringWithFormat:@"%.2f", toFloatValue];
    [self.toValue setFont:[UIFont fontWithName:@"TRENDS" size:30]];
}

- (void)updateSentence
{
    NSLog(@"caoniamde");
    float rate = [[CurrencyManager defaultManager] rateFrom:self.fromCountryString to:self.toCountryString];
    self.equalSetenceLabel.text =
    [NSString stringWithFormat:@"1 %@ ≈ %.2f %@", self.fromCountryString, rate, self.toCountryString];
    [self.equalSetenceLabel setFont:[UIFont fontWithName:@"TRENDS" size:17]];
}

@end
