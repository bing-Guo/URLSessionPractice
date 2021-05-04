//
//  Httpbin.m
//  HttpbinFramework
//
//  Created by Bing Guo on 2021/3/31.
//

#import <Foundation/Foundation.h>
#import "Httpbin.h"
#import "HTTPBinAPI.h"
#import "NSMutableURLRequest+API.h"

@implementation Httpbin

- (void)fetchGetResponseWithCallback:(void(^)(NSDictionary *, NSError *))callback {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/get"];

    NSURLSession *session = [[HTTPBinAPI shared] mainSession];
    NSMutableURLRequest *request = [NSMutableURLRequest APIRequestWithURL:url method:@"GET"];
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

- (void)postCustomerName:(NSString *)name callback:(void (^)(NSDictionary *dict, NSError *error))callback {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/post"];

    NSDictionary *bodyData = @{ @"custname" : name };
    NSURLSession *session = [[HTTPBinAPI shared] mainSession];
    NSMutableURLRequest *request = [NSMutableURLRequest APIRequestWithURL:url method:@"POST" body:bodyData];

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

- (void)fetchImageWithCallback:(void (^)(UIImage *, NSError *))callback {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/image/png"];

    NSURLSession *session = [[HTTPBinAPI shared] mainSession];
    NSMutableURLRequest *request = [NSMutableURLRequest APIRequestWithURL:url method:@"GET"];

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
