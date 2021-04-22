//
//  MockHTTPBinManagerDelegate.m
//  OperationPracticeTests
//
//  Created by Bing Guo on 2021/4/22.
//

#import "MockHTTPBinManagerDelegate.h"

@implementation MockHTTPBinManagerDelegate

- (instancetype)initWithExpection:(XCTestExpectation *)runningExpection cancelExpection:(XCTestExpectation *)cancelExpection {
    self = [super init];
    if (self) {
        self.runningExpection = runningExpection;
        self.cancelExpection = cancelExpection;
    }
    return self;
}

- (void)HTTPBinManager:(HTTPBinManager *)HTTPBinManager progress:(float)progress error:(NSError *)error {
    self.progress = progress;
    self.error = error;

    [_runningExpection fulfill];
}

- (void)HTTPBinManager:(HTTPBinManager *)HTTPBinManager didCancelOperationQueue:(NSOperationQueue *)queue {
    [_cancelExpection fulfill];
}

@end
