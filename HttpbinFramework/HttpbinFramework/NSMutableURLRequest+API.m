//
//  NSMutableURLRequest+API.m
//  HttpbinFramework
//
//  Created by Bing Kuo on 2021/5/4.
//

#import <Foundation/Foundation.h>
#import "HTTPBinAPI.h"

@implementation NSMutableURLRequest(API)
+ (instancetype)APIRequestWithURL:(NSURL*)inURL method:(NSString *)inMethod {
    NSMutableURLRequest *request = [self APIRequestWithURL:inURL method:inMethod header:[HTTPBinAPI shared].defaultHeader];
    
    return request;
}

+ (instancetype)APIRequestWithURL:(NSURL*)inURL method:(NSString *)inMethod header:(NSDictionary*)inHeader {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:inURL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:[HTTPBinAPI shared].defaultTimeout];
    [request setHTTPMethod:inMethod];
    
    for (NSString *key in inHeader) {
        NSString *value = inHeader[key];
        [request addValue:value forHTTPHeaderField:key];
    }
    
    return request;
}

+ (instancetype)APIRequestWithURL:(NSURL*)inURL method:(NSString *)inMethod body:(NSDictionary*)inBody {
    NSMutableURLRequest *request = [self APIRequestWithURL:inURL method:inMethod header:[HTTPBinAPI shared].defaultHeader];
    [request setHTTPMethod:inMethod];
    
    if (inBody) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:inBody options:kNilOptions error:NULL];
    }
    return request;
}

+ (instancetype)APIRequestWithURL:(NSURL*)inURL method:(NSString *)inMethod header:(NSDictionary*)inHeader body:(NSDictionary*)inBody {
    NSMutableURLRequest *request = [self APIRequestWithURL:inURL method:inMethod header:inHeader];
    [request setHTTPMethod:inMethod];
    
    if (inBody) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:inBody options:kNilOptions error:NULL];
    }
    return request;
}
@end
