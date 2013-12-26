//
//  CurrencyManager.m
//  Currency
//
//  Created by Magic on 5/25/13.
//
//

#import "CurrencyManager.h"

@implementation CurrencyManager

+ (CurrencyManager *)defaultManager
{
    static dispatch_once_t once;
    static CurrencyManager *defaultManager;
    dispatch_once(&once, ^ { defaultManager = [[self alloc] init]; });
    return defaultManager;
}

- (void)oneTimeInitialize
{
    NSDictionary *currencies = [[NSUserDefaults standardUserDefaults] objectForKey:@"USD"];
    if (!currencies) {
        
        [[NSUserDefaults standardUserDefaults] setFloat:1.0 forKey:@"USD"];
        [[NSUserDefaults standardUserDefaults] setFloat:6.1356 forKey:@"CNY"];
        [[NSUserDefaults standardUserDefaults] setFloat:0.6592 forKey:@"GBP"];
        [[NSUserDefaults standardUserDefaults] setFloat:1.0277 forKey:@"CAD"];
        [[NSUserDefaults standardUserDefaults] setFloat:102.35 forKey:@"JPY"];
        [[NSUserDefaults standardUserDefaults] setFloat:0.7746 forKey:@"EUR"];
        [[NSUserDefaults standardUserDefaults] setFloat:1.0199 forKey:@"AUD"];
        [[NSUserDefaults standardUserDefaults] setFloat:7.7608 forKey:@"HKD"];
        [[NSUserDefaults standardUserDefaults] setFloat:29.824 forKey:@"TWD"];
    }

}

- (float)rateFrom:(NSString *)from to:(NSString *)to
{
    
    float fromValue = [[NSUserDefaults standardUserDefaults] floatForKey:from];
    float toValue = [[NSUserDefaults standardUserDefaults] floatForKey:to];
   

    return toValue / fromValue;

}

- (NSArray *)rateHistoryFrom:(NSString *)from to:(NSString *)to
{
    NSString *fromJsonPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"USD%@", from] ofType:@"json"];
    NSDictionary *fromDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:fromJsonPath] options:NSJSONReadingMutableContainers error:nil];
    
    NSString *toJsonPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"USD%@", to] ofType:@"json"];
    NSDictionary *toDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:toJsonPath] options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *fromRateHistory = [fromDict[@"CrossRates"] valueForKey:@"First"];

    NSArray *toRateHistory = [toDict[@"CrossRates"] valueForKey:@"First"];
    
    NSArray *dates = [fromDict[@"CrossRates"] valueForKey:@"Date"];
    
    NSMutableArray *resultRateHistory = [NSMutableArray arrayWithCapacity:31];
    for (int i = 0; i < [fromRateHistory count]; i++) {
        NSNumber *fromNumber = fromRateHistory[i];
        NSNumber *toNumber = toRateHistory[i];
        
        NSDictionary *point = [NSDictionary dictionaryWithObjectsAndKeys:@([toNumber floatValue] / [fromNumber floatValue]), @"rate", dates[i], @"date", nil];
        
        [resultRateHistory insertObject:point atIndex:0];
    }
    
    return resultRateHistory;
}

@end
