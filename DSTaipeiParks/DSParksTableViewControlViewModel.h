//
//  DSParksTableViewControlViewModel.h
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DSPark;
@class DSParksTableViewControlViewModel;

@protocol DSParksTableViewControlViewModelDelegate<NSObject>
@required
- (void)parksTableViewModelDidUpdateParks:(DSParksTableViewControlViewModel *)viewModel;
- (void)parksTableViewModelDidFetchFailed:(DSParksTableViewControlViewModel *)viewModel;
@end

@interface DSParksTableViewControlViewModel : NSObject
@property (nonatomic, weak) id<DSParksTableViewControlViewModelDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *parks;
@property (nonatomic, readonly) BOOL isMoreParks;

- (void)fetchParks;
@end
