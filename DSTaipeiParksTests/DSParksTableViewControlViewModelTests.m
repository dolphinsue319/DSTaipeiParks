//
//  DSParksTableViewControlViewModelTests.m
//  DSTaipeiParksTests
//
//  Created by Dolphin Su on 2018/8/26.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DSParksTableViewControlViewModel.h"

@interface DSParksTableViewControlViewModelTests : XCTestCase <DSParksTableViewControlViewModelDelegate>
@property (nonatomic, strong) DSParksTableViewControlViewModel *viewModel;
@property (nonatomic, strong) XCTestExpectation *expectation;
@property (nonatomic, strong) XCTestExpectation *expectationForMoreParks;
@property (nonatomic, assign) NSUInteger numberOfParks;
@end

@implementation DSParksTableViewControlViewModelTests

- (void)setUp {
    [super setUp];
    _viewModel = [[DSParksTableViewControlViewModel alloc] init];
    XCTAssertNotNil(_viewModel.parks);
    _numberOfParks = 0;
    _viewModel.delegate = self;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchParks {
    _expectation = [[XCTestExpectation alloc] initWithDescription:@"testFetchParks"];
    [_viewModel fetchParks];
    [self waitForExpectations:@[_expectation] timeout:10];
}

- (void)parksTableViewModelDidUpdateParks:(DSParksTableViewControlViewModel *)viewModel
{
    if (_numberOfParks == 0) {
        XCTAssertTrue(_viewModel.parks.count == 30);
        _numberOfParks = _viewModel.parks.count;
        [_expectation fulfill];
        return;
    }
    
    if (_numberOfParks == 30) {
        XCTAssertTrue(_viewModel.parks.count == 60);
        _numberOfParks = _viewModel.parks.count;
        [_expectationForMoreParks fulfill];
        return;
    }
    
    _expectationForMoreParks = [[XCTestExpectation alloc] initWithDescription:@"testFetchMoreParks"];
    [_viewModel fetchParks];
    [self waitForExpectations:@[_expectationForMoreParks] timeout:10];
    
}

- (void)parksTableViewModelDidFetchFailed:(DSParksTableViewControlViewModel *)viewModel
{
    XCTFail(@"parksTableViewModelDidFetchFailed");
    [_expectation fulfill];
}
@end
