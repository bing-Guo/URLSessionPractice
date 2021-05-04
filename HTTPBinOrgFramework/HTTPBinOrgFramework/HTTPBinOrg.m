#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HTTPBinOrg.h"

@implementation HTTPBinOrg

NSURLSessionTask *fetchGetResponseTask;
NSURLSessionTask *postCustomerNameTask;
NSURLSessionTask *fetchImageWithCallbackTask;

- (void)fetchGetResponse {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/get"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:10.0];

    NSURLSession *session = [NSURLSession sharedSession];

    if (fetchGetResponseTask != nil && fetchGetResponseTask.state == NSURLSessionTaskStateRunning) {
        [fetchGetResponseTask cancel];
    }

    fetchGetResponseTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            [self.delegate HTTPBinOrg:self dictionaryForGet:NULL error:error];
        } else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];

            [self.delegate HTTPBinOrg:self dictionaryForGet:object error:NULL];
        }
    }];

    [fetchGetResponseTask resume];
}

- (void)postCustomerName:(NSString *)name {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/post"];
    NSError *error;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:10.0];

    NSMutableDictionary *mapData = [[NSMutableDictionary alloc] init];
    [mapData setValue:name forKey:@"custname"];

    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:NSJSONWritingPrettyPrinted error:&error];
    [request setHTTPBody:postData];

    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{ @"Content-Type"  : @"application/json" };
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];

    if (postCustomerNameTask != nil && postCustomerNameTask.state == NSURLSessionTaskStateRunning) {
        [postCustomerNameTask cancel];
    }

    postCustomerNameTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            [self.delegate HTTPBinOrg:self dictionaryForPostName:NULL error:error];
        } else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];

            [self.delegate HTTPBinOrg:self dictionaryForPostName:object error:NULL];
        }
    }];

    [postCustomerNameTask resume];
}

- (void)fetchImageWithCallback {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/image/png"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:10.0];

    NSURLSession *session = [NSURLSession sharedSession];

    if (fetchImageWithCallbackTask != nil && fetchImageWithCallbackTask.state == NSURLSessionTaskStateRunning) {
        [fetchImageWithCallbackTask cancel];
    }

    fetchImageWithCallbackTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            [self.delegate HTTPBinOrg:self image:NULL error:error];
        } else {
            UIImage *image = [UIImage imageWithData:data];

            [self.delegate HTTPBinOrg:self image:image error:NULL];
        }
    }];

    [fetchImageWithCallbackTask resume];
}

@end
