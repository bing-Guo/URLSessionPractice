//
//  MockHTTPBinManagerOperationDelegate.h
//  OperationPracticeTests
//
//  Created by Bing Guo on 2021/4/22.
//

#import <XCTest/XCTest.h>
#import "HTTPBinManagerOperation.h"
#import "HTTPBinManagerOperationDelegate.h"

#ifndef MockHTTPBinManagerOperationDelegate_h
#define MockHTTPBinManagerOperationDelegate_h

@interface MockHTTPBinManagerOperationDelegate : NSObject <HTTPBinManagerOperationDelegate>

@property XCTestExpectation *expection;
@property float progress;
@property NSError *error;

- (instancetype) initWithExpection:(XCTestExpectation *)expection;

@end


#endif /* MockHTTPBinManagerOperationDelegate_h */
