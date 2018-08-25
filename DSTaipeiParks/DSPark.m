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
        _parkName = [dictionary stringForKey:@"ParkName" defaultString:@""];
        _introduction = [dictionary stringForKey:@"Introduction" defaultString:@""];
        _imageURLString = [dictionary stringForKey:@"Image" defaultString:@""];
    }
    return self;
}
@end
