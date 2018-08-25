//
//  DSParksTableViewControlViewModel.h
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DSPark;

typedef NS_ENUM(NSUInteger, DSParksTableViewControlViewModelStatus) {
    DSParksTableViewControlViewModelStatusFetching = 0,
    DSParksTableViewControlViewModelStatusSucceed,
    DSParksTableViewControlViewModelStatusFailed
};

@protocol DSParksTableViewControlViewModelDelegate<NSObject>
@required
- (void)parksTableViewModelDidUpdateParks;
@end

@interface DSParksTableViewControlViewModel : NSObject
@property (nonatomic, readonly) DSParksTableViewControlViewModelStatus status;
@property (nonatomic, strong) NSMutableArray *parks;
- (void)fetchParksWithOffset:(NSUInteger)offset;
@end
