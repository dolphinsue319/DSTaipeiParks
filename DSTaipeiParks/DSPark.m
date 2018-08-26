//
//  DSPark.m
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/26.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import "DSPark.h"
#import "NSDictionary+DSCategory.h"

@implementation DSPark
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSParameterAssert(dictionary);
    if (self = [super init]) {
        _identifier = [dictionary stringForKey:@"_id" defaultString:@""];
        NSString *parkName = [dictionary stringForKey:@"ParkName" defaultString:@""];
        NSString *name = [dictionary stringForKey:@"Name" defaultString:@""];
        _parkName = [NSString stringWithFormat:@"%@-%@", parkName, name];
        _introduction = [dictionary stringForKey:@"Introduction" defaultString:@""];
        _imageURLString = [dictionary stringForKey:@"Image" defaultString:@""];
    }
    return self;
}
@end
