//
//  NSDictionary+DSCategory.m
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/26.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import "NSDictionary+DSCategory.h"

@implementation NSDictionary (DSCategory)
- (nonnull NSString *)stringForKey:(nonnull NSString *)key defaultString:(nonnull NSString *)defaultString
{
    if (![[self allKeys] containsObject:key]) {
        return defaultString;
    }
    return self[key];
}

@end
