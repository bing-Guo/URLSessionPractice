//
//  Httpbin.m
//  HttpbinFramework
//
//  Created by Bing Guo on 2021/3/31.
//

#import <Foundation/Foundation.h>
#import "Httpbin.h"

@implementation Httpbin

- (void)fetchGetResponseWithCallback:(void(^)(NSDictionary *, NSError *))callback {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/get"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:10.0];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            callback(NULL, error);
        } else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];

            callback(object, NULL);
        }
    }];

    [task resume];
}

- (void) postCustomerName:(NSString *)name callback:(void (^)(NSDictionary *dict, NSError *error))callback {
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

    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            callback(NULL, error);
        } else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];

            callback(object, NULL);
        }
    }];

    [task resume];
}

- (void) fetchImageWithCallback:(void (^)(UIImage *, NSError *))callback {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/image/png"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:10.0];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            callback(NULL, error);
        } else {
            UIImage *image = [UIImage imageWithData:data];

            callback(image, NULL);
        }
    }];

    [task resume];
}

@end
