//
//  HTTPBinManagerOperation.m
//  OperationPractice
//
//  Created by Bing Guo on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import "HTTPBinManagerOperation.h"
#import "HttpbinFramework/HttpbinFramework.h"

@implementation HTTPBinManagerOperation

-(void)main {
    @autoreleasepool {
        Httpbin *api = [[Httpbin alloc] init];

        self.semaphore = dispatch_semaphore_create(0);
        [api fetchGetResponseWithCallback:^(NSDictionary *dictionary, NSError *error) {
            if(self.cancelled) {
                return;
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate HTTPBinManagerOperation:self progress:0.33f error:error];
            });

            dispatch_semaphore_signal(self.semaphore);
        }];
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);


        self.semaphore = dispatch_semaphore_create(0);
        [api postCustomerName:@"hello_world" callback:^(NSDictionary *dictionary, NSError *error) {
            if(self.cancelled) {
                return;
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate HTTPBinManagerOperation:self progress:0.66f error:error];
            });

            dispatch_semaphore_signal(self.semaphore);
        }];
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);


        self.semaphore = dispatch_semaphore_create(0);
        [api fetchImageWithCallback:^(UIImage *image, NSError *error) {
            if(self.cancelled) {
                return;
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate HTTPBinManagerOperation:self progress:1.0f error:error];
            });

            dispatch_semaphore_signal(self.semaphore);
        }];
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    }
}

-(void)cancel {
    [super cancel];

    if (self.semaphore != nil) {
        dispatch_semaphore_signal(self.semaphore);
    }
}

@end
