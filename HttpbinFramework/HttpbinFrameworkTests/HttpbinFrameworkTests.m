//
//  HttpbinFrameworkTests.m
//  HttpbinFrameworkTests
//
//  Created by Bing Guo on 2021/3/31.
//

#import <XCTest/XCTest.h>
#import "HttpbinFramework/HttpbinFramework.h"

@interface HttpbinFrameworkTests : XCTestCase

@end

@implementation HttpbinFrameworkTests

Httpbin *api;

- (void)setUp {
    [super setUp];

    api = [Httpbin new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFetchGetResponse {
    XCTestExpectation *expect = [self expectationWithDescription:@"Timeout."];

    [api fetchGetResponseWithCallback:^(NSDictionary *dict, NSError *error) {
        BOOL condition1 = [dict[@"url"] isEqual:@"http://httpbin.org/get"];

        NSMutableDictionary *argsDict = [dict valueForKey:@"args"];
        BOOL condition2 = ([argsDict count] == 0);

        BOOL result = condition1 && condition2;

        XCTAssert(result,
                  @"Occurred error. condition1: %@, condition2: %lu",
                  dict[@"url"],
                  (unsigned long)[argsDict count]);

        [expect fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"Timeout.");
    }];
}

- (void)testPostCustomerName {
    XCTestExpectation *except = [self expectationWithDescription:@"Timeout."];

    NSString *name = @"bing";

    [api postCustomerName:name callback:^(NSDictionary *dict, NSError *error) {
        NSMutableDictionary *json = [dict valueForKey:@"json"];

        BOOL result = [json[@"custname"] isEqual: name];

        XCTAssert(result, @"Occurred error. json: %@",json[@"custname"]);

        [except fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"Timeout.");
    }];
}

@end
