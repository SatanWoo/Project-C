//
//  ChartViewController.h
//  Currency
//
//  Created by Magic on 5/25/13.
//
//

#import <UIKit/UIKit.h>


@interface ChartViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *fromCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *toCountryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *toImage;
@property (weak, nonatomic) IBOutlet UIImageView *fromImage;

@property (nonatomic, strong) NSString *fromCountryString;
@property (nonatomic, strong) NSString *toCountryString;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
