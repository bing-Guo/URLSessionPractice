//
//  NSMutableURLRequest+API.h
//  HttpbinFramework
//
//  Created by Bing Kuo on 2021/5/4.
//

#ifndef NSMutableURLRequest_API_h
#define NSMutableURLRequest_API_h

@interface NSMutableURLRequest(API)

+ (instancetype)APIRequestWithURL:(NSURL*)inURL method:(NSString *)inMethod;
+ (instancetype)APIRequestWithURL:(NSURL*)inURL method:(NSString *)inMethod header:(NSDictionary*)inHeader;
+ (instancetype)APIRequestWithURL:(NSURL*)inURL method:(NSString *)inMethod body:(NSDictionary*)inBody;
+ (instancetype)APIRequestWithURL:(NSURL*)inURL method:(NSString *)inMethod header:(NSDictionary*)inHeader body:(NSDictionary*)inBody;

@end

#endif /* NSMutableURLRequest_API_h */
