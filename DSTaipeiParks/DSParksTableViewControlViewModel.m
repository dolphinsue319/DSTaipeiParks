//
//  DSParksTableViewControlViewModel.m
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import "DSParksTableViewControlViewModel.h"
#import "DSURLSessionManager.h"

@interface DSParksTableViewControlViewModel()
@property (nonatomic, strong) NSMutableDictionary *queuedTasks;
@end

@implementation DSParksTableViewControlViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _parks = [NSMutableArray array];
        _queuedTasks = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)fetchParksWithOffset:(NSUInteger)offset
{
    DSURLSessionManager *session = [[DSURLSessionManager alloc] init];
    NSURLSessionDataTask *task = [session fetchParksWithOffset:offset completion:^(NSArray<DSPark *> *parks, NSError *error) {
        
    }];
}
@end
