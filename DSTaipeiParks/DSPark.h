//
//  DSPark.h
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/26.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSPark : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *parkName;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *imageURLString;
@end
