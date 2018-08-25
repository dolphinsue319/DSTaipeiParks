//
//  DSURLSessionManager.h
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DSPark;

@interface DSURLSessionManager : NSObject

- (NSURLSessionDataTask *)fetchParksWithOffset:(NSUInteger)offset completion:(void (^)(NSArray <DSPark *> *parks, NSUInteger totalOfParks, NSError *error))callback;
@end
