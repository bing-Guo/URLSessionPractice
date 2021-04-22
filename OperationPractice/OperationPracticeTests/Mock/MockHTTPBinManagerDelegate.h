//
//  MockHTTPBinManagerDelegate.h
//  OperationPracticeTests
//
//  Created by Bing Guo on 2021/4/22.
//

#import <XCTest/XCTest.h>
#import "HTTPBinManager.h"
#import "HTTPBinManagerDelegate.h"

#ifndef MockHTTPBinManagerDelegate_h
#define MockHTTPBinManagerDelegate_h

@interface MockHTTPBinManagerDelegate : NSObject <HTTPBinManagerDelegate>

@property XCTestExpectation *runningExpection;
@property XCTestExpectation *cancelExpection;
@property float progress;
@property NSError *error;

- (instancetype) initWithExpection:(XCTestExpectation *)runningExpection cancelExpection:(XCTestExpectation *)cancelExpection;

@end

#endif /* MockHTTPBinManagerDelegate_h */
