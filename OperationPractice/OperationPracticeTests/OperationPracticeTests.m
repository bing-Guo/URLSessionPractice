//
//  OperationPracticeTests.m
//  OperationPracticeTests
//
//  Created by Bing Guo on 2021/4/21.
//

#import <XCTest/XCTest.h>
#import "HTTPBinManager.h"
#import "MockHTTPBinManagerDelegate.h"
#import "MockHTTPBinManagerOperationDelegate.h"

// MARK: - OperationPracticeTests

@interface OperationPracticeTests : XCTestCase

@end

@implementation OperationPracticeTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testHTTPBinManagerOperationCompleted {
    XCTestExpectation *expection = [self expectationWithDescription:@"Query timed out."];
    expection.expectedFulfillmentCount = 3;

    MockHTTPBinManagerOperationDelegate *mock = [[MockHTTPBinManagerOperationDelegate alloc] initWithExpection:expection];
    HTTPBinManagerOperation *operation = [[HTTPBinManagerOperation alloc] init];
    operation.delegate = mock;

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];

    float progress = mock.progress;
    NSError *error = mock.error;

    BOOL condition1 = (progress == 1.0f);
    BOOL condition2 = (error == nil);
    BOOL result = condition1 && condition2;

    XCTAssert(result, "An error occurred. progress: %f, error: %@",
              progress,
              error);
}

- (void)testHTTPBinManagerOperationCancel {
    XCTestExpectation *expection = [self expectationWithDescription:@"Query timed out."];
    expection.inverted = YES;

    MockHTTPBinManagerOperationDelegate *mock = [[MockHTTPBinManagerOperationDelegate alloc] initWithExpection:expection];
    HTTPBinManagerOperation *operation = [[HTTPBinManagerOperation alloc] init];
    operation.delegate = mock;

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    [operation cancel];

    [self waitForExpectationsWithTimeout:5.0 handler:nil];

    NSError *error = mock.error;

    BOOL condition1 = (operation.cancelled == YES);
    BOOL condition2 = (error == nil);
    BOOL result = condition1 && condition2;

    XCTAssert(result, "An error occurred. isCancelled: %d, error: %@",
              operation.cancelled,
              error);
}

- (void)testHTTPBinManagerCompleted {
    XCTestExpectation *expection = [self expectationWithDescription:@"Query timed out."];
    expection.expectedFulfillmentCount = 3;

    MockHTTPBinManagerDelegate *mock = [[MockHTTPBinManagerDelegate alloc] initWithExpection:expection cancelExpection:nil];
    HTTPBinManager *manager = [HTTPBinManager sharedInstance];
    manager.delegate = mock;

    [manager executeOperation];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];

    float progress = mock.progress;
    NSError *error = mock.error;

    BOOL condition1 = (progress == 1.0f);
    BOOL condition2 = (error == nil);
    BOOL result = condition1 && condition2;

    XCTAssert(result, "An error occurred. progress: %f, error: %@",
              progress,
              error);
}

- (void)testHTTPBinManagerCancel {
    XCTestExpectation *expection = [self expectationWithDescription:@"Cancel query timed out."];
    expection.expectedFulfillmentCount = 2;

    MockHTTPBinManagerDelegate *mock = [[MockHTTPBinManagerDelegate alloc] initWithExpection:nil cancelExpection:expection];
    HTTPBinManager *manager = [HTTPBinManager sharedInstance];
    manager.delegate = mock;

    [manager executeOperation];
    [manager cancelAllOperations];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
