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
    XCTestExpectation *expect = [self expectationWithDescription:@"Query timed out."];

    [api fetchGetResponseWithCallback:^(NSDictionary *dict, NSError *error) {
        NSString *url = dict[@"url"];
        NSMutableDictionary *argsDict = [dict valueForKey:@"args"];
        NSUInteger argsDictCount = [argsDict count];

        BOOL condition1 = [url isEqual:@"http://httpbin.org/get"];
        BOOL condition2 = (argsDictCount == 0);
        BOOL result = condition1 && condition2;

        XCTAssert(result,
                  @"An error occurred. URL: %@, argsDictCount: %lu",
                  url,
                  argsDictCount);

        [expect fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"An error occurred. error: %@", error);
    }];
}

- (void)testPostCustomerName {
    XCTestExpectation *except = [self expectationWithDescription:@"Query timed out."];

    NSString *name = @"hello_world";

    [api postCustomerName:name callback:^(NSDictionary *dict, NSError *error) {
        NSMutableDictionary *json = [dict valueForKey:@"json"];
        NSString *custname = json[@"custname"];

        BOOL result = [custname isEqualToString: name];

        XCTAssert(result, @"An error occurred. custname: %@", custname);

        [except fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"An error occurred. error: %@", error);
    }];
}

- (void)testFetchImageWithCallback {
    XCTestExpectation *except = [self expectationWithDescription:@"Query timed out."];

    [api fetchImageWithCallback:^(UIImage *image, NSError *error) {
        BOOL condition1 = (image != nil);
        BOOL condition2 = (error == nil);

        BOOL result = condition1 && condition2;

        XCTAssert(result, @"An error occurred. image: %@, error: %@",
                  image,
                  error);

        [except fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"An error occurred. error: %@", error);
    }];
}

@end
