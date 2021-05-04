//
//  HTTPBinAPI.m
//  HttpbinFramework
//
//  Created by Bing Kuo on 2021/5/4.
//

#import <Foundation/Foundation.h>
#import "HTTPBinAPI.h"

@implementation HTTPBinAPI

+ (HTTPBinAPI *)shared {
    static HTTPBinAPI *instance = nil;
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^{
        instance = [[HTTPBinAPI alloc] initPrivate];
    });
    
    return instance;
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        self.mainSession = [NSURLSession sharedSession];
    }
    return self;
}

- (NSDictionary *)defaultHeader {
    return @{@"Content-Type":@"application/json"};
}

- (float)defaultTimeout {
    return 10.0f;
}

@end
