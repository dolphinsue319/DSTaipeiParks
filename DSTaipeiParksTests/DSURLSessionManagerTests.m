//
//  DSTaipeiParksTests.m
//  DSTaipeiParksTests
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DSURLSessionManager.h"

@interface DSURLSessionManagerTests : XCTestCase
@property (nonatomic, strong) DSURLSessionManager *session;
@end

@implementation DSURLSessionManagerTests

- (void)setUp {
    [super setUp];
    _session = [[DSURLSessionManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTask {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"sessionTask"];
    NSURLSessionDataTask *task = [_session fetchParksWithOffset:0 completion:^(NSArray<DSPark *> *parks, NSError *error) {
        if (error) {
            XCTAssertNil(parks);
            [expectation fulfill];
            return;
        }
        XCTAssertNotNil(parks);
        XCTAssertTrue(parks.count > 0);
        [expectation fulfill];
    }];
    XCTAssertNotNil(task);
    [self waitForExpectations:@[expectation] timeout:10];
}

@end
