//
//  DSParksTableViewControlViewModel.m
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import "DSParksTableViewControlViewModel.h"
#import "DSURLSessionManager.h"
#import "DSPark.h"

@interface DSParksTableViewControlViewModel()
@property (nonatomic, strong) DSURLSessionManager *session;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, assign) BOOL isMoreParks;
@end

@implementation DSParksTableViewControlViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _session = [[DSURLSessionManager alloc] init];
        _parks = [NSMutableArray array];
    }
    return self;
}

- (void)fetchParks
{
    if (_task) {
        [_task cancel];
        _task = nil;
    }
    _task = [_session fetchParksWithOffset:self.parks.count completion:^(NSArray<DSPark *> *parks, NSUInteger totalOfParks, NSError *error) {
        self.task = nil;
        if (error) {
            [self.delegate parksTableViewModelDidFetchFailed:self];
            return;
        }
        
        for (DSPark *park in parks) {
            if ([self.parks containsObject:park]) {
                [self.delegate parksTableViewModelDidFetchFailed:self];
                return;
            }
        }
        
        [self.parks addObjectsFromArray:parks];
        [self.delegate parksTableViewModelDidUpdateParks:self];
        self.isMoreParks = totalOfParks != self.parks.count;
    }];
}
@end
