//
//  HTTPBinOrgFrameworkTests.m
//  HTTPBinOrgFrameworkTests
//
//  Created by Bing Guo on 2021/4/18.
//

#import <XCTest/XCTest.h>
#import "HTTPBinOrgFramework/HTTPBinOrgFramework.h"

// MARK: - HTTPBinOrgMock
@interface HTTPBinOrgMock : NSObject <HTTPBinOrgDelegate>

@property XCTestExpectation *expect;
@property NSDictionary *dictionary;
@property NSError *error;

@end

@implementation HTTPBinOrgMock

- (instancetype)initWithExcept:(XCTestExpectation *)expect
{
    self = [super init];
    if (self) {
        _expect = expect;
    }
    return self;
}

- (void)HTTPBinOrg:(HTTPBinOrg *)httpbin dictionaryForGet:(NSDictionary *)dictionary error:(NSError *)error {
    _dictionary = dictionary;
    _error = error;

    [_expect fulfill];
}

- (void)HTTPBinOrg:(HTTPBinOrg *)httpbin dictionaryForPostName:(NSDictionary *)dictionary error:(NSError *)error {
    _dictionary = dictionary;
    _error = error;

    [_expect fulfill];
}

- (void)HTTPBinOrg:(HTTPBinOrg *)httpbin image:(UIImage *)image error:(NSError *)error {
    [_expect fulfill];
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
    XCTestExpectation *expect = [self expectationWithDescription:@"Timeout."];

    HTTPBinOrg *api = [[HTTPBinOrg alloc] init];
    HTTPBinOrgMock *mock = [[HTTPBinOrgMock alloc] initWithExcept:expect];

    api.delegate = mock;

    [api fetchGetResponse];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if(error == nil) {
            NSDictionary *dict = mock.dictionary;

            BOOL condition1 = [dict[@"url"] isEqual:@"http://httpbin.org/get"];

            NSMutableDictionary *argsDict = [dict valueForKey:@"args"];
            NSMutableDictionary *headersDict = [dict valueForKey:@"headers"];
            BOOL condition2 = ([argsDict count] == 0);

            BOOL result = condition1 && condition2;

            XCTAssert(result,
                      @"Occurred error. fetchGetResponseDict: %@, headersDict: %@, result: %d, condition1: %@, condition2: %lu",
                      dict,
                      headersDict,
                      result,
                      dict[@"url"],
                      (unsigned long)[argsDict count]);
        } else {
            NSLog(@"Timeout!");
            XCTAssert(NO);
        }
    }];
}

@end
