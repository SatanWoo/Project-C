//
//  ChartViewController.m
//  Currency
//
//  Created by Magic on 5/25/13.
//
//

#import "ChartViewController.h"
#import "CurrencyManager.h"

@interface ChartViewController ()


@end

@implementation ChartViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chart_logo"]];
    [self customizeBackButton];
    
    [self configureView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]isDirectory:NO]]];
    
}

- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customizeBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,36,36);
    [button setBackgroundImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)configureView
{
    self.toCountryLabel.text = self.toCountryString;
    [self.toCountryLabel setFont:[UIFont fontWithName:@"TRENDS" size:25]];
    
    self.fromCountryLabel.text = self.fromCountryString;
    [self.fromCountryLabel setFont:[UIFont fontWithName:@"TRENDS" size:25]];
    
    self.fromImage.image = [UIImage imageNamed:self.fromCountryString];
    self.toImage.image = [UIImage imageNamed:self.toCountryString];
}

- (void)drawWebChart {
    
    NSArray *rateHistory = [[CurrencyManager defaultManager] rateHistoryFrom:self.fromCountryString to:self.toCountryString];
    
    NSMutableString *stringBuffer = [NSMutableString stringWithString:@""];
    
    for (NSDictionary *point in rateHistory) {
        [stringBuffer appendFormat:@"[Date.parse('%@'),%@],", point[@"date"], point[@"rate"]];
    }
    [stringBuffer deleteCharactersInRange:NSMakeRange(stringBuffer.length-1, 1)];
    
    
    
    NSString *jsFirstPart = @"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function drawChart() { "
    
    "$('#container').highcharts('StockChart', {"
    "rangeSelector : {enabled : false},"
    "navigator : { enabled : false },"
    "scrollbar : { enabled : false },"
    "chart : { backgroundColor : 'rgb(237,237,237)'  },"
    "series : [{  name : 'Rate',"
    "data : [";
    
    NSString *jsSecondPart = @"],"
    "tooltip: {valueDecimals: 2}}]});"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    
    
    NSString *result = [NSString stringWithFormat:@"%@%@%@", jsFirstPart, stringBuffer, jsSecondPart];
    
    [self.webView stringByEvaluatingJavaScriptFromString:result];
    


    
    [self.webView stringByEvaluatingJavaScriptFromString:@"drawChart();"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self drawWebChart];
}



@end
