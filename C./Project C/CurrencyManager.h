//
//  CurrencyManager.h
//  Currency
//
//  Created by Magic on 5/25/13.
//
//

#import <Foundation/Foundation.h>

@interface CurrencyManager : NSObject

+ (CurrencyManager *)defaultManager;

- (float)rateFrom:(NSString *)from to:(NSString *)to;
- (NSArray *)rateHistoryFrom:(NSString *)from to:(NSString *)to;

- (void)oneTimeInitialize;

@end
