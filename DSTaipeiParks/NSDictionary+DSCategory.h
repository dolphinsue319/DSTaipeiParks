//
//  NSDictionary+DSCategory.h
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/26.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DSCategory)
- (nonnull NSString *)stringForKey:(nonnull NSString *)key defaultString:(nonnull NSString *)defaultString;
- (nullable NSArray *)arrayForKey:(nonnull NSString *)key;
@end
