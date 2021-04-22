//
//  HTTPBinOrgFrameworkTests.m
//  HTTPBinOrgFrameworkTests
//
//  Created by Bing Guo on 2021/4/18.
//

#import <XCTest/XCTest.h>
#import "HTTPBinOrgFramework/HTTPBinOrgFramework.h"

// MARK: - MockHTTPBinOrg

@interface MockHTTPBinOrg : NSObject <HTTPBinOrgDelegate>

@property XCTestExpectation *expection;
@property NSDictionary *dictionary;
@property UIImage *image;
@property NSError *error;

@end

@implementation MockHTTPBinOrg

- (instancetype)initWithException:(XCTestExpectation *)expection
{
    self = [super init];
    if (self) {
        _expection = expection;
    }
    return self;
}

- (void)HTTPBinOrg:(HTTPBinOrg *)httpbin dictionaryForGet:(NSDictionary *)dictionary error:(NSError *)error {
    _dictionary = dictionary;
    _error = error;

    [_expection fulfill];
}

- (void)HTTPBinOrg:(HTTPBinOrg *)httpbin dictionaryForPostName:(NSDictionary *)dictionary error:(NSError *)error {
    _dictionary = dictionary;
    _error = error;

    [_expection fulfill];
}

- (void)HTTPBinOrg:(HTTPBinOrg *)httpbin image:(UIImage *)image error:(NSError *)error {
    _image = image;
    _error = error;

    [_expection fulfill];
}

@end

// MARK: - HTTPBinOrgFrameworkTests

@interface HTTPBinOrgFrameworkTests : XCTestCase

@end

@implementation HTTPBinOrgFrameworkTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFetchGetResponse {
    XCTestExpectation *expect = [self expectationWithDescription:@"Query timed out."];

    HTTPBinOrg *api = [[HTTPBinOrg alloc] init];
    MockHTTPBinOrg *mock = [[MockHTTPBinOrg alloc] initWithException:expect];

    api.delegate = mock;

    [api fetchGetResponse];

    [self waitForExpectationsWithTimeout:10 handler:nil];

    NSError *err = mock.error;
    NSDictionary *dict = mock.dictionary;

    NSString *url = dict[@"url"];
    NSMutableDictionary *argsDict = [dict valueForKey:@"args"];
    NSUInteger argsDictCount = [argsDict count];

    BOOL condition1 = [url isEqual:@"http://httpbin.org/get"];
    BOOL condition2 = (argsDictCount == 0);
    BOOL condition3 = (err == nil);
    BOOL result = condition1 && condition2 && condition3;

    XCTAssert(result,
              @"An error occurred. result: %d, URL: %@, argsDictCount: %lu, err: %@",
              result,
              url,
              argsDictCount,
              err);
}

- (void)testPostCustomerName {
    XCTestExpectation *expection = [self expectationWithDescription:@"Query timed out."];

    HTTPBinOrg *api = [[HTTPBinOrg alloc] init];
    MockHTTPBinOrg *mock = [[MockHTTPBinOrg alloc] initWithException:expection];

    api.delegate = mock;

    NSString *name = @"hello_world";
    [api postCustomerName:name];

    [self waitForExpectationsWithTimeout:10 handler:nil];

    NSError *err = mock.error;
    NSDictionary *dict = mock.dictionary;

    NSMutableDictionary *json = [dict valueForKey:@"json"];
    NSString *custname = json[@"custname"];

    BOOL condition1 = [custname isEqualToString:name];
    BOOL condition2 = (err == nil);
    BOOL result = condition1 && condition2;

    XCTAssert(result,
              @"An error occurred. result: %d, custname: %@, err: %@",
              result,
              custname,
              err);
}

- (void)testFetchImageWithCallback {
    XCTestExpectation *expection = [self expectationWithDescription:@"Query timed out."];

    HTTPBinOrg *api = [[HTTPBinOrg alloc] init];
    MockHTTPBinOrg *mock = [[MockHTTPBinOrg alloc] initWithException:expection];

    api.delegate = mock;

    [api fetchImageWithCallback];

    [self waitForExpectationsWithTimeout:10 handler:nil];

    NSError *err = mock.error;
    UIImage *image = mock.image;

    BOOL condition1 = (image != nil);
    BOOL condition2 = (err == nil);
    BOOL result = condition1 && condition2 ;

    XCTAssert(result,
              @"An error occurred. result: %d, image: %@, err: %@",
              result,
              image,
              err);
}

@end
