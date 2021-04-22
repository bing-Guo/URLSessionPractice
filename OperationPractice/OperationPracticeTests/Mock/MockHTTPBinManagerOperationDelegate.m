//
//  MockHTTPBinManagerOperationDelegate.m
//  OperationPracticeTests
//
//  Created by Bing Guo on 2021/4/22.
//

#import "MockHTTPBinManagerOperationDelegate.h"

@implementation MockHTTPBinManagerOperationDelegate

- (instancetype)initWithExpection:(XCTestExpectation *)expection {
    self = [super init];
    if (self) {
        self.expection = expection;
    }
    return self;
}

- (void)HTTPBinManagerOperation:(HTTPBinManagerOperation *)HTTPBinManagerOperation progress:(float)progress error:(NSError *)error {
    self.progress = progress;
    self.error = error;

    [_expection fulfill];
}

@end
