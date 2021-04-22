//
//  HTTPBinManager.m
//  OperationPractice
//
//  Created by Bing Guo on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import "HTTPBinManager.h"
#import "HTTPBinManagerOperation.h"

@implementation HTTPBinManager

+(instancetype) sharedInstance {
    static HTTPBinManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTTPBinManager alloc] initPrivate];
    });

    return instance;
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        self.queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

-(void)executeOperation {
    [self cancelAllOperations];

    operation = [[HTTPBinManagerOperation alloc] init];
    operation.delegate = self;

    [self.queue addOperation: operation];
}

-(void)cancelAllOperations {
    [self.queue cancelAllOperations];

    [operation cancel];

    [_delegate HTTPBinManager:self didCancelOperationQueue:_queue];
}

// MARK: - HTTPBinManagerOperationDelegate

- (void)HTTPBinManagerOperation:(HTTPBinManagerOperation *)HTTPBinManagerOperation progress:(float)progress error:(NSError *)error {
    [self.delegate HTTPBinManager:self progress:progress error:error];
}

@end
